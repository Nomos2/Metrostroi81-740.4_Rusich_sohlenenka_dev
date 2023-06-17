local Map = game.GetMap() 
if (Map:find("gm_metro_minsk_1984") 
or Map:find("gm_metro_nsk_line_2_v6")
or Map:find("gm_metro_kalinin_v2")
or Map:find("gm_metro_krl_v1")
or Map:find("gm_dnipro")
or Map:find("gm_bolshya_kolsewya_line")
or Map:find("gm_metrostroi_practice_d")
or Map:find("gm_metronvl")) then
	return
end

ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category        = "Metrostroi (trains)"
ENT.SkinsType 		= "81-740"
ENT.Model 			= "models/metrostroi_train/81-740/body/81-740_4_defualt_mos_front.mdl"

ENT.Spawnable       = true
ENT.AdminSpawnable  = true
 
function ENT:PassengerCapacity()
    return 370
end	

function ENT:GetStandingArea()
    return Vector(530,-25,-47), Vector(50,25,-41)
end

function ENT:GetStandingAreaRear()    --смещение пассажиров
	return Vector(290,-25,-47),Vector(-298,25,-41)	
end

local function GetDoorPosition(b,k)	--Правые двери			--Левые двери
	return Vector(652.5  - 35.0*k     -  338.8*b, -67.5*(1-2*k), 4.3)
end

