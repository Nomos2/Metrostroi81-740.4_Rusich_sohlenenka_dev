include("shared.lua")

--------------------------------------------------------------------------------
ENT.ClientProps = {}
ENT.ButtonMap = {}
ENT.AutoAnims = {}
ENT.ClientSounds = {}

ENT.ClientPropsInitialized = false
ENT.ButtonMap["PVZ"] = {
    pos = Vector(654,52,-12), --446 -- 14 -- -0,5
    ang = Angle(0,-90,90),
    width = 330,
    height = 350,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "SFV1Toggle",x=0*30, y=0, w=30,h=50, tooltip = "",},
        {ID = "SFV2Toggle",x=1*30, y=0, w=30,h=50, tooltip = "",},
        {ID = "SFV3Toggle",x=2*30, y=0, w=30,h=50, tooltip = "",},
        {ID = "SFV4Toggle",x=3*30, y=0, w=30,h=50, tooltip = "",},
        {ID = "SFV5Toggle",x=4*30, y=0, w=30,h=50, tooltip = "",},
        {ID = "SFV6Toggle",x=5*30, y=0, w=30,h=50, tooltip = "",},
        {ID = "SFV7Toggle",x=6*30, y=0, w=30,h=50, tooltip = "",},
        {ID = "SFV8Toggle",x=7*30, y=0, w=30,h=50, tooltip = "",},
        {ID = "SFV9Toggle",x=8*30, y=0, w=30,h=50, tooltip = "",},
        {ID = "SFV10Toggle",x=9*30, y=0, w=30,h=50, tooltip = "",},
        {ID = "SFV11Toggle",x=10*30, y=0, w=30,h=50, tooltip = ""},

        {ID = "SFV12Toggle",x=0*30, y=150, w=30,h=50, tooltip = "",},
        {ID = "SFV13Toggle",x=1*30, y=150, w=30,h=50, tooltip = "",},
        {ID = "SFV14Toggle",x=2*30, y=150, w=30,h=50, tooltip = "",},
        {ID = "SFV15Toggle",x=3*30, y=150, w=30,h=50, tooltip = "",},
        {ID = "SFV16Toggle",x=4*30, y=150, w=30,h=50, tooltip = "",},
        {ID = "SFV17Toggle",x=5*30, y=150, w=30,h=50, tooltip = "",},
        {ID = "SFV18Toggle",x=6*30, y=150, w=30,h=50, tooltip = "",},
        {ID = "SFV19Toggle",x=7*30, y=150, w=30,h=50, tooltip = "",},
        {ID = "SFV20Toggle",x=8*30, y=150, w=30,h=50, tooltip = "",},
        {ID = "SFV21Toggle",x=9*30, y=150, w=30,h=50, tooltip = "",},
        {ID = "SFV22Toggle",x=10*30, y=150, w=30,h=50, tooltip = ""},

        {ID = "SFV24Toggle",x=0*30, y=300, w=30,h=50, tooltip = "",},
        {ID = "SFV26Toggle",x=1*30, y=300, w=30,h=50, tooltip = "",},
        {ID = "SFV27Toggle",x=2*30, y=300, w=30,h=50, tooltip = "",},
        {ID = "SFV28Toggle",x=3*30, y=300, w=30,h=50, tooltip = "",},
        {ID = "SFV29Toggle",x=4*30, y=300, w=30,h=50, tooltip = "",},
        {ID = "SFV30Toggle",x=5*30, y=300, w=30,h=50, tooltip = "",},
        {ID = "SFV31Toggle",x=6*30, y=300, w=30,h=50, tooltip = "",},
        {ID = "SFV32Toggle",x=7*30, y=300, w=30,h=50, tooltip = "",},
        {ID = "SFV33Toggle",x=8*30, y=300, w=30,h=50, tooltip = ""},
    }
}
for k,buttbl in ipairs(ENT.ButtonMap["PVZ"].buttons) do
    buttbl.model = {
        model = "models/metrostroi_train/81-720/button_av1.mdl",z=-16, ang=-90,
        var=buttbl.ID:Replace("Toggle",""),speed=9, vmin=0,vmax=1,
        sndvol = 0.8, snd = function(val) return val and "av_on" or "av_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
    }
end
ENT.ButtonMap["Battery"] = {
    pos = Vector(650,-18.11,-5), --446 -- 14 -- -0,5
    ang = Angle(0,180,90),
    width = 30,
    height = 30,
    scale = 0.0625,

    buttons = {
        {ID = "BatteryToggle",x=0, y=0, w=30,h=30   , tooltip = "", model = {
            model = "models/metrostroi_train/81-717/battery_enabler.mdl",
            var="Battery",speed=0.5,vmin=1,vmax=0.8,
            sndvol = 0.8, snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["RearDoor"] = {
    pos = Vector(-654,-15,54.2), ---334.8,14.5,9
    ang = Angle(0,90,90),
    width = 642,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "RearDoor",x=0,y=0,w=642,h=2000, tooltip="", model = {
            var="RearDoor",sndid="door_cab_b",
            sndvol = 1, snd = function(val) return val and "door_cab_open" or "door_cab_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,180,0),
        }},
    }
}
ENT.ButtonMap["FrontDoor"] = {
    pos = Vector(654,15,55), ---334.8,14.5,9
    ang = Angle(0,-90,90),
    width = 642,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "FrontDoor",x=0,y=0,w=642,h=2000, tooltip="Передняя дверь\nFront door", model = {
            var="FrontDoor",sndid="door_cab_f",
            sndvol = 1, snd = function(val) return val and "door_cab_open" or "door_cab_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,180,0),
        }},
    }
}

