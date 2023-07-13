local Map = game.GetMap():lower() or ""
if(Map:find("gm_metro_minsk") 
or Map:find("gm_metro_nsk_line")
or Map:find("gm_metro_kalinin")
or Map:find("gm_metro_krl")
or Map:find("gm_dnipro")
or Map:find("gm_bolshya_kolsewya_line")
or Map:find("gm_metrostroi_practice_d")
or Map:find("gm_metronvl")) then
	return
end

ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.NoTrain = true

ENT.Category		= "Metrostroi (utility)"
ENT.Spawnable		= false
ENT.AdminSpawnable	= false
ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Model 			= "models/metrostroi_train/81-740/body/81-740_4_rear_reference.mdl"

local yventpos = {
    -14.5+0*117-144,
	---414.5+1*117+6.2-144,
	-14.5+2*117+5-144,
	--414.5+3*117+2-144,
	-44.5+4*117+0.5-144,
	---414.5+5*117-2.3-144,
	---414.5+6*117-144,
}

local function GetDoorPositionRear(n,G)			--	x						--	y        --	z
	return Vector(-195.5 - -35.0*G - 232.1*n, -66*(1-2*G), 4.3)
end

function ENT:InitializeSounds()
    self.BaseClass.InitializeSounds(self)	
	local rol = math.random (1,2)	
	for i = 1,10 do
		local id3 = Format("b3tunnel_%d",i)		
		self.SoundNames[id3.."a"] = "subway_trains/bogey/st"..i.."a.wav"
		self.SoundNames[id3.."b"] = "subway_trains/bogey/st"..i.."b.wav"
		self.SoundPositions[id3.."a"] = {700,1e9,Vector(-532,0,-74.5),1}
		self.SoundPositions[id3.."b"] = self.SoundPositions[id3.."a"]		
	end
	for i = 1,14 do
		local id3 = Format("b3street_%d",i)		
		self.SoundNames[id3.."a"] = "subway_trains/bogey/wheels/street_"..i.."a.mp3"
		self.SoundNames[id3.."b"] = "subway_trains/bogey/wheels/street_"..i.."b.mp3"
		self.SoundPositions[id3.."a"] = {700,1e9,Vector(-532,0,-74.5),1.5}
		self.SoundPositions[id3.."b"] = self.SoundPositions[id3.."a"]		
	end
	
    self.SoundNames["rear_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["rear_isolation"] = {300,1e9,Vector(-456+144, 0,-63),1}
    self.SoundNames["compressor"] = {loop=2,"subway_trains/rusich/compressor/compressor740_start.wav","subway_trains/rusich/compressor/compressor740_loop.wav","subway_trains/rusich/compressor/compressor740_stop.wav"}
    self.SoundPositions["compressor"] = {800,1e9,Vector(-18,-40,-66)}		
	
	self.SoundNames["rolling_5_tst"] = {loop=true,"subway_trains/rusich/rolling/skrip1.mp3"}	
	self.SoundNames["rolling_10_tst"] = {loop=true,"subway_trains/rusich/rolling/rolling_10.wav"}
	self.SoundNames["rolling_30_tst"] = {loop=true,"subway_trains/rusich/rolling/rolling_30_"..rol..".wav"}
	self.SoundNames["rolling_55_tst"] = {loop=true,"subway_trains/rusich/rolling/rolling_55.wav"}
	self.SoundNames["rolling_75_tst"] = {loop=true,"subway_trains/rusich/rolling/rolling_75.wav"}		
	self.SoundPositions["rolling_5_tst"] = {485,1e9,Vector(116-144,0,0),0.4}	
	self.SoundPositions["rolling_10_tst"] = {485,1e9,Vector(116-144,0,0),0.53}
	self.SoundPositions["rolling_30_tst"] = {485,1e9,Vector(116-144,0,0),0.7}
	self.SoundPositions["rolling_55_tst"] = {485,1e9,Vector(116-144,0,0),0.85}
	self.SoundPositions["rolling_75_tst"] = {485,1e9,Vector(116-144,0,0),0.9}	
	
    self.SoundNames["rolling_low_740"] = {loop=true,"subway_trains/rusich/rolling/rolling_740/rolling_outside_low.wav"}
    self.SoundNames["rolling_medium2_740"] = {loop=true,"subway_trains/rusich/rolling/rolling_740/rolling_outside_medium2.wav"}
    self.SoundNames["rolling_high2_740"] = {loop=true,"subway_trains/rusich/rolling/rolling_740/rolling_outside_high2.wav"}
    self.SoundPositions["rolling_low_740"] = {480,1e12,Vector(-19.5,0,0),0.6*0.6}
    self.SoundPositions["rolling_medium2_740"] = {480,1e12,Vector(-19.5,0,0),0.90*0.6}
    self.SoundPositions["rolling_high2_740"] = {480,1e12,Vector(-19.5,0,0),1.00*0.6}	
	
    for i=1,4 do
        self.SoundNames["vent"..i] = {loop=true,"subway_trains/rusich/vent/vent_loop.wav"}
        self.SoundPositions["vent"..i] = {130,1e9,Vector(yventpos[i],0,30),0.2}
        self.SoundNames["vent1"..i] = {loop=true,"subway_trains/rusich/vent/vent_loop_1.wav"}
        self.SoundPositions["vent1"..i] = {130,1e9,Vector(yventpos[i],0,30),0.2}
    end		
	
    self.SoundPositions["pneumo_disconnect_close"] = {800,1e9,Vector(-295,40,-55),0.4}
    self.SoundPositions["pneumo_disconnect_open"] = {800,1e9,Vector(-295,40,-55),0.4}
    self.SoundNames["disconnect_valve"] = "subway_trains/common/switches/pneumo_disconnect_switch.mp3"	
	
    self.SoundNames["bbe_v1"]   = {"subway_trains/rusich/bbes/bbe.wav",loop = true}
    self.SoundPositions["bbe_v1"] = {800,1e9,Vector(50,0,-40),0.4}	
    self.SoundNames["bbe_v2"]   = {"subway_trains/rusich/bbes/bbe_1.wav",loop = true}
    self.SoundPositions["bbe_v2"] = {800,1e9,Vector(50,0,-40),0.4} 	
    self.SoundNames["bbe_v3"]   = {"subway_trains/rusich/bbes/bbe_new.wav",loop = true}
    self.SoundPositions["bbe_v3"] = {800,1e9,Vector(50,0,-40),0.4}		

	self.SoundNames["cab_door_open"] = "subway_trains/rusich/door/torec/door_torec_open_end.wav"
    self.SoundNames["cab_door_close"] = "subway_trains/rusich/door/torec/door_close_1.mp3"	
	local j = math.random (1,3)	
    self.SoundNames["release_rear"] = {loop=true,"subway_trains/rusich/pneumo_release_"..j..".wav"}
    self.SoundPositions["release_rear"] = {1200,1e9,Vector(600-144,0,-70),0.4}		

	local loop = math.random (1,2)
	local start = math.random (1,5)		
	local closed = math.random (1,5)	
	local open = math.random (1,3)	
    for i=0,2 do	
	for k=0,1 do	
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
end

ENT.AnnouncerPositions = {}
for i=1,3 do
    table.insert(ENT.AnnouncerPositions,{
	Vector(0-(i-1)*30+38,
	17*(i%2 > 0 and -1 or 1) ,44),450,0.5})
end  

ENT.SubwayTrain = nil