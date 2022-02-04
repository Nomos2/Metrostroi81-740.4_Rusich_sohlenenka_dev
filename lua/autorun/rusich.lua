vedro740 = vedro740 or {} --check 81-740 addon availability by other addons
--beb = beb or {} --uncomment to disable als autofreq


--[[	spawn correcting guide for server owners 

	insert this into /lua/weapons/gmod_toold/stools/train_spawner.lua after line 210 for fixing the rotation of wagons
	
		if (self.Train.ClassName == "gmod_subway_81-740_4") then
			rot = i % 2 == 1 or i==self.Settings.WagNum
		end
		
]]

--custom bogey and couple
timer.Simple(0,function()
	if not Metrostroi then return end
	
	local models = {
		["models/metrostroi_train/81-740/body/81-740_4_defualt_mos_front.mdl"] = true,
		["models/metrostroi_train/81-740/body/81-740_4_rear_reference.mdl"] = true,
		["models/metrostroi_train/81-740/body/81-740_4_physics.mdl"] = true,
		
		["models/metrostroi_train/81-741/body/81-741_4_defualt_mos_front.mdl"] = true,
		["models/metrostroi_train/81-741/body/81-741_4_rear_reference.mdl"] = true,
		["models/metrostroi_train/81-741/body/81-741_4_physics.mdl"] = true,
		
		["models/metrostroi_train/81-740/bogey/metro_bogey_740.mdl"] = true,
		["models/metrostroi_train/81-740/bogey/metro_bogey_garm.mdl"] = true, 
		["models/metrostroi_train/81-740/bogey/metro_bogey_notr.mdl"] = true,
		
		["models/metrostroi_train/81-740/bogey/metro_couple_740.mdl"] = true,
		
	}
	
	if SERVER then
		timer.Simple(1,function()
		
		local tbl = scripted_ents.Get("gmod_train_bogey")
		if tbl then	
		tbl.Types["740"] = {
        "models/metrostroi_train/81-740/bogey/metro_bogey_740.mdl",
        Vector(0,0.0,-10),Angle(0,90,0),"models/metrostroi_train/bogey/metro_wheels_collector.mdl",
		Vector(0,-61,-14),Vector(0,61,-14),
        nil,
        Vector(4.3,-63,-3.3),Vector(4.3,63,-3.3),
    }
	tbl.Types["740G"] = {
        "models/metrostroi_train/81-740/bogey/metro_bogey_garm.mdl",
        Vector(0,0.0,-10),Angle(0,90,0),"models/metrostroi_train/bogey/metro_wheels_collector.mdl",
        Vector(0,-61,-14),Vector(0,61,-14),
        nil,
        Vector(4.3,-63,-3.3),Vector(4.3,63,-3.3),
    }
	tbl.Types["740NOTR"] = {
        "models/metrostroi_train/81-740/bogey/metro_bogey_notr.mdl",
        Vector(0,0.0,-10),Angle(0,90,0),"models/metrostroi_train/bogey/metro_wheels_collector.mdl",
        Vector(0,-61,-14),Vector(0,61,-14),
        nil,
        Vector(4.3,-63,-3.3),Vector(4.3,63,-3.3),
    },
		scripted_ents.Register(tbl,"gmod_train_bogey")
			end
			
			tbl = scripted_ents.Get("gmod_train_couple")
			if tbl then
				tbl.Types["740"] = {
					"models/metrostroi_train/81-740/bogey/metro_couple_740.mdl",Vector(65,0,0),Vector(65.1,1,-4.9),Angle(0,-90,0)
				}
				tbl.Types["740F"] = {
					"models/hunter/plates/plate.mdl",Vector(65,0,0),Vector(65.1,1,-4.9),Angle(0,-90,0)
				}
				scripted_ents.Register(tbl,"gmod_train_couple")			
			end
		end)	
	end
end)

--skins
Metrostroi740Skins = nil
if not Metrostroi740Skins then Metrostroi740Skins = {} Metrostroi740Skins.Train = {} Metrostroi740Skins.Int = {} Metrostroi740Skins.Cab = {} end