ENT.ClientProps["krepezh"] = {
    model = "models/metrostroi_train/81-740/body/krepezh.mdl",
    pos = Vector(195,0,16),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["lamps_salon_on"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on.mdl", 
    pos = Vector(379,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_off"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_off.mdl",
    pos = Vector(379,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["handrails_offside_front"] = {
    model = "models/metrostroi_train/81-741/body/741_body_additional_front.mdl",
    pos = Vector(127,0,-80),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ButtonMap["Tickers"] = {
    pos = Vector(35.9, -27.5, 66.0), --446 -- 14 -- -0,5
    ang = Angle(0,90,90),
    width = 1024,
    height = 64,
    scale = 0.0545,
    hide=true,
    hideseat=1,
}
ENT.ButtonMap["GV"] = {
    pos = Vector(364,-55,-73),
    ang = Angle(0,200,135),
    width = 170,
    height = 150,
    scale = 0.1,
    buttons = {
        {ID = "GVToggle",x=0, y=0, w= 170,h = 150, tooltip="Разъединитель БРУ (ГВ)", model = {
            var="GV",sndid = "gv_wrench",
            sndvol = 0.8,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            snd = function(val) return val and "gv_f" or "gv_b" end,
        }},
    }
}
ENT.ClientProps["gv"] = {
    model = "models/metrostroi/81-717/gv.mdl",
    pos = Vector(364.2,-55,-76),
    ang = Angle(-90,90,-90),
    color = Color(150,255,255),
    hide = 0.5,
}

ENT.ClientProps["gv_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ClientProps["gv"].pos,
    ang = Angle(-90,90,-90),
    hide = 0.5,
}
ENT.ButtonMap["FrontPneumatic"] = {
    pos = Vector(660,-35.0,-45),
    ang = Angle(0,90,90),
    width = 700,
    height = 100,
    scale = 0.1,
    hideseat=0.2,
    hide=true,
    screenHide = true,

    buttons = {
        {ID = "FrontBrakeLineIsolationToggle",x=0, y=0, w=300, h=100, tooltip="Концевой кран тормозной магистрали"},
        {ID = "FrontTrainLineIsolationToggle",x=400, y=0, w=300, h=100, tooltip="Концевой кран напорной магистрали"},
    }
}
ENT.ClientProps["FrontBrake"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(660, -20, -56.5),    --Vector(310, -23, -55) - старое значение
    ang = Angle(15,-90,0),
    hide = 2,
}
ENT.ClientProps["FrontTrain"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(660, 20, -56.5), --Vector(310, 23, -55), - старое значение
    ang = Angle( -15,-90,0),
    hide = 2,
}
for i=0,3 do
    ENT.ClientProps["TrainNumberR"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(635-i*6.6+4*6.6/2,-63.35,18),
        ang = Angle(0,0,-5),
        skin=0,
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end 
ENT.ClientSounds["FrontBrakeLineIsolation"] = {{"FrontBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["FrontTrainLineIsolation"] = {{"FrontTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}

ENT.ClientProps["door_cab_f"] = {
		model = "models/metrostroi_train/81-741/body/door_br.mdl",
		pos = Vector(657,-14.4,8.5),
		ang = Angle(0,270,0.1),
		--skin = self:GetNWInt("skin_skin_body", 0),
		hide=2,
}
	
ENT.ClientProps["salon"] = {
		model = "models/metrostroi_train/81-741/salon/salon.mdl",
		pos = Vector(322.6,0,0),
		ang = Angle(0,180,0),
		--skin = self:GetNWInt("skin_skin_interior", 0),
		hide=2,
}
ENT.ClientProps["handrails"] = {
		model = "models/metrostroi_train/81-741/salon/handrails/handrails.mdl",
		pos = Vector(325.8,0,0),
		ang = Angle(0,-180,0),
		--skin = self:GetNWInt("skin_skin_interior", 0),
		hide=1,
}
	
--Задняя часть
ENT.ClientProps["krepezh1"] = {
    model = "models/metrostroi_train/81-741/body/krepezh1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
	nohide=true,
	callback = function(ent,cl_ent)
		local FakeCouple = ent:GetNW2Entity("FakeCouple")
		if not IsValid(FakeCouple) then
			ent:ShowHide("krepezh1",false)
			return
		end
		cl_ent:SetParent(FakeCouple) --выдача родителя.
		
		cl_ent:SetPos(FakeCouple:GetPos(Vector(0, 0, 0)))
		
		local ang = FakeCouple:GetAngles() --поворот XYZ (настраивается через верхние строки)
		cl_ent:SetAngles(Angle(ang.x, ang.y, ang.z))
		end,
}
ENT.ClientProps["handrails_offside"] = {
    model = "models/metrostroi_train/81-741/body/741_body_additional.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
		callback = function(ent,cl_ent)
		local FakeCouple = ent:GetNW2Entity("FakeCouple")
		if not IsValid(FakeCouple) then
			ent:ShowHide("handrails_offside",false)
			return
		end
		cl_ent:SetParent(FakeCouple) --выдача родителя.
		
		cl_ent:SetPos(FakeCouple:GetPos(Vector(0, 0, 0)))
		
		local ang = FakeCouple:GetAngles() --поворот XYZ (настраивается через верхние строки)
		cl_ent:SetAngles(Angle(ang.x, -180+ang.y, ang.z))
		end,
}
ENT.ClientProps["lamps_salon_on1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
		callback = function(ent,cl_ent)
		local FakeCouple = ent:GetNW2Entity("FakeCouple")
		if not IsValid(FakeCouple) then
			ent:ShowHide("lamps_salon_on1",false)
			return
		end
		cl_ent:SetParent(FakeCouple) --выдача родителя.
		
		cl_ent:SetPos(FakeCouple:GetPos(Vector(0, 45, 0)))
		
		local ang = FakeCouple:GetAngles() --поворот XYZ (настраивается через верхние строки)
		cl_ent:SetAngles(Angle(ang.x, ang.y, ang.z))
		end,
}
ENT.ClientProps["lamps_salon_off1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_off_rear.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
	callback = function(ent,cl_ent)
		local FakeCouple = ent:GetNW2Entity("FakeCouple")
		if not IsValid(FakeCouple) then
			ent:ShowHide("lamps_salon_off1",false)
			return
		end
		cl_ent:SetParent(FakeCouple) --выдача родителя.
		
		cl_ent:SetPos(FakeCouple:GetPos(Vector(0, 45, 0)))
		
		local ang = FakeCouple:GetAngles() --поворот XYZ (настраивается через верхние строки)
		cl_ent:SetAngles(Angle(ang.x, ang.y, ang.z))
		end,
}

ENT.ButtonMap["RearPneumatic"] = {
    pos = Vector(-661,35,-43),
    ang = Angle(180,90,270),
    width = 700,
    height = 100,
    scale = 0.1,
    hideseat=0.2,
    hide=true,
    screenHide = true,

    buttons = {
        {ID = "RearTrainLineIsolationToggle",x=400, y=0, w=300, h=100, tooltip="Концевой кран тормозной магистрали"},
        {ID = "RearBrakeLineIsolationToggle",x=000, y=0, w=300, h=100, tooltip="Концевой кран напорной магистрали"},
    }
}
ENT.ClientProps["RearTrain"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(-660, -23, -56),
    ang = Angle(-15,90,0),
    hide = 2,
			callback = function(ent,cl_ent)
		local FakeCouple = ent:GetNW2Entity("FakeCouple") --телега в виде родителя, ибо ГМ не видит физический объект кузова.
		cl_ent:SetParent(FakeCouple) --выдача родителя.
		
		local pos = FakeCouple:GetPos() --позиция XYZ (настраивается через верхние строки)
		cl_ent:GetPos(Vector(pos.x, pos.y, pos.z))
		
		local ang = FakeCouple:GetAngles() --поворот XYZ (настраивается через верхние строки)
		cl_ent:GetAngles(Angle(ang.x, ang.y, ang.z))
         ent.WagonNumber = false
        end,
    }
ENT.ClientProps["RearBrake"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(-660, 23, -56),
    ang = Angle( 15,90,0),
    hide = 2,
		callback = function(ent,cl_ent)
		local FakeCouple = ent:GetNW2Entity("FakeCouple") --телега в виде родителя, ибо ГМ не видит физический объект кузова.
		cl_ent:SetParent(FakeCouple) --выдача родителя.
		
		local pos = FakeCouple:GetPos() --позиция XYZ (настраивается через верхние строки)
		cl_ent:GetPos(Vector(pos.x, pos.y, pos.z))
		
		local ang = FakeCouple:GetAngles() --поворот XYZ (настраивается через верхние строки)
		cl_ent:GetAngles(Angle(ang.x, ang.y, ang.z))
         ent.WagonNumber = false
        end,
    }
ENT.ClientSounds["RearBrakeLineIsolation"] = {{"RearBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["RearTrainLineIsolation"] = {{"RearTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
for i=0,3 do
    ENT.ClientProps["TrainNumberL"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(-635+i*6.6-4*6.6/2, 64.5, 18),
        ang = Angle(0,180,-3.29),
        skin=1,
        hide = 1.5,
		callback = function(ent,cl_ent)
		local FakeCouple = ent:GetNW2Entity("FakeCouple")
		cl_ent:SetParent(FakeCouple) --выдача родителя.
		
		local pos = FakeCouple:GetPos() --позиция XYZ (настраивается через верхние строки)
		cl_ent:GetPos(Vector(pos.x, pos.y, pos.z))
		
		local ang = FakeCouple:GetAngles() --поворот XYZ (настраивается через верхние строки)
		cl_ent:GetAngles(Angle(ang.x, ang.y, ang.z))
         ent.WagonNumber = false
        end,
    }
end
ENT.ClientProps["handrails1"] = {
		model = "models/metrostroi_train/81-741/salon/handrails/handrails_rear.mdl",
		pos = Vector(0,0,0),
		ang = Angle(0,0,0),
		--skin = self:GetNWInt("skin_skin_interior", 0),
		hide=2,
		callback = function(ent,cl_ent)
		local FakeCouple = ent:GetNW2Entity("FakeCouple")
		if not IsValid(FakeCouple) then
			ent:ShowHide("salon1",false)
			return
		end
		cl_ent:SetParent(FakeCouple) --выдача родителя.
		
		cl_ent:SetPos(FakeCouple:GetPos(Vector(0, 0, 0)))
		
		local ang = FakeCouple:GetAngles() --поворот XYZ (настраивается через верхние строки)
		cl_ent:SetAngles(Angle(ang.x, ang.y, ang.z))
		end,
}

ENT.ClientProps["salon1"] = {
		model = "models/metrostroi_train/81-741/salon/salon_rear.mdl",
		pos = Vector(0,0,0),
		ang = Angle(0,0,0),
		--skin = self:GetNWInt("skin_skin_interior", 0),
		hide=2,
		callback = function(ent,cl_ent)
		local FakeCouple = ent:GetNW2Entity("FakeCouple")
		if not IsValid(FakeCouple) then
			ent:ShowHide("salon1",false)
			return
		end
		cl_ent:SetParent(FakeCouple) --выдача родителя.
		
		cl_ent:SetPos(FakeCouple:GetPos(Vector(0, 0, 0)))
		
		local ang = FakeCouple:GetAngles() --поворот XYZ (настраивается через верхние строки)
		cl_ent:SetAngles(Angle(ang.x, -180+ang.y, ang.z))
		end,
}
ENT.ButtonMap["Tickers_rear"] = {
    pos = Vector(-37,27.5,66), --446 -- 14 -- -0,5
    ang = Angle(0,-90,90),
    width = 1024,
    height = 64,
    scale = 0.0545,
    hide=true,
    hideseat=1,
}
--------------------------------------------------------------------------------
-- Add doors
--------------------------------------------------------------------------------
local function GetDoorPosition(i,k,j)
	if j == 0 
	then return Vector(592 - 35.0*k     - 232.5*i,-67.5*(1-2*k),4)
	else return Vector(592 - 35.0*(1-k) - 232.5*i,-66*(1-2*k),4)
	end
end
local function GetDoorPositionRear(i,k,j)
	if j == 0 
	then return Vector(-94.7 - 35.0*k     - 232.5*i,-67.5*(1-2*k),2.5)
	else return Vector(-94.7 - 35.0*(1-k) - 232.5*i,-66*(1-2*k),2.5)
	end
end

local yventpos = {
    -414.5+0*117,
    -414.5+1*117+6.2,
    414.5+2*117+5,
    414.5+3*117+2,
    414.5+4*117+0.5,
    -414.5+5*117-2.3,
    -414.5+6*117-2.3,
    -414.5+7*117+4,
}

ENT.Lights = {
    -- Headlight glow
    --[2] = { "dynamiclight",   Vector( 300, 0, 40), Angle(0,0,0), Color(255,255,255), brightness = 4, distance = 550 },
}

function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.Tickers = self:CreateRT("741Ticker",1024,64)
    render.PushRenderTarget(self.Tickers,0,0,1024, 64)
    render.Clear(0, 0, 0, 0)
    render.PopRenderTarget()
    self.ReleasedPdT = 0
    self.PreviousCompressorState = false
    self.CompressorVol = 0
    self.TISUVol = 0

    self.FrontLeak = 0
    self.RearLeak = 0

    self.ParkingBrake = 0

    self.VentRand = {}
    self.VentState = {}
    self.VentVol = {}
    for i=1,8 do
    self.VentRand[i] = math.Rand(0.5,2)
    self.VentState[i] = 0
    self.VentVol[i] = 0
    end
	self.skinarecalled = false
	
	self.RearBogey = self:GetNW2Entity("RearBogey")
	self.MiddleBogey = self:GetNW2Entity("MiddleBogey")
	self.RearCouple = self:GetNW2Entity("RearCouple")
	self.FakeCouple = self:GetNW2Entity("FakeCouple")
	
end
function ENT:UpdateWagonNumber()
    for i=0,3 do
        --self:ShowHide("TrainNumberL"..i,i<count)
        --self:ShowHide("TrainNumberR"..i,i<count)
        --if i< count then
            local num = math.floor(self.WagonNumber%(10^(i+1))/10^i)
            local rightNum = self.ClientEnts["TrainNumberR"..i]
            
            if IsValid(rightNum) then
                rightNum:SetPos(self:LocalToWorld(Vector(635-i*6.6+4*6.6/2, -63.5 ,18)))
                rightNum:SetSkin(num)
            end
			local leftNum = self.ClientEnts["TrainNumberL"..i]
            if IsValid(leftNum) then
                leftNum:SetPos(self:LocalToWorld(Vector(-635+i*6.6-4*6.6/2, 63.5, 18)))
                leftNum:SetSkin(num)
        end
    end
end

function ENT:Think()
    self.BaseClass.Think(self)
	
	Metrostroi740LoadTextures(self, skinsarecalled)
	
	self.skinarecalled = true

	--[[self.ClientProps["body"] = {
		model = self:GetNW2String("skin_body_741", "models/metrostroi_train/81-741/body/81-741_4_defualt_mos.mdl"),
		pos = Vector(0,0,0),
		ang = Angle(0,0,0),
		skin = self:GetNWInt("skin_skin_body", 0),
		hide=2,
	}]]

for i=0,2 do
	for k=0,1 do
		self.ClientProps["door"..i.."x"..k.."a"] = {
			model = self:GetNW2String("skin_door_pass_2", "models/metrostroi_train/81-740/body/81-740_leftdoor2.mdl"),
			pos = GetDoorPosition(i,k,0),
			ang = Angle(0,90 +180*k,0),      
			skin = self:GetNWInt("skin_skin_body", 0),
            hide = 1,
		}
		self.ClientProps["door"..i.."x"..k.."b"] = {
			model = self:GetNW2String("skin_door_pass_1", "models/metrostroi_train/81-740/body/81-740_leftdoor1.mdl"),
			pos = GetDoorPosition(i,k,1),
			ang = Angle(0,90 +180*k,0),   
			skin = self:GetNWInt("skin_skin_body", 0),
            hide = 1,
		}

	end 

end

for i=0,2 do
	for k=0,1 do
		self.ClientProps["door"..i.."x1"..k.."a1"] = {
			model = self:GetNW2String("skin_door_pass_2", "models/metrostroi_train/81-740/body/81-740_leftdoor2.mdl"),
			pos = GetDoorPositionRear(i,k,0),
			ang = Angle(0,90 +180*k,0),      
			skin = self:GetNWInt("skin_skin_body", 0),
		hide=2,
		callback = function(ent,cl_ent)
		local FakeCouple = ent:GetNW2Entity("FakeCouple")
		cl_ent:SetParent(FakeCouple) --выдача родителя.
			
		local pos = FakeCouple:GetPos() --позиция XYZ (настраивается через верхние строки)
		cl_ent:GetPos(Vector(pos.x, pos.y, pos.z))
		
		local ang = FakeCouple:GetAngles() --поворот XYZ (настраивается через верхние строки)
		cl_ent:GetAngles(Angle(ang.x, ang.y, ang.z))
		end,
}
		self.ClientProps["door"..i.."x1"..k.."b1"] = {
		model = self:GetNW2String("skin_door_pass_1", "models/metrostroi_train/81-740/body/81-740_leftdoor1.mdl"),
		pos = GetDoorPositionRear(i,k,1),
		ang = Angle(0,90 +180*k,0),   
		skin = self:GetNWInt("skin_skin_body", 0),
		hide=2,
		callback = function(ent,cl_ent)
		local FakeCouple = ent:GetNW2Entity("FakeCouple")
		cl_ent:SetParent(FakeCouple) --выдача родителя.
			
		local pos = FakeCouple:GetPos() --позиция XYZ (настраивается через верхние строки)
		cl_ent:GetPos(Vector(pos.x, pos.y, pos.z))
		
		local ang = FakeCouple:GetAngles() --поворот XYZ (настраивается через верхние строки)
		cl_ent:GetAngles(Angle(ang.x, ang.y, ang.z))
		end,
}

	end 

end

	self.ClientProps["door_cab_b"] = {
		model =  self:GetNW2String("skin_door_end", "models/metrostroi_train/81-741/body/door_br.mdl"),
		pos = Vector(-656.6,14.2,8.5),
		ang = Angle(0,-270,0.1),
		skin = self:GetNWInt("skin_skin_body", 0),
		hide=2,
		callback = function(ent,cl_ent)
		local FakeCouple = ent:GetNW2Entity("FakeCouple")
		cl_ent:SetParent(FakeCouple) --выдача родителя.
			
		local pos = FakeCouple:GetPos() --позиция XYZ (настраивается через верхние строки)
		cl_ent:GetPos(Vector(pos.x, pos.y, pos.z))
		
		local ang = FakeCouple:GetAngles() --поворот XYZ (настраивается через верхние строки)
		cl_ent:GetAngles(Angle(ang.x, ang.y, ang.z))
		end,
}
	--[[self.ClientProps["door_cab_f"] = {
		model =  self:GetNW2String("skin_door_end", "models/metrostroi_train/81-741/body/door_br.mdl"),
		pos = Vector(657,-14.4,8.5),
		ang = Angle(0,270,0.1),
		skin = self:GetNWInt("skin_skin_body", 0),
		hide=2,
}
	
	self.ClientProps["salon"] = {
		model = self:GetNW2String("skin_interior_741", "models/metrostroi_train/81-741/salon/salon.mdl"),
		pos = Vector(322.6,0,0),
		ang = Angle(0,180,0),
		skin = self:GetNWInt("skin_skin_interior", 0),
		hide=2,
	}
	self.ClientProps["handrails"] = {
		model = self:GetNW2String("skin_handrails_741", "models/metrostroi_train/81-741/salon/handrails/handrails.mdl"),
		pos = Vector(325.8,0,0),
		ang = Angle(0,-180,0),
		skin = self:GetNWInt("skin_skin_interior", 0),
		hide=1,
	}
	self.ClientProps["handrails1"] = {
		model = self:GetNW2String("skin_handrails_741", "models/metrostroi_train/81-741/salon/handrails/handrails.mdl"),
		pos = Vector(-325,0,0),
		ang = Angle(0,0,0),
		skin = self:GetNWInt("skin_skin_interior", 0),
		hide=2,
		callback = function(ent,cl_ent)
		local FakeCouple = ent:GetNW2Entity("FakeCouple")
		cl_ent:SetParent(FakeCouple) --выдача родителя.
			
		local pos = FakeCouple:GetPos() --позиция XYZ (настраивается через верхние строки)
		cl_ent:GetPos(Vector(pos.x, pos.y, pos.z))
		
		local ang = FakeCouple:GetAngles() --поворот XYZ (настраивается через верхние строки)
		cl_ent:GetAngles(Angle(ang.x, ang.y, ang.z))
		end,
}

	self.ClientProps["salon1"] = {
		model = self:GetNW2String("skin_interior_741", "models/metrostroi_train/81-741/salon/salon.mdl"),
		pos = Vector(-324,0,0),
		ang = Angle(0,0,0),
		skin = self:GetNWInt("skin_skin_interior", 0),
		hide=2,
		callback = function(ent,cl_ent)
		local FakeCouple = ent:GetNW2Entity("FakeCouple")
		cl_ent:SetParent(FakeCouple) --выдача родителя.
			
		local pos = FakeCouple:GetPos() --позиция XYZ (настраивается через верхние строки)
		cl_ent:GetPos(Vector(pos.x, pos.y, pos.z))
		
		local ang = FakeCouple:GetAngles() --поворот XYZ (настраивается через верхние строки)
		cl_ent:GetAngles(Angle(ang.x, ang.y, ang.z))
		end,
}]]

    if not self.RenderClientEnts or self.CreatingCSEnts then
        return
    end
    --[[if not self.PassSchemesDone then
        local sarmat = self.ClientEnts.PassSchemes
        local sarmatr = self.ClientEnts.PassSchemesR
        local scheme = Metrostroi.Skins["720_schemes"] and Metrostroi.Skins["720_schemes"][self.Scheme]
        if IsValid(sarmat) and IsValid(sarmatr) and scheme then
            if self:GetNW2Bool("PassSchemesInvert") then
                sarmat:SetSubMaterial(0,scheme[2])
                sarmatr:SetSubMaterial(0,scheme[1])
            else
                sarmat:SetSubMaterial(0,scheme[1])
                sarmatr:SetSubMaterial(0,scheme[2])
            end
            self.PassSchemesDone = true
        end
    end

    if self.Scheme ~= self:GetNW2Int("Scheme",1) then
        self.PassSchemesDone = false
        self.Scheme = self:GetNW2Int("Scheme",1)
    end
    if self.InvertSchemes ~= self:GetNW2Bool("PassSchemesInvert",false) then
        self.PassSchemesDone=false
        self.InvertSchemes = self:GetNW2Bool("PassSchemesInvert",false)
    end
]]
    if self.LastGVValue ~= self:GetPackedBool("GV") then
        self.ResetTime = CurTime()+1.5
        self.LastGVValue = self:GetPackedBool("GV")
    end
    self:Animate("gv_wrench",self.LastGVValue and 1 or 0,0.5,1,128,1,false)
    self:ShowHideSmooth("gv_wrench",    CurTime() < self.ResetTime and 1 or 0.1)

    local dT = self.DeltaTime

    local parking_brake = math.max(0,-self:GetPackedRatio("ParkingBrakePressure_dPdT",0))
    self.ParkingBrake = self.ParkingBrake+(parking_brake-self.ParkingBrake)*dT*10
    self:SetSoundState("parking_brake",self.ParkingBrake,1.4)

    local dPdT = self:GetPackedRatio("BrakeCylinderPressure_dPdT")
    self.ReleasedPdT = math.Clamp(self.ReleasedPdT + 4*(-self:GetPackedRatio("BrakeCylinderPressure_dPdT",0)-self.ReleasedPdT)*dT,0,1)
    --print(dPdT)
    self:SetSoundState("release",math.Clamp(self.ReleasedPdT,0,1)^1.65,1.0)

    self:ShowHide("lamps_salon_off",self:GetPackedRatio("SalonLighting") < 0.4)
    self:ShowHide("lamps_salon_on",self:GetPackedRatio("SalonLighting") >= 0.4)
	
	self:ShowHide("lamps_salon_off1",self:GetPackedRatio("SalonLighting") < 0.4)
    self:ShowHide("lamps_salon_on1",self:GetPackedRatio("SalonLighting") >= 0.4)

    self:Animate("FrontBrake", self:GetNW2Bool("FbI") and 0 or 1,0,1, 3, false)
    self:Animate("FrontTrain",  self:GetNW2Bool("FtI") and 1 or 0,0,1, 3, false)
    self:Animate("RearBrake",   self:GetNW2Bool("RbI") and 0 or 1,0,1, 3, false)
    self:Animate("RearTrain",   self:GetNW2Bool("RtI") and 1 or 0,0,1, 3, false)

    --[[local scurr = self:GetNW2Int("PassSchemesLED")
    local snext = self:GetNW2Int("PassSchemesLEDN")
    local led_back = self:GetPackedBool("PassSchemesLEDO",false)
    if self:GetPackedBool("PassSchemesInvert",false)  then led_back = not led_back end
    local ledwork = scurr~=0 or snext~=0
    for i=1,5 do
        self:ShowHide("led_l_f"..i,not led_back and ledwork)
        self:ShowHide("led_l_b"..i,led_back and ledwork)
        self:ShowHide("led_r_f"..i,not led_back and ledwork)
        self:ShowHide("led_r_b"..i,led_back and ledwork)
    end
    local led = scurr
    if snext ~= 0 and CurTime()%.5 > .25 then led = led + snext end
    if scurr < 0 then led = math.floor(CurTime()%5*6.2) end
    if led_back then
        if ledwork then
            for i=1,5 do
                if IsValid(self.ClientEnts["led_l_b"..i]) then self.ClientEnts["led_l_b"..i]:SetSkin(math.Clamp(led-((i-1)*6),0,6)) end
                if IsValid(self.ClientEnts["led_r_b"..i]) then self.ClientEnts["led_r_b"..i]:SetSkin(math.Clamp(led-((i-1)*6),0,6)) end
            end
        end
    else
        if ledwork then
            for i=1,5 do
                if IsValid(self.ClientEnts["led_l_f"..i]) then self.ClientEnts["led_l_f"..i]:SetSkin(math.Clamp(led-((i-1)*6),0,6)) end
                if IsValid(self.ClientEnts["led_r_f"..i]) then self.ClientEnts["led_r_f"..i]:SetSkin(math.Clamp(led-((i-1)*6),0,6)) end
            end
        end
    end
	]]
    if not self.DoorStates then self.DoorStates = {} end
    if not self.DoorLoopStates then self.DoorLoopStates = {} end
    for i=0,2 do
        for k=0,1 do
            local st = k==1 and "DoorL" or "DoorR"
            local doorstate = self:GetPackedBool(st)
            local id,sid = st..(i+1),"door"..i.."x"..k
            local state = self:GetPackedRatio(id)
            --print(state,self.DoorStates[state])
            if (state ~= 1 and state ~= 0) ~= self.DoorStates[id] then
                if doorstate and state < 1 or not doorstate and state > 0 then
					if doorstate then self:PlayOnce(sid.."s","",1,math.Rand(0.9,1.3)) end--math.Rand(0.9,1.3))
                else
                    if state > 0 then
                        self:PlayOnce(sid.."o1","",1,math.Rand(0.9,1.3))
                    else
                        local sound = math.random(1,3)
                        self:PlayOnce(sid.."c"..sound,"",1,math.Rand(0.9,1.3))
                    end
                end
                self.DoorStates[id] = (state ~= 1 and state ~= 0)
            end
            if (state ~= 1 and state ~= 0) then
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) + 2*self.DeltaTime,0,1)
            else
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) - 6*self.DeltaTime,0,1)
            end
            self:SetSoundState(sid.."r",self.DoorLoopStates[id],0.9+self.DoorLoopStates[id]*0.1)
            local n_l = "door"..i.."x"..k.."a"
            local n_r = "door"..i.."x"..k.."b"
            self:Animate(n_l,state,0,1,15,1)--0.8 + (-0.2+0.4*math.random()),0)
            self:Animate(n_r,state,0,1,15,1)--0.8 + (-0.2+0.4*math.random()),0)
        end
    end
	
	if not self.DoorStates then self.DoorStates = {} end
    if not self.DoorLoopStates then self.DoorLoopStates = {} end
    for i=0,2 do
        for k=0,1 do
            local st = k==1 and "DoorL" or "DoorR"
            local doorstate = self:GetPackedBool(st)
            local id,sid = st..(i+1),"door"..i.."x"..k
            local state = self:GetPackedRatio(id)
            --print(state,self.DoorStates[state])
            if (state ~= 1 and state ~= 0) ~= self.DoorStates[id] then
                if doorstate and state < 1 or not doorstate and state > 0 then
					if doorstate then self:PlayOnce(sid.."s","",1,math.Rand(0.9,1.3)) end--math.Rand(0.9,1.3))
                else
                    if state > 0 then
                        self:PlayOnce(sid.."o1","",1,math.Rand(0.9,1.3))
                    else
                        local sound = math.random(1,3)
                        self:PlayOnce(sid.."c"..sound,"",1,math.Rand(0.9,1.3))
                    end
                end
                self.DoorStates[id] = (state ~= 1 and state ~= 0)
            end
            if (state ~= 1 and state ~= 0) then
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) + 2*self.DeltaTime,0,1)
            else
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) - 6*self.DeltaTime,0,1)
            end
            self:SetSoundState(sid.."r",self.DoorLoopStates[id],0.9+self.DoorLoopStates[id]*0.1)
            local n_l1 = "door"..i.."x1"..k.."a1"
            local n_r1 = "door"..i.."x1"..k.."b1"
            self:Animate(n_l1,state,0,1,15,1)--0.8 + (-0.2+0.4*math.random()),0)
            self:Animate(n_r1,state,0,1,15,1)--0.8 + (-0.2+0.4*math.random()),0)
        end
    end
    local door_f = self:GetPackedBool("FrontDoor")
    local door_b = self:GetPackedBool("RearDoor")
    local door_cab_f = self:Animate("door_cab_f",door_f and 1 or -0.05, 0, 0.55, 8, 0.55)
    local door_cab_b = self:Animate("door_cab_b",door_b and 1 or -0.05, 0, 0.55, 8, 0.55)

    local door1s = (door_cab_f > 0 or door_f)
    if self.Door1 ~= door1s then
        self.Door1 = door1s
        self:PlayOnce("FrontDoor","bass",door1s and 1 or 0)
    end
    local door2s = (door_cab_b > 0 or door_b)
    if self.Door2 ~= door2s then
        self.Door2 = door2s
        self:PlayOnce("RearDoor","bass",door2s and 1 or 0)
    end

    local speed = self:GetPackedRatio("Speed", 0)

    local ventSpeedAdd = math.Clamp(speed/30,0,1)

    local v2state = self:GetPackedBool("Vent2Work")
    for i=1,8 do
        local rand = self.VentRand[i]
        local vol = self.VentVol[i]
        local even = i%2 == 0
        local work = (even and v1state or not even and v2state)
        local target = math.min(1,(work and 1 or 0)+ventSpeedAdd*rand*0.4)*2
        if self.VentVol[i] < target then
            self.VentVol[i] = math.min(target,vol + dT/1.5*rand)
        elseif self.VentVol[i] > target then
            self.VentVol[i] = math.max(0,vol - dT/8*rand*(vol*0.3))
        end
        self.VentState[i] = (self.VentState[i] + 10*((self.VentVol[i]/2)^3)*dT)%1
        local vol1 = math.max(0,self.VentVol[i]-1)
        local vol2 = math.max(0,(self.VentVol[i-1] or self.VentVol[i+1])-1)
        self:SetSoundState("vent"..i,vol1*(0.7+vol2*0.3),0.5+0.5*vol1+math.Rand(-0.01,0.01))
        if IsValid(self.ClientEnts["vent"..i]) then
            self.ClientEnts["vent"..i]:SetPoseParameter("position",self.VentState[i])
        end
    end
    self:SetSoundState("compressor",self:GetPackedBool("CompressorWork") and 1 or 0,1)

    local speed = self:GetPackedRatio("Speed", 0)
    --local rol10 = math.Clamp(speed/5,0,1)*(1-math.Clamp((speed-50)/8,0,1))
    --local rol70 = math.Clamp((speed-50)/8,0,1)
    local rollingi = math.min(1,self.TunnelCoeff+math.Clamp((self.StreetCoeff-0.82)/0.5,0,1))
    local rollings = math.max(self.TunnelCoeff*0.6,self.StreetCoeff)
    local tunstreet = (rollingi+rollings*0.2)
    local rol10 = math.Clamp(speed/12,0,1)*(1-math.Clamp((speed-20)/12,0,1))
    local rol10p = Lerp((speed-12)/12,0.9,1.1)
    local rol30 = math.Clamp((speed-20)/12,0,1)*(1-math.Clamp((speed-40)/12,0,1))
    local rol30p = Lerp((speed-15)/30,0.8,1.2)
    local rol55 = math.Clamp((speed-40)/12,0,1)*(1-math.Clamp((speed-65)/15,0,1))
    local rol55p = Lerp(0.8+(speed-43)/24,0.8,1.2)
    local rol75 = math.Clamp((speed-65)/15,0,1)
    local rol75p = Lerp(0.8+(speed-67)/16,0.8,1.2)
    self:SetSoundState("rolling_10",rollingi*rol10,rol10p)
    self:SetSoundState("rolling_30",rollingi*rol30,rol30p)
    self:SetSoundState("rolling_55",rollingi*rol55,rol55p)
    self:SetSoundState("rolling_75",rollingi*rol75,rol75p)

    local rol10 = math.Clamp(speed/15,0,1)*(1-math.Clamp((speed-18)/35,0,1))
    local rol10p = Lerp((speed-15)/14,0.6,0.78)
    local rol40 = math.Clamp((speed-18)/35,0,1)*(1-math.Clamp((speed-55)/40,0,1))
    local rol40p = Lerp((speed-15)/66,0.6,1.3)
    local rol70 = math.Clamp((speed-55)/20,0,1)--*(1-math.Clamp((speed-72)/5,0,1))
    local rol70p = Lerp((speed-55)/27,0.78,1.15)
    --local rol80 = math.Clamp((speed-70)/5,0,1)
    --local rol80p = Lerp(0.8+(speed-72)/15*0.2,0.8,1.2)
    self:SetSoundState("rolling_low"    ,rol10*rollings,rol10p) --15
    self:SetSoundState("rolling_medium2",rol40*rollings,rol40p) --57
    --self:SetSoundState("rolling_medium1",0 or rol40*rollings,rol40p) --57
    self:SetSoundState("rolling_high2"  ,rol70*rollings,rol70p) --70

     local state = self:GetPackedRatio("RNState")
    self.TISUVol = math.Clamp(self.TISUVol+(state-self.TISUVol)*dT*8,0,1)
    self:SetSoundState("tisu", self.TISUVol, 1)
    self:SetSoundState("bbe", self:GetPackedBool("BBEWork") and 1 or 0, 1)

    local work = self:GetPackedBool("AnnPlay")
    for k,v in ipairs(self.AnnouncerPositions) do
        if self.Sounds["announcer"..k] and IsValid(self.Sounds["announcer"..k]) then
            self.Sounds["announcer"..k]:SetVolume(work and (v[3] or 1)  or 0.7)
        end
    end
