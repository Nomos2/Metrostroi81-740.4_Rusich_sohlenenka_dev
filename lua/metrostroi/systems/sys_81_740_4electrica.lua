--------------------------------------------------------------------------------
-- 81-720 electric schemes
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2018 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_740_4ELECTRICA")
TRAIN_SYSTEM.DontAccelerateSimulation = false	

local function Clamp(val,min,max)
    return math.max(min,math.min(max,val))
end

local function Rand(a,b) 
	return a+(b-a)*math.random()
end

local function sign(x)
	return (x>0 and 1 or x < 0 and -1 or 0)
end

function TRAIN_SYSTEM:Initialize()

    -- General power output
    self.Main750V = 0.0
    self.Aux750V = 0.0
    self.Power750V = 0.0
    self.Aux80V = 0.0
    self.Lights80V = 0.0
    self.Battery80V = 0.0
	
	
    self.Power = 0
    self.States = {}
    self.Commands = {}


    self.DriveTimer = CurTime()

    self.CurTime = CurTime()
    self.TimerMode = CurTime()

    self.R1 = 1e1
    self.R2 = 1e1
    self.R3 = 1e1
    self.Rs1 = 1e1
    self.Rs2 = 1e1

    self.Rstator13 = 1e1
    self.Rstator24 = 1e1
    self.Ranchor13  = 1e1
    self.Ranchor24  = 1e1

    -- Electric network info
    self.Itotal = 0.0
    self.I13 = 0.0
    self.I24 = 0.0
	self.Ustator13 = 0.0
    self.Ustator24 = 0.0
    self.Ishunt13  = 0.0
    self.Istator13 = 0.0
    self.Ishunt24  = 0.0
    self.Istator24 = 0.0
    self.Utotal = 0.0
    -- Calculate current through rheostats 1, 2
    self.IR1 = self.Itotal
    self.IR2 = self.Itotal
    self.IRT2 = self.Itotal
    self.T1 = 25
    self.T2 = 25
    self.P1 = 0
    self.P2 = 0
    self.Overheat1 = 0
    self.Overheat2 = 0
	
    -- Total energy used by train
    self.ElectricEnergyUsed = 0 -- joules
    self.ElectricEnergyDissipated = 0 -- joules
    self.EnergyChange = 0

    --Train wire outside power
    -- Need many iterations for engine simulation to converge
    self.SubIterations = 16

    self.Train:LoadSystem("BV","Relay")
    self.Train:LoadSystem("GV","Relay","GV_10ZH",{bass=true})
    -- Thyristor contrller
    self.Brake = 0
    self.Drive = 0
    self.DriveStrength = 0
	self.Recurperation = 0
    self.Iexit = 0
    self.Chopper = 0
    self.IChopper = 0
	
    self.BTB = 0
    self.KTR = 0
    self.V2 = 0
    self.V1 = 0
    self.BVKA_KM1 = 0
    self.BVKA_KM2 = 0
    self.BVKA_KM3 = 0
    self.BVKA_KM4 = 0
    self.BVKA_KM5 = 0
    self.Vent2 = 0
    self.BSKA = 0

	self.BPTI_V = 0
    self.BPTI_ZKK = 0

    self.BUTP = 0
    self.ISet = 0
	
	self.Slope = 0
	self.command = 0
    self.commandTimer = 0

    --self.Train:LoadSystem("Telemetry",nil,"",{"Electric","Panel","Engines"})
end


function TRAIN_SYSTEM:Inputs()
    return { }
end

function TRAIN_SYSTEM:Outputs()
    return { "I13","I24","Itotal","Brake", "Drive",
        --[[
                    "Rs1","Rs2","Itotal","I13","I24","IRT2",
                 "Ustator13","Ustator24","Ishunt13","Istator13","Ishunt24","Istator24",
                 "Uanchor13","Uanchor24","U13","U24","Utotal","RVState",--]]
             "Main750V", "Power750V", "Aux750V", "Aux80V", "Lights80V", "Battery80V", --[[
             "ElectricEnergyUsed", "ElectricEnergyDissipated", "EnergyChange",
             "RPSignalResistor"]]
             "RNState", "RN",
             "BTB","V2","V1",
             "BVKA_KM1","BVKA_KM2","BVKA_KM3","BVKA_KM4","BVKA_KM5",
             "Vent2",
			 "BSKA","BPTI_V","BPTI_ZKK","BUTP","ISet",
             "Recurperation","Itotal","Iexit","IChopped","Chopper","IChopper","ElectricEnergyUsed","ElectricEnergyDissipated","EnergyChange" 
        }