function Metrostroi740SkinAdd(name, type, skin, model_740, model_741, cabin_door_right, cabin_door_left, passenger_door_1, passenger_door_2, door_741_end)

	if type == "body" then 
		if model_740 == "none" then
			model_740 = "models/metrostroi_train/81-740/body/81-740_4_defualt_mos_front.mdl"
		end
		if model_741 == "none" then
			model_741 = "models/metrostroi_train/81-741/body/81-741_4_defualt_mos.mdl"
		end
		if cabin_door_right == "none" then
			cabin_door_right = "models/metrostroi_train/81-740/cabine/cabin_right.mdl" 
		end
		if cabin_door_left == "none" then
			cabin_door_left = "models/metrostroi_train/81-740/cabine/cabin_left.mdl" 
		end
		if passenger_door_1 == "none" then
			passenger_door_1 = "models/metrostroi_train/81-740/body/81-740_leftdoor1.mdl"
		end
		if passenger_door_2 == "none" then
			passenger_door_2 = "models/metrostroi_train/81-740/body/81-740_leftdoor2.mdl"
		end
		if door_741_end == "none" then
			door_741_end = "models/metrostroi_train/81-741/body/door_br.mdl"
		end
		if skin == "none" then
			skin = 0
		end
		
		Metrostroi740Skins.Train[table.Count(Metrostroi740Skins.Train) + 1] = {Name = name, Skin = skin, Model_740 = model_740, Model_741 = model_741, Cabin_door_right = cabin_door_right, Cabin_door_left = cabin_door_left, Passenger_door_1 = passenger_door_1, Passenger_door_2 = passenger_door_2, Door_741_end = door_741_end}
		print("Added skin "..name.." on "..type.." for 81-740.4")
		
	elseif type == "cabin" then 
		if model_740 == "none" then
			model_740 = "models/metrostroi_train/81-740/cabine/pult/pult.mdl"
		end
		if skin == "none" then
			skin = 0
		end
		Metrostroi740Skins.Cab[table.Count(Metrostroi740Skins.Cab) + 1] = {Name = name, Skin = skin, panel = model_740}
		print("Added skin "..name.." on "..type.." for 81-740.4")
		
	elseif type == "interior" then 
		if model_740 == "none" then
			model_740 = "models/metrostroi_train/81-740/salon/salon.mdl" 
		end
		if model_741 == "none" then
			model_741 = "models/metrostroi_train/81-741/salon/salon.mdl" 
		end
		if cabin_door_right == "none" then
			cabin_door_right = "models/metrostroi_train/81-740/salon/handrails/handrails.mdl" 
		end
		if cabin_door_left == "none" then
			cabin_door_left = "models/metrostroi_train/81-741/salon/handrails/handrails.mdl" 
		end
		if skin == "none" then
			skin = 0
		end
		Metrostroi740Skins.Int[table.Count(Metrostroi740Skins.Int) + 1] = {Name = name, Skin = skin, Model_740 = model_740, Model_741 = model_741, Handrails_740 = cabin_door_right, Handrails_741 = cabin_door_left}
		print("Added skin "..name.." on "..type.." for 81-740.4")
		
	else
		print("ERROR with adding skin "..name.." on "..type.." for 81-740.4")
	end
end
local path = "metrostroi/740_skins/"
local files, directories = file.Find( path.."*.lua", "LUA" )
for k,v in pairs(files) do
	include(path..v)
	AddCSLuaFile(path..v)
end
if CLIENT then
	function Metrostroi740LoadTextures(self, skinsare)
		if self.skinarecalled then

		else
		self.Texture = self:GetNW2String("Texture")
		self.PassTexture = self:GetNW2String("PassTexture")
		self.CabTexture = self:GetNW2String("CabTexture")
		for k1,v1 in pairs(Metrostroi740Skins.Train) do
			if self.Texture == tostring(k1) then 
				self:SetNW2String("skin_body_740", v1.Model_740)
				self:SetNW2String("skin_body_741", v1.Model_741)
				self:SetNW2String("skin_door_left", v1.Cabin_door_left)
				self:SetNW2String("skin_door_right", v1.Cabin_door_right)
				self:SetNW2String("skin_door_pass_1", v1.Passenger_door_1)
				self:SetNW2String("skin_door_pass_2", v1.Passenger_door_2)
				self:SetNW2String("skin_door_end", v1.Door_741_end)
				self:SetNWInt("skin_skin_body", v1.Skin)
			end
		end
		for k1,v1 in pairs(Metrostroi740Skins.Cab) do
			if self.CabTexture == tostring(k1) then 
				self:SetNW2String("skin_cabin_panel", v1.panel)
				self:SetNW2Int("skin_skin_panel", v1.Skin)
			end
		end
		for k1,v1 in pairs(Metrostroi740Skins.Int) do
			if self.PassTexture == tostring(k1) then 
				self:SetNW2String("skin_interior_740", v1.Model_740)
				self:SetNW2String("skin_interior_741", v1.Model_741)
				self:SetNW2String("skin_handrails_740", v1.Handrails_740)
				self:SetNW2String("skin_handrails_741", v1.Handrails_741)
				self:SetNW2Int("skin_skin_interior", v1.Skin)
				
			end
		end
	end
end
end

--mezhvag
hook.Add("Metrostroi.AddMezhvagToSpawner","81_740_stock",function(tab)
	tab["gmod_subway_81-740_4"] = {nil,nil,0}
	tab["gmod_subway_81-741_4"] = {nil,Vector(-340,0,-10),45}
end)