end

function ENT:Draw()
    self.BaseClass.Draw(self)
end

function ENT:DrawPost(special)
    self.RTMaterial:SetTexture("$basetexture", self.Tickers)
    self:DrawOnPanel("Tickers",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(512,32+8,1024+16,64+16,0)
    end)
	self.RTMaterial:SetTexture("$basetexture", self.Tickers)
    self:DrawOnPanel("Tickers_rear",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(512,32+8,1024+16,64+16,0)
    end)
end
function ENT:OnButtonPressed(button)
end

function ENT:OnPlay(soundid,location,range,pitch)
    if location == "stop" then
        if IsValid(self.Sounds[soundid]) then
            self.Sounds[soundid]:Pause()
            self.Sounds[soundid]:SetTime(0)
        end
        return
    end
    if soundid == "K1" then
        local id = range > 0 and "k1_on" or "k1_off"
        local speed = self:GetPackedRatio("Speed")
        self.SoundPositions["k1_on"][1] = 440-Lerp(speed/0.1,0,330)
        return id,location,1-Lerp(speed/10,0.2,0.8),pitch
    end
    if soundid == "K2" then
        local id = range > 0 and "k2_on" or "k2_off"
        local speed = self:GetPackedRatio("Speed")
        self.SoundPositions["k2_on"][1] = 440-Lerp(speed/0.1,0,330)
        return id,location,1-Lerp(speed/10,0.2,0.8),pitch
    end
    if soundid == "K3" then
        local id = range > 0 and "k3_on" or "k3_off"
        local speed = self:GetPackedRatio("Speed")
        self.SoundPositions["k3_on"][1] = 440-Lerp(speed/0.1,0,330)
        return id,location,1-Lerp(speed/10,0.2,0.8),pitch
    end
    if soundid == "KMR1" then
        local id = range > 0 and "kmr1_on" or "kmr1_off"
        local speed = self:GetPackedRatio("Speed")
        self.SoundPositions["kmr1_on"][1] = 440-Lerp(speed/0.1,0,330)
        return id,location,1-Lerp(speed/10,0.2,0.8),pitch
    end
    if soundid == "KMR2" then
        local id = range > 0 and "kmr2_on" or "kmr2_off"
        local speed = self:GetPackedRatio("Speed")
        self.SoundPositions["kmr2_on"][1] = 440-Lerp(speed/0.1,0,330)
        return id,location,1-Lerp(speed/10,0.2,0.8),pitch
    end
    if soundid == "QF1" then
        local id = range > 0 and "qf1_on" or "qf1_off"
        local speed = self:GetPackedRatio("Speed")
        self.SoundPositions["qf1_on"][1] = 440-Lerp(speed/0.1,0,330)
        return id,location,1-Lerp(speed/10,0.2,0.8),pitch
    end
    return soundid,location,range,pitch
end
Metrostroi.GenerateClientProps()