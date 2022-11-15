vedro740 = vedro740 or {} --check 81-740 addon availability by other addons
--beb = beb or {} --uncomment to disable als autofreq

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
		
			-- регистрируем тележки
			local tbl = scripted_ents.Get("gmod_train_bogey")
			if tbl then	
				tbl.Types["740"] = { -- тележка
					"models/metrostroi_train/81-740/bogey/metro_bogey_740.mdl",
					Vector(0,0.0,-10),Angle(0,90,0),"models/metrostroi_train/bogey/metro_wheels_collector.mdl",
					Vector(0,-61,-14),Vector(0,61,-14),
					nil,
					Vector(4.3,-63,-3.3),Vector(4.3,63,-3.3),
				}
				tbl.Types["740G"] = { -- тележка + гармошка
					"models/metrostroi_train/81-740/bogey/metro_bogey_garm.mdl",
					Vector(0,0.0,-10),Angle(0,90,0),"models/metrostroi_train/bogey/metro_wheels_collector.mdl",
					Vector(0,-61,-14),Vector(0,61,-14),
					nil,
					Vector(4.3,-63,-3.3),Vector(4.3,63,-3.3),
				}
				tbl.Types["740NOTR"] = { -- ???
					"models/metrostroi_train/81-740/bogey/metro_bogey_notr.mdl",
					Vector(0,0.0,-10),Angle(0,90,0),"models/metrostroi_train/bogey/metro_wheels_collector.mdl",
					Vector(0,-61,-14),Vector(0,61,-14),
					nil,
					Vector(4.3,-63,-3.3),Vector(4.3,63,-3.3),
				}
				scripted_ents.Register(tbl,"gmod_train_bogey") -- регистрируем
			end
			
			-- регистрируем сцепку
			local tbl = scripted_ents.Get("gmod_train_couple")
			if tbl then
				tbl.Types["740"] = { -- сцепка
					"models/metrostroi_train/81-740/bogey/metro_couple_740.mdl",Vector(65,0,0),Vector(65.1,1,-4.9),Angle(0,-90,0)
				}
				scripted_ents.Register(tbl,"gmod_train_couple")	-- регистрируем
			end
		end)	
	end
end)

--mezhvag
hook.Add("Metrostroi.AddMezhvagToSpawner","81_740_stock",function(tab)
	tab["gmod_subway_81-740_4_mvm"] = {nil,nil,0}
	tab["gmod_subway_81-741_4_mvm"] = {nil,Vector(-340,0,-10),45}
end)