local function GetDoorPositionRear(b,k)			--	x						--	y        --	z
	return Vector(-195.5 - -35.0*k - 232.1*b, -66*(1-2*k), 4.3)
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
    self.SoundNames["async1"]   = {"subway_trains/rusich/inverter/inverter1.wav",loop = true}
    self.SoundPositions["async1"] = {400,1e9,Vector(700-144,0,0),1} --FIXME: Pos
    self.SoundNames["async2"]   = {"subway_trains/rusich/inverter/inverter2.wav",loop = true}
    self.SoundPositions["async2"] = {400,1e9,Vector(700-144,0,0),1} --FIXME: Pos
    self.SoundNames["async3"]   = {"subway_trains/rusich/inverter/inverter3.wav",loop = true}
    self.SoundPositions["async3"] = {400,1e9,Vector(700-144,0,0),1} --FIXME: Pos
    self.SoundNames["async4"]   = {"subway_trains/rusich/inverter/inverter4.wav",loop = true}
    self.SoundPositions["async4"] = {400,1e9,Vector(700-144,0,0),1} --FIXME: Pos
    self.SoundNames["async5"]   = {"subway_trains/rusich/inverter/inverter5.wav",loop = true}
    self.SoundPositions["async5"] = {400,1e9,Vector(700-144,0,0),1} --FIXME: Pos	
    --self.SoundNames["async6"]   = {"subway_trains/rusich/inverter/inverter6.wav",loop = true} --5 инвертер переименован в звук рекуперации.
    --self.SoundPositions["async6"] = {400,1e9,Vector(700-144,0,0),1} --FIXME: Pos		
	
    self.SoundNames["bbe_v1"]   = {"subway_trains/rusich/bbes/bbe.wav",loop = true}
    self.SoundPositions["bbe_v1"] = {800,1e9,Vector(400-144,0,-40),0.55} --FIXME: Pos	
    self.SoundNames["bbe_v2"]   = {"subway_trains/rusich/bbes/bbe_1.wav",loop = true}
    self.SoundPositions["bbe_v2"] = {800,1e9,Vector(400-144,0,-40),0.55} --FIXME: Pos	
    self.SoundNames["bbe_v3"]   = {"subway_trains/rusich/bbes/bbe_new.wav",loop = true}
    self.SoundPositions["bbe_v3"] = {800,1e9,Vector(400-144,0,-40),0.55} --FIXME: Pos
	
    for i=1,7 do
        self.SoundNames["vent"..i] = {loop=true,"subway_trains/rusich/vent/vent_loop.wav"}
        self.SoundPositions["vent"..i] = {100,1e9,Vector(-113+(i-1)*117,0,30),0.2}
	    self.SoundNames["vent1"..i] = {loop=true,"subway_trains/rusich/vent/vent_loop_1.wav"}
        self.SoundPositions["vent1"..i] = {100,1e9,Vector(-113+(i-1)*117,0,30),0.2}	
    end

    self.SoundNames["compressor"] = {loop=2,"subway_trains/rusich/compressor/compressor740_start.wav","subway_trains/rusich/compressor/compressor740_loop.wav","subway_trains/rusich/compressor/compressor740_stop.wav"}
    self.SoundPositions["compressor"] = {800,1e9,Vector(-18+144,-40,-66)}
    self.SoundNames["compressor_pn"] = "subway_trains/rusich/compressor/compressor_psh.wav"
    self.SoundPositions["compressor_pn"] = {485,1e9,Vector(-18+-144,-40,-66),0.7} --FIXME: Pos

	local j = math.random (1,3)
    self.SoundNames["release"] = {loop=true,"subway_trains/rusich/pneumo_release_"..j..".wav"}
    self.SoundPositions["release"] = {485,1e9,Vector(-53,0,-70),0.25}
    self.SoundNames["parking_brake"] = {loop=true,"subway_trains/common/pneumatic/autostop_loop.wav"}
    self.SoundPositions["parking_brake"] = {400,1e9,Vector(-53,0,-70),0.95}
    self.SoundNames["disconnect_valve"] = "subway_trains/common/switches/pneumo_disconnect_switch.mp3"

    self.SoundNames["front_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["front_isolation"] = {300,1e9,Vector(443, 0,-63),1}
    self.SoundNames["rear_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["rear_isolation"] = {300,1e9,Vector(-456, 0,-63),1}

    self.SoundNames["rolling_5"] = {loop=true,"subway_trains/rusich/rolling/skrip1.mp3"}	
    self.SoundNames["rolling_10"] = {loop=true,"subway_trains/rusich/rolling/rolling_10.wav"}
	local rol = math.random (1,2)
    self.SoundNames["rolling_30"] = {loop=true,"subway_trains/rusich/rolling/rolling_30_"..rol..".wav"}
    self.SoundNames["rolling_55"] = {loop=true,"subway_trains/rusich/rolling/rolling_55.wav"}
    self.SoundNames["rolling_75"] = {loop=true,"subway_trains/rusich/rolling/rolling_75.wav"}
    self.SoundPositions["rolling_5"] = {485,1e9,Vector(816-144,0,0),0.4}	
    self.SoundPositions["rolling_10"] = {485,1e9,Vector(816-144,0,0),0.53}
    self.SoundPositions["rolling_30"] = {485,1e9,Vector(816-144,0,0),0.7}
    self.SoundPositions["rolling_55"] = {485,1e9,Vector(816-144,0,0),0.85}
    self.SoundPositions["rolling_75"] = {485,1e9,Vector(816-144,0,0),0.90}
    self.SoundNames["rolling_low"] = {loop=true,"subway_trains/rusich/rolling/rolling_outside_low.wav"}
    self.SoundNames["rolling_medium2"] = {loop=true,"subway_trains/rusich/rolling/rolling_outside_medium"..rol..".wav"}
    self.SoundNames["rolling_high2"] = {loop=true,"subway_trains/rusich/rolling/rolling_outside_high2.wav"}
    self.SoundPositions["rolling_low"] = {480,1e12,Vector(816-144,0,0),0.6*0.4}
    self.SoundPositions["rolling_medium1"] = {480,1e12,Vector(816-144,0,0),0.90*0.4}
    self.SoundPositions["rolling_medium2"] = {480,1e12,Vector(816-144,0,0),0.90*0.4}
    self.SoundPositions["rolling_high2"] = {480,1e12,Vector(816-144,0,0),1.00*0.4}
	
    self.SoundNames["rolling_low_740"] = {loop=true,"subway_trains/rusich/rolling/rolling_740/rolling_outside_low.wav"}
    self.SoundNames["rolling_medium2_740"] = {loop=true,"subway_trains/rusich/rolling/rolling_740/rolling_outside_medium2.wav"}
    self.SoundNames["rolling_high2_740"] = {loop=true,"subway_trains/rusich/rolling/rolling_740/rolling_outside_high2.wav"}
    self.SoundPositions["rolling_low_740"] = {480,1e12,Vector(195.5,0,0),0.6*0.6}
    self.SoundPositions["rolling_medium2_740"] = {480,1e12,Vector(195.5,0,0),0.90*0.6}
    self.SoundPositions["rolling_high2_740"] = {480,1e12,Vector(195.5,0,0),1.00*0.6}
	

    self.SoundNames["gv_f"] = {"subway_trains/717/kv70/reverser_0-b_1.mp3","subway_trains/717/kv70/reverser_0-b_2.mp3"}
    self.SoundNames["gv_b"] = {"subway_trains/717/kv70/reverser_b-0_1.mp3","subway_trains/717/kv70/reverser_b-0_2.mp3"}
    self.SoundPositions["gv_f"] = {80,1e9,Vector(-126.4,50,-60-23.5),0.8}
    self.SoundPositions["gv_b"] = {80,1e9,Vector(-126.4,50,-60-23.5),0.8}
    self.SoundNames["pak_on"] = "subway_trains/717/switches/rc_on.mp3"
    self.SoundNames["pak_off"] = "subway_trains/717/switches/rc_off.mp3"
	
    self.SoundNames["door_cab_open"] = 	"subway_trains/rusich/door/torec/door_torec_open_end.wav"
    self.SoundNames["door_cab_close"] = "subway_trains/rusich/door/torec/door_close_1.mp3"	

	local loop = math.random (1,2)
	local start = math.random (1,5)		
	local closed = math.random (3,5)	
	local open = math.random (1,3)		
    for i=0,2 do
        for k=0,1 do
            self.SoundNames["door"..i.."x"..k.."r"] = {"subway_trains/rusich/doors/door_loop_"..loop..".wav",loop=true}
            self.SoundPositions["door"..i.."x"..k.."r"] = {200,1e9,GetDoorPosition(i,k),1}
            self.SoundNames["door"..i.."x"..k.."s"] = {"subway_trains/rusich/doors/door_start_"..start..".wav"}
            self.SoundPositions["door"..i.."x"..k.."s"] = {200,1e9,GetDoorPosition(i,k),1}
            self.SoundNames["door"..i.."x"..k.."o1"] = {"subway_trains/rusich/doors/door_open_end"..open..".wav"}
            self.SoundPositions["door"..i.."x"..k.."o1"] = {200,1e9,GetDoorPosition(i,k),1}
            self.SoundNames["door"..i.."x"..k.."c1"] = {"subway_trains/rusich/doors/door_close"..closed..".wav"}
            self.SoundPositions["door"..i.."x"..k.."c1"] = {200,1e9,GetDoorPosition(i,k),0.5}	
			
            self.SoundNames["door"..i.."x"..k.."r"] = {"subway_trains/rusich/doors/door_loop_"..loop..".wav",loop=true}
            self.SoundPositions["door"..i.."x"..k.."r"] = {200,1e9,GetDoorPositionRear(i,k),1}
            self.SoundNames["door"..i.."x"..k.."s"] = {"subway_trains/rusich/doors/door_start_"..start..".wav"}
            self.SoundPositions["door"..i.."x"..k.."s"] = {200,1e9,GetDoorPositionRear(i,k),1}
            self.SoundNames["door"..i.."x"..k.."o1"] = {"subway_trains/rusich/doors/door_open_end"..open..".wav"}
            self.SoundPositions["door"..i.."x"..k.."o1"] = {200,1e9,GetDoorPositionRear(i,k),1}
            self.SoundNames["door"..i.."x"..k.."c1"] = {"subway_trains/rusich/doors/door_close"..closed..".wav"}
            self.SoundPositions["door"..i.."x"..k.."c1"] = {200,1e9,GetDoorPositionRear(i,k),0.5}		
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
    --self:LoadSystem("PassSchemes","81_740_4PassScheme")
	
	self:LoadSystem("AsyncInverter","81_760_AsyncInverter")	
	
    self:LoadSystem("IGLA_PCBK","IGLA_740_4PCBK")	
end

ENT.AnnouncerPositions = {}
for i=1,3 do
    table.insert(ENT.AnnouncerPositions,{
	Vector(0-(i-1)*230+38,
	47*(i%2 > 0 and -1 or 1) ,44),450,0.5})
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