end

TRAIN_SYSTEM.CurrentConfig = {
	{
		[1] = 150,
		[2] = 200,
		[3] = 260,
		[4] = 320,
		[0] = 0,
		[-1]= 150,
		[-2]= 200,
		[-3]= 320,
	},
	{
		[1] = 0.67,
		[2] = 0.69,
		[3] = 0.77,
		[4] = 0.79,
		[0] = 0,
		[-1]= 0.55,
		[-2]= 0.60,
		[-3]= 0.85,
	},
}

local S = {}
local function C(x) return x and 1 or 0 end
local min,max,abs = math.min,math.max,math.abs

function TRAIN_SYSTEM:TriggerInput(name,value)

end

--------------------------------------------------------------------------------
function TRAIN_SYSTEM:Think(dT,iter)
    local Train = self.Train
    local Async = Train.AsyncInverter
	local BUV = Train.BUV
    --  local dT = dT/8
    ----------------------------------------------------------------------------
    -- Voltages from the third rail
    ----------------------------------------------------------------------------
    self.Main750V = Train.TR.Main750V
    self.Aux750V  = Train.TR.Main750V
    self.Power750V = self.Main750V*Train.GV.Value

	if not Async then return end

    ----------------------------------------------------------------------------
    -- Information only
    ----------------------------------------------------------------------------
    local BBE = Train.BUV.BBE > 0
    self.Aux80V = BBE and 82 or 65
    self.Lights80V = BBE and 82 or 0--Train.PowerSupply.XT3_4

    self.Battery80V = (Train.Battery.Value > 0) and (BBE and 82 or 65) or 0
    Train:WriteTrainWire(1,self.Battery80V > 62 and 1 or 0)

    ----------------------------------------------------------------------------
    -- Some internal electric
    ----------------------------------------------------------------------------
    local P = self.Battery80V > 62 and 1 or 0
    local HV = 550 < self.Main750V and self.Main750V < 975 and 1 or 0
    --(RV)
    local Panel = Train.Panel
    if Train.KV then
        local RV = Train.KV
        Train:WriteTrainWire(2,P*Train.SF19.Value*Train.EnableBVEmer.Value)
        Train:WriteTrainWire(34,P*(RV["KRO1-2"]*Train.SF2.Value + RV["KRR1-2"]*Train.SF3.Value))
        Train:WriteTrainWire(36,Train.SF3.Value*Train.EmergencyControls.Value)
		--local Drive = Train.BARS.Drive
        Train:WriteTrainWire(19,P*RV["KRR7-8"]*Train.SF10.Value*Train.BARS.BTB*Train.EmerX1.Value)
        Train:WriteTrainWire(45,P*RV["KRR7-8"]*Train.SF10.Value*Train.BARS.BTB*Train.EmerX2.Value)
        Train:WriteTrainWire(3,P*(RV["KRO9-10"]+RV["KRR7-8"])*Train.SF10.Value)
        Train:WriteTrainWire(4,0)
        local KM1 = P*Train.SF6.Value*RV["KRO11-12"]
        local KM2 = P*Train.SF6.Value*RV["KRO15-16"]
        Train:WriteTrainWire(11,P*Train.ParkingBrake.Value)
        Train:WriteTrainWire(12,P*(RV["KRR3-4"]+KM1)*Train.SF11.Value)
        Train:WriteTrainWire(13,P*(RV["KRR9-10"]+KM2)*Train.SF11.Value)
		Train:WriteTrainWire(46,P*Train.Vent2.Value)
        self.V2 = P*(RV["KRO13-14"]*Train.SF19.Value + RV["KRR11-12"]*Train.SF20.Value)
        self.V1 = P*(RV["KRO13-14"]*Train.SF19.Value + RV["KRR11-12"]*Train.SF20.Value)*Train.HornB.Value

        local BTBp = P*(RV["KRO13-14"]*Train.SF19.Value + RV["KRR11-12"]*Train.SF20.Value)*(1-Train.Pneumatic.SD2)
        Train:WriteTrainWire(27,BTBp)
        local BTBm = (Train.BARS.BTB+Train.ALS.Value*(Train.BARSBlock.Value==3 and 1 or 0))
        local BTB = math.min(1,BTBp*BTBm)
        Panel.EmerBrakeWork = BTB*Train.EmerBrake.Value
        Train:WriteTrainWire(28,Panel.EmerBrakeWork)
        --BTB KT KO Logic
        if Panel.EmerBrakeWork > 0 then
            if Train.EmerBrakeAdd.Value > 0 and not self.KT then
                self.KTR = math.min(3,self.KTR + 1)
                self.KT = true
            elseif Train.EmerBrakeAdd.Value == 0 then
                self.KT = false
            end
            if Train.EmerBrakeRelease.Value > 0 and not self.KO then
                self.KTR = math.max(0,self.KTR - 1)
                self.KO = true
            elseif Train.EmerBrakeRelease.Value == 0 then
                self.KO = false
            end
            Train:WriteTrainWire(29,self.KTR>1 and 1 or 0)
            Train:WriteTrainWire(30,self.KTR>0 and 1 or 0)
        else
            if self.KTR > 0 then self.KTR = 0 end
            Train:WriteTrainWire(29,0)
            Train:WriteTrainWire(30,0)
        end
        --[[ Train:WriteTrainWire(24,BTB*(1-Train.EmergencyBrake.Value))
        Train:WriteTrainWire(25,BTB == 0 and Train:ReadTrainWire(26) > 0 and Train:ReadTrainWire(24)*self.BTB or 0)
        Train:WriteTrainWire(26,BTB*(Train.BARS.BTB))
        if Train:ReadTrainWire(26) > 0 and Train:ReadTrainWire(24) == 0 then self.BTB = 0 elseif Train:ReadTrainWire(26) == 0 then self.BTB = 1 end--]]

        if BTB > 0 then
            if self.BTBTimer == nil then self.BTBTimer = CurTime() end
            if self.BTBTimer and CurTime()-self.BTBTimer>0.3 then self.BTBTimer = false end
        else
            self.BTBTimer = nil
        end
        self.BTB = math.min(1,(self.BTBTimer~=false and 1 or 0)+self.BTB*Train:ReadTrainWire(26))
        Train:WriteTrainWire(26,(1-BTB)*Train:ReadTrainWire(24)*(1-Train.EmergencyBrake.Value))
        Train:WriteTrainWire(24,BTB*(1-Train.EmergencyBrake.Value))
        Train:WriteTrainWire(25,BTB*self.BTB*(self.KTR==3 and 0 or 1))
        Train:WriteTrainWire(10,P*Train.EmergencyCompressor.Value)

        Train:WriteTrainWire(40,P*Train.EmergencyDoors.Value)
        Train:WriteTrainWire(39,P*Train.SF22.Value*Train.EmerCloseDoors.Value)
        Train:WriteTrainWire(38,P*Train.SF21.Value*Train.DoorLeft.Value)
        Train:WriteTrainWire(37,P*Train.SF21.Value*Train.DoorRight.Value)

        local ASNP_VV = Train.ASNP_VV
        Panel.R_Announcer = P*Train.SF8.Value*Train.R_Announcer.Value
        Panel.R_Line = P*Train.SF8.Value*Panel.R_Announcer*Train.R_Line.Value
        ASNP_VV.Power = P*Train.SF8.Value*Train.R_ASNPOn.Value
        ASNP_VV.AmplifierPower = ASNP_VV.Power*Train.ASNP.LineOut*(1-Train.R_Line.Value)
        Train:WriteTrainWire(20,ASNP_VV.AmplifierPower)
        --ASNP_VV.CabinSpeakerPower = ASNP_VV.Power*Train.ASNP.LineOut*Train.R_G.Value
        Panel.DoorLeft = P*Train.SF21.Value*Train.DoorSelectL.Value*(1-Train.DoorSelectR.Value)
        Panel.DoorRight = P*Train.SF21.Value*Train.DoorSelectR.Value*(1-Train.DoorSelectL.Value)
        Panel.DoorClose = P*Train.SF22.Value*Train.DoorClose.Value
        Panel.DoorBlock = P*Train.DoorBlock.Value
        Panel.Ticker = P*Train.SF8.Value*Train.Ticker.Value
        Panel.PassScheme = P*Train.SF8.Value*Train.PassScheme.Value
        Train:WriteTrainWire(15,Panel.Ticker)
        Train:WriteTrainWire(16,Panel.PassScheme)
        Panel.PassSchemeControl = Panel.PassScheme*(RV["KRO9-10"]+RV["KRR7-8"])*Train.SF10.Value
        Panel.KAH = P*Train.KAH.Value
        Panel.ALS = P*Train.ALS.Value
		Panel.TPT = P*Train.TPT.Value
		Panel.Wiper = P*Train.Wiper.Value		
        --Panel.AccelRate = P*Train.AccelRate.Value
        Panel.EqLights = P*Train.SF15.Value*Train.AppLights1.Value		
        Panel.CabLights = P*Train.SF15.Value*Train.CabLight.Value*(0.5+Train.CabLightStrength.Value*0.5)

        Panel.Headlights1 = P*(RV["KRO3-4"]+RV["KRR5-6"])*Train.Headlights1.Value*Train.SF12.Value
        Panel.Headlights2 = P*(RV["KRO3-4"]+RV["KRR5-6"])*Train.Headlights2.Value*Train.SF13.Value
        Panel.RedLights = P*(RV["KRO7-8"]+RV["KRR9-10"])*Train.SF14.Value
        Panel.CBKIPower = P*Train.SF7.Value
    end
    Panel.PCBKPower = P*Train.SFV10.Value
    Panel.AnnouncerPlaying = Train:ReadTrainWire(20)*Train.SFV16.Value
    Panel.TickerPower = P*Train.SFV30.Value
    Panel.TickerWork = Panel.TickerPower*Train:ReadTrainWire(15)
    Panel.PassSchemePower = P*Train.SFV16.Value
    Panel.PassSchemeWork = Panel.PassSchemePower*Train:ReadTrainWire(16)
    self.BVKA_KM1 = P*HV*Train.SFV11.Value*(Train.BUV.MK+Train:ReadTrainWire(10))
    local KM2 = P*(Train:ReadTrainWire(34)*Train.SFV4.Value + Train:ReadTrainWire(36)*Train.SFV5.Value)*Train.SFV1.Value
    if self.BVKA_KM2 ~= KM2 then
        if self.BVKA_KM2 == 0 then
            Train:PlayOnce("batt_on","bass",1)
        end
        self.BVKA_KM2 = KM2
    end
	
		local command = BUV.Strength or 0--+0.5*(BUV.Strength > 0 and BUV.Slope1 and 1 or 0)
	local speed = Async.Speed -- Turbostroi acceleration enabled
	--local speed = Train.Speed -- Turbostroi acceleration disabled
	if self.command ~= command and CurTime()-self.commandTimer > (0.3+(command ~= 0 and speed > 2 and sign(command) ~= sign(self.command) and 0.6 or 0)) then
		self.commandTimer = CurTime()
		self.command = command
	end

	Async:TriggerInput("Power",P*(Train.SFV27 and Train.Battery.Value*Train.SFV27.Value or 1)*Train.GV.Value*Train.BV.Value*(Train.TR.Main750V > 975 and 0 or 1))--*(1-BUKV.DisableTP))
	--print(string.format("%.2f %.2f %d %.2f",command,Async.Speed,Async.Mode,Async.Torque))
	if self.command > 0 then--and Train.GV.Value*Train.BV.Value == 1 then--and Train.BV.Value > 0 and Train.AsyncInverter.Drive == 0 and Train.TR.Main750V > 20 then
		Async:TriggerInput("Drive",self.command)
		Async:TriggerInput("Brake",0)
	elseif self.command < 0 then--and Train.GV.Value*Train.BV.Value == 1 then--and Train.AsyncInverter.Brake == 0 then
		Async:TriggerInput("Drive",0)
		Async:TriggerInput("Brake",abs(self.command))
	else
		Async:TriggerInput("Drive",0)
		Async:TriggerInput("Brake",0)		
	end		
    --local speed = (command <= 0 and math.abs(Async.Speed) or math.max(9.6,math.abs(Async.Speed)))
	local targetI,k = self.CurrentConfig[1][self.command],self.CurrentConfig[2][self.command]
    if self.command > 0 then
		Async:TriggerInput("TargetCurrent",targetI*(1+(self.Slope == 1 and 0.1 or Train.Pneumatic.WeightLoadRatio*0.1))*((1-k)+k*Clamp((speed-3)/16,0,1)))--*(0.22+0.78*Clamp((speed-3)/14,0,1)))--*(speed > 50 and 1-(speed-50)/150 or 1) )--*(speed < 20 and 0.23+Clamp(speed/22,0,1)*0.77 or 1))--330
    elseif self.command < 0 then
		Async:TriggerInput("TargetCurrent",targetI*(1+(self.Slope == 1 and 0.1 or Train.Pneumatic.WeightLoadRatio*0.1))*((1-k)+k*Clamp((speed-3)/22,0,1)))--*Clamp((speed-2)/18,0,1))--*(Clamp(speed/30,0,1)+(speed < 10 and 0.035 or 0) ))--330
    else
        Async:TriggerInput("TargetCurrent",0)
    end
	self.EnergyChange = Async.Mode>0 and (Async.Current^2)*2.2 or 0
    self.Itotal = Async.Current
    --[[ if self.Main750V > 900 or Async.Mode>0 then
        self.Recurperation = false
    elseif self.Main750V < 875 and Async.Mode<0 then
    end--]]
    if Async.Mode<0 and Async.State>0 then
		self.Recurperation = C(self.Power750V > 749 and self.Power750V < 925)*BUV.Recurperation
        self.Iexit = self.Iexit+(-(Async.Current)*0.85*self.Recurperation-self.Iexit)*dT*2
        --if (self.Power750V < 550 or self.Power750V > 915) then self.Chopper = 1 end
        self.Chopper = 1-self.Recurperation
        self.IChopper = self.IChopper+(-(Async.Current)*0.85*self.Chopper-self.IChopper)*dT*2
    else
        self.Recurperation = 0
        self.Iexit = 0
        self.Chopper = 0
        self.IChopper = 0
    end		
	
    self.BVKA_KM4 = P*HV*Train.SFV24.Value*(Train.BUV.Vent2)
    self.BVKA_KM5 = P
    self.BSKA = P*Train.SFV6.Value*self.BVKA_KM2

    self.Vent2 = P*Train.SFV26.Value*self.BVKA_KM4

    self.BPTI_V = P*Train.SFV27.Value*self.BVKA_KM5
    self.BPTI_ZKK = P*Train.SFV28.Value

    local emer = Train:ReadTrainWire(45)+Train:ReadTrainWire(19)
    self.BUTP = P*self.BVKA_KM2*Train.SFV3.Value*Train.SFV6.Value

    --Train:WriteTrainWire(12,RV["KRO9-10"]*Train.SF10.Value)
    --Train:WriteTrainWire(13,RV["KRO9-10"]*Train.SF10.Value)
    ----------------------------------------------------------------------------
    -- Solve circuits
    ----------------------------------------------------------------------------
    local bv = Train.BV.Value
    local strength,brake,drive = 0,0,0
    if emer > 0 then
        strength = Train:ReadTrainWire(45) > 0 and 4 or Train:ReadTrainWire(19) > 0 and 2 or 0
        drive = strength*bv
    else
        brake = Train.BUV.Brake
        drive = Train.BUV.Drive*bv
        strength = Train.BUV.DriveStrength
    end
	local Current = math.abs(self.I13 + self.I24)/2
end
