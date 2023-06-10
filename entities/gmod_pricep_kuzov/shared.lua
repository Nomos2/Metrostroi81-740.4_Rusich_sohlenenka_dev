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

ENT.NoTrain = true

ENT.Category		= "Metrostroi (utility)"
ENT.Spawnable		= false
ENT.AdminSpawnable	= false
ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Model 			= "models/metrostroi_train/81-740/body/81-740_4_rear_reference.mdl"

ENT.SubwayTrain = nil