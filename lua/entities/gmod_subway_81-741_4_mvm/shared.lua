ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category        = "Metrostroi (trains)"
ENT.SkinsType = "81-740"
ENT.Model = "models/metrostroi_train/81-740/body/81-740_4_defualt_mos_front.mdl"

ENT.Spawnable       = true
ENT.AdminSpawnable  = true

function ENT:PassengerCapacity()
    return 185
end

function ENT:GetStandingArea()
    return Vector(550,-10,-45), Vector(150,-10,-45)
end
local function GetDoorPosition(i,k)	--Правые двери			--Левые двери
	return Vector(652.5  - 35.0*k     -  338.8*i, -67.5*(1-2*k), 4.3)
end

local function GetDoorPositionRear(i,k)
	return Vector(35.8 - 35.0*k     - 232.2*i,-67.5*(1-2*k),3)
end
local yventpos = {
    -414.5+0*117,
	-414.5+1*117+6.2,
	414.5+2*117+5,
	414.5+3*117+2,
	414.5+4*117+0.5,
	-414.5+5*117-2.3,
	-414.5+6*117,
}
function ENT:InitializeSounds()
    self.BaseClass.InitializeSounds(self)
    --[[self.SoundNames["tisu"]   = {"subway_trains/rusich/inverter.wav",loop = true}
    self.SoundPositions["tisu"] = {800,1e9,Vector(0,0,-40),1} --FIXME: Pos
    self.SoundNames["tisu2"]   = {"subway_trains/rusich/inverter.wav",loop = true}
    self.SoundPositions["tisu2"] = {50,1e9,Vector(430,0,0),1} --FIXME: Pos--]]
	local inv = math.random (1,2)
    self.SoundNames["async"]   = {"subway_trains/rusich/inverter"..inv..".wav",loop = true}
    self.SoundPositions["async"] = {400,1e9,Vector(700-144,0,0),1} --FIXME: Pos
    for i=1,7 do
        self.SoundNames["vent"..i] = {loop=true,"subway_trains/rusich/vent_loop.wav"}
        self.SoundPositions["vent"..i] = {100,1e9,Vector(-113+(i-1)*117,0,30),0.2}
    end

    self.SoundNames["compressor"] = {loop=2,"subway_trains/rusich/compressor/compressor740_start.wav","subway_trains/rusich/compressor/compressor740_loop.wav","subway_trains/rusich/compressor/compressor740_stop.wav"}
    self.SoundPositions["compressor"] = {485,1e9,Vector(-18,-40,-66),0.35}
    self.SoundNames["compressor_pn"] = "subway_trains/722/compressor_pssh.mp3"
    self.SoundPositions["compressor_pn"] = {485,1e9,Vector(-18,-40,-66),0.45} --FIXME: Pos

	local j = math.random (1,3)
    self.SoundNames["release"] = {loop=true,"subway_trains/rusich/pneumo_release_"..j..".wav"}
    --self.SoundNames["release"] = {loop=true,"subway_trains/common/pneumatic/release_2.wav"}
    self.SoundPositions["release"] = {485,1e9,Vector(-53,0,-70),0.55}
    self.SoundNames["parking_brake"] = {loop=true,"subway_trains/common/pneumatic/autostop_loop.wav"}
    self.SoundPositions["parking_brake"] = {400,1e9,Vector(-53,0,-70),0.95}
    self.SoundNames["disconnect_valve"] = "subway_trains/common/switches/pneumo_disconnect_switch.mp3"

    self.SoundNames["front_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["front_isolation"] = {300,1e9,Vector(443, 0,-63),1}
    self.SoundNames["rear_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["rear_isolation"] = {300,1e9,Vector(-456, 0,-63),1}

    self.SoundNames["k2_on"] = "subway_trains/717/pneumo/lk2_on.mp3"
    self.SoundNames["k2_off"] = "subway_trains/717/pneumo/lk2_off.mp3"
    self.SoundNames["k1_on"] = "subway_trains/717/pneumo/lk1_on.mp3"
    self.SoundNames["k3_on"] = self.SoundNames["k2_on"]
    self.SoundNames["kmr1_on"] = self.SoundNames["k1_on"]
    self.SoundNames["kmr2_on"] = self.SoundNames["k1_on"]
    self.SoundNames["k1_off"] = self.SoundNames["k2_off"]
    self.SoundNames["k3_off"] = self.SoundNames["k2_off"]
    self.SoundNames["kmr1_off"] = self.SoundNames["k2_off"]
    self.SoundNames["kmr2_off"] = self.SoundNames["k2_off"]
    --self.SoundNames["ksh1_off"] = "subway_trains/717/pneumo/ksh1.mp3"
    self.SoundPositions["k2_on"] = {540,1e9,Vector(-60,-40,-66),0.45}
    self.SoundPositions["k1_on"] = {440,1e9,Vector(-60,-40,-66),0.6}
    self.SoundPositions["k2_off"] = self.SoundPositions["k2_on"]
    self.SoundPositions["k3_off"] = self.SoundPositions["k2_on"]
    self.SoundPositions["k3_on"] = self.SoundPositions["k2_on"]
    self.SoundPositions["k3_off"] = self.SoundPositions["k2_on"]
    self.SoundPositions["kmr1_on"] = self.SoundPositions["k2_on"]
    self.SoundPositions["kmr1_off"] = self.SoundPositions["k2_on"]
    self.SoundPositions["kmr2_on"] = self.SoundPositions["k2_on"]
    self.SoundPositions["kmr2_off"] = self.SoundPositions["k2_on"]

    self.SoundNames["rolling_10"] = {loop=true,"subway_trains/rusich/rolling/rolling_10.wav"}
	local rol = math.random (1,2)
    self.SoundNames["rolling_30"] = {loop=true,"subway_trains/rusich/rolling/rolling_30_"..rol..".wav"}
    self.SoundNames["rolling_55"] = {loop=true,"subway_trains/rusich/rolling/rolling_55.wav"}
    self.SoundNames["rolling_75"] = {loop=true,"subway_trains/rusich/rolling/rolling_75.wav"}
    self.SoundPositions["rolling_10"] = {485,1e9,Vector(816-144,0,0),0.33}
    self.SoundPositions["rolling_30"] = {485,1e9,Vector(816-144,0,0),0.7}
    self.SoundPositions["rolling_55"] = {485,1e9,Vector(816-144,0,0),0.85}
    self.SoundPositions["rolling_75"] = {485,1e9,Vector(816-144,0,0),0.90}
    self.SoundNames["rolling_low"] = {loop=true,"subway_trains/rusich/rolling/rolling_outside_low.wav"}
    self.SoundNames["rolling_medium1"] = {loop=true,"subway_trains/rusich/rolling/rolling_outside_medium1.wav"}
    self.SoundNames["rolling_medium2"] = {loop=true,"subway_trains/rusich/rolling/rolling_outside_medium2.wav"}
    self.SoundNames["rolling_high2"] = {loop=true,"subway_trains/rusich/rolling/rolling_outside_high2.wav"}
    self.SoundPositions["rolling_low"] = {480,1e12,Vector(816-144,0,0),0.6*0.4}
    self.SoundPositions["rolling_medium1"] = {480,1e12,Vector(816-144,0,0),0.90*0.4}
    self.SoundPositions["rolling_medium2"] = {480,1e12,Vector(816-144,0,0),0.90*0.4}
    self.SoundPositions["rolling_high2"] = {480,1e12,Vector(816-144,0,0),1.00*0.4}

    self.SoundNames["gv_f"] = {"subway_trains/717/kv70/reverser_0-b_1.mp3","subway_trains/717/kv70/reverser_0-b_2.mp3"}
    self.SoundNames["gv_b"] = {"subway_trains/717/kv70/reverser_b-0_1.mp3","subway_trains/717/kv70/reverser_b-0_2.mp3"}
    self.SoundPositions["gv_f"] = {80,1e9,Vector(-126.4,50,-60-23.5),0.8}
    self.SoundPositions["gv_b"] = {80,1e9,Vector(-126.4,50,-60-23.5),0.8}
    self.SoundNames["pak_on"] = "subway_trains/717/switches/rc_on.mp3"
    self.SoundNames["pak_off"] = "subway_trains/717/switches/rc_off.mp3"

    self.SoundNames["door_cab_open"] = {"subway_trains/rusich/door/door_torec_open.mp3","subway_trains/rusich/door/door_torec_open2.mp3"}
    self.SoundNames["door_cab_close"] = {"subway_trains/rusich/door/door_torec_close.mp3","subway_trains/rusich/door/door_torec_close2.mp3"}
    for i=0,2 do
        for k=0,1 do
            self.SoundNames["door"..i.."x"..k.."r"] = {"subway_trains/rusich/doors/door_loop.wav",loop=true}
            self.SoundPositions["door"..i.."x"..k.."r"] = {200,1e9,GetDoorPosition(i,k),0.15}
            self.SoundNames["door"..i.."x"..k.."s"] = {"subway_trains/rusich/doors/door_start.wav"}
            self.SoundPositions["door"..i.."x"..k.."s"] = {200,1e9,GetDoorPosition(i,k),0.15}
            self.SoundNames["door"..i.."x"..k.."o1"] = {"subway_trains/rusich/doors/door_open1.wav"}
            self.SoundPositions["door"..i.."x"..k.."o1"] = {200,1e9,GetDoorPosition(i,k),0.15}
            self.SoundNames["door"..i.."x"..k.."c1"] = {"subway_trains/rusich/doors/door_close1.wav"}
            self.SoundPositions["door"..i.."x"..k.."c1"] = {200,1e9,GetDoorPosition(i,k),0.15}
            self.SoundNames["door"..i.."x"..k.."c2"] = {"subway_trains/rusich/doors/door_close2.wav"}
            self.SoundPositions["door"..i.."x"..k.."c2"] = {200,1e9,GetDoorPosition(i,k),0.15}
            self.SoundNames["door"..i.."x"..k.."c3"] = {"subway_trains/rusich/doors/door_close3.wav"}
            self.SoundPositions["door"..i.."x"..k.."c3"] = {200,1e9,GetDoorPosition(i,k),0.15}
        end
    end

    self.SoundNames["batt_on"] = "subway_trains/720/batt_on.mp3"
    self.SoundPositions["batt_on"] = {400,1e9,Vector(126.4,50,-60-23.5),0.3}
end

function ENT:InitializeSystems()
    self:LoadSystem("TR","TR_3B_4740")
    self:LoadSystem("Electric","81_740_4ELECTRICA")
    self:LoadSystem("Engines","DK_120AM")
    self:LoadSystem("BPTI","81_740_4BPTI")

    self:LoadSystem("BUV","81_740_4BUV")

    self:LoadSystem("Pneumatic","81_740_4Pneumatic")

    self:LoadSystem("Panel","81_741_4Panel")

    self:LoadSystem("Tickers","81_740_4Ticker")
    self:LoadSystem("PassSchemes","81_740_4PassScheme")

    self:LoadSystem("IGLA_PCBK","IGLA_740_4PCBK")
end

ENT.AnnouncerPositions = {}
for i=1,3 do
    table.insert(ENT.AnnouncerPositions,{Vector(0-(i-1)*230+38,47*(i%2 > 0 and -1 or 1) ,44),200,0.3})
end
---------------------------------------------------
-- Defined train information
-- Types of wagon(for wagon limit system):
-- 0 = Head or intherim
-- 1 = Only head
-- 2 = Only intherim
---------------------------------------------------
ENT.SubwayTrain = {
    Type = "81-740",
    Name = "81-741",
    WagType = 2,
    Manufacturer = "MVM",
    EKKType = 740
}
ENT.NumberRanges = {{0681,0683},{0735,0918}}
