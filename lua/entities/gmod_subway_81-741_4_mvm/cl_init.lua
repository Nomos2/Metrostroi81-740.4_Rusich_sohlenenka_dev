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

include("shared.lua")
Metrostroi.Version = 1537278077
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
    pos = Vector(650,18.11,-5), --446 -- 14 -- -0,5
    ang = Angle(0,0,90),
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

ENT.ButtonMap["FrontDoor"] = {
    pos = Vector(654,15,55), ---334.8,14.5,9
    ang = Angle(0,-90,90),
    width = 642,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "FrontDoor",x=0,y=0,w=642,h=2000, tooltip="", model = {
            var="FrontDoor",sndid="door_cab_f",
            sndvol = 1, snd = function(val) return val and "door_cab_open" or "door_cab_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,180,0),
        }},
    }
}

ENT.ButtonMap["PVZ_otsek_open"] = {
    pos = Vector(640,62,-9), --446 -- 14 -- -0,5
    ang = Angle(0,-90,90),
    width = 642,
    height = 500,
    scale = 0.0625,
    buttons = {
        {ID = "PVZ_otsek",x=0,y=0,w=642,h=500, tooltip=""} ,
    }
}
ENT.ButtonMap["PVZ_otsek_close"] = {
    pos = Vector(520,45,-9), --446 -- 14 -- -0,5
    ang = Angle(0,0,90),
    width = 442,
    height = 400,
    scale = 0.0625,
    buttons = {
        {ID = "PVZ_otsek",x=0,y=0,w=442,h=400, tooltip=""} ,
    }
}

ENT.ClientProps["salon"] = {
	model = "models/metrostroi_train/81-741/salon/salon.mdl",
	pos = Vector(322.6,0,0),
	ang = Angle(0,180,0),
	hide = 2,
}
ENT.ClientProps["otsek"] = {
	model = "models/metrostroi_train/81-741/salon/otsek.mdl",
	pos = Vector(322.6,0,0),
	ang = Angle(0,180,0),
	hide = 2,
}
ENT.ClientProps["otsek_open"] = {
	model = "models/metrostroi_train/81-741/salon/otsek.mdl",
	pos = Vector(587.6,-275,0),
	ang = Angle(0,270,0),
	hide = 2,
}
ENT.ClientProps["handrails"] = {
	model = "models/metrostroi_train/81-741/salon/handrails/handrails.mdl",
	pos = Vector(322.8,0,0),
	ang = Angle(0,-180,0),
	hide = 2,
}
ENT.ClientProps["door_cab_f"] = {
	model = "models/metrostroi_train/81-740/salon/door_br.mdl",
	pos = Vector(657,-15.2,8.8),
	ang = Angle(0,0,0.1),
	scale = 1.001,
	hide = 2,
}
ENT.ClientProps["krepezh"] = {
    model = "models/metrostroi_train/81-740/body/krepezh.mdl",
    pos = Vector(257.6,0,-74.6),
    ang = Angle(0,0,0),
    nohide = true,
}

----Аварийка
ENT.ClientProps["lamps_salon_on_avar_front1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(522.4,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_avar_front2"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(88.4,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
----Аварийка

ENT.ClientProps["lamps_salon_on_front_left1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(34.4,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front_left2"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(88.4,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front_left3"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(144.4,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front_left4"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(197,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front_left5"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(251,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front_left6"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(305,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front_left7"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(359,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front_left8"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(413,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front_left9"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(467,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front_left10"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(522.4,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front_left11"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(576.4,-0.2,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}


ENT.ClientProps["lamps_salon_on_front1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(34.4,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front2"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(88.4,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front3"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(144.4,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front4"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(197,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front5"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(251,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front6"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(305,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front7"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(359,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front8"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(413,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front9"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(467,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front10"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(522.4,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["lamps_salon_on_front11"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(576.4,57.8,-74.5),
    ang = Angle(0,0,0),
	hide = 2,
}

ENT.ClientProps["lamps_salon_off"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_off.mdl",
    pos = Vector(379,0,0),
    ang = Angle(0,0,0),
	nohide = true,
}
ENT.ClientProps["handrails_offside_front"] = {
    model = "models/metrostroi_train/81-740/body/740_body_additional.mdl",
    pos = Vector(300.9,-10,-80),
    ang = Angle(0,0.2,0),
    nohide = true,
}
ENT.ButtonMap["Tickers"] = {
    pos = Vector(35.9, -27.5, 66.0), 
    ang = Angle(0,90,90),
    width = 1024,
    height = 64,
    scale = 0.0545,
    hide=true,
    hideseat=1,
}
ENT.ButtonMap["GV"] = {
    pos = Vector(364,-60,-82),
    ang = Angle(0,90,-90),
    width = 110,
    height = 110,
    scale = 0.1,
    buttons = {
        {ID = "GVToggle",x=0, y=0, w= 110,h = 110, tooltip="", model = {
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
	hideseat = 0.5,
}

ENT.ClientProps["gv_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ClientProps["gv"].pos,
    ang = Angle(-90,90,-90),
	hideseat = 0.5,
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
        {ID = "FrontBrakeLineIsolationToggle",x=0, y=0, w=300, h=100, tooltip=""},
        {ID = "FrontTrainLineIsolationToggle",x=400, y=0, w=300, h=100, tooltip=""},
    }
}
ENT.ClientProps["FrontBrake"] = {
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(660, -25, -56.5), 
    ang = Angle(15,-90,0),
	hide = 1,
}
ENT.ClientProps["FrontTrain"] = {
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(660, 25, -56.5),
    ang = Angle( -15,-90,0),
	hide = 1,
}
ENT.ClientSounds["FrontBrakeLineIsolation"] = {{"FrontBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["FrontTrainLineIsolation"] = {{"FrontTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}

--[[for i=1,29 do
ENT.ClientProps["led_l_f4_new"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_r.mdl",
        pos = Vector(-(i-1.99)*1.435+375,85.9,13.2), 
        ang = Angle(0,180,0),
        skin=6,
		scale = 1.01,		
		hide = 0.49,    
}
ENT.ClientProps["led_l_f4_new_ob"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_r.mdl",
        pos = Vector(-(i-1.99)*1.435+375,85.9,13.2), 
        ang = Angle(0,180,0),
        skin=6,
		scale = 1.01,		
		hide = 0.49,       
}
end

for i=1,31 do
ENT.ClientProps["led_l_f1_new"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1.99)*1.438+387.9,11.7,13.2), 
        ang = Angle(0,180,0),
        skin=6,
		scale = 1.01,		
		hide = 0.49,
}
ENT.ClientProps["led_l_f1_new_ob"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1.99)*1.438+387.9,11.7,13.2), 
        ang = Angle(0,180,0),
        skin=6,
		scale = 1.01,		
		hide = 0.49,    
}
end 

for i=1,32 do
ENT.ClientProps["led_l_f_new"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1.99)*1.425+156.25,11.7,13.2), 
        ang = Angle(0,180,0),
        skin=6,
		scale = 1.01,		
		hide = 0.49,    
}
ENT.ClientProps["led_l_f_new_ob"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1.99)*1.425+156.25,11.7,13.2), 
        ang = Angle(0,180,0),
        skin=6,
		scale = 1.01,		
        hide = 0.49,     
}
ENT.ClientProps["led_l_f2_new"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1.99)*1.425+620.3,11.7,13.2), 
        ang = Angle(0,180,0),
        skin=6,
		scale = 1.01,		
        hide = 0.49,   
}
ENT.ClientProps["led_l_f2_new_ob"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1.99)*1.425+620.3,11.7,13.2), 
        ang = Angle(0,180,0),
        skin=6,
		scale = 1.01,		
        hide = 0.49,    
}
ENT.ClientProps["led_l_f3_new"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_r.mdl",
        pos = Vector(-(i-1.99)*1.430+612.81,85.9,13.2), 
        ang = Angle(0,180,0),
        skin=6,
		scale = 1.01,		
        hide = 0.49,   
}
ENT.ClientProps["led_l_f3_new_ob"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_r.mdl",
        pos = Vector(-(i-1.99)*1.430+612.81,85.9,13.2), 
        ang = Angle(0,180,0),
        skin=6,
		scale = 1.01,		
        hide = 0.49, 
}
ENT.ClientProps["led_l_f5_new"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_r.mdl",
        pos = Vector(-(i-1.99)*1.425+148.5,85.9,13.2), 
        ang = Angle(0,180,0),
        skin=6,
		scale = 1.01,		
        hide = 0.49,         
}
ENT.ClientProps["led_l_f5_new_ob"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_r.mdl",
        pos = Vector(-(i-1.99)*1.425+148.5,85.9,13.2), 
        ang = Angle(0,180,0),
        skin=6,
		scale = 1.01,		
        hide = 0.49,       
}
end]]
--Новые модели 2023.
ENT.ClientProps["Zavod_table_front"] = { --Заводская табличка
    model = "models/metrostroi_train/81-741/salon/zavod.mdl",
	pos = Vector(654.56,15,60),
    ang = Angle(90,-180,0),
	hide = 1,
	scale = 3,	
}
ENT.ClientProps["Naddver_off_right"] = { 
    model = "models/metrostroi_train/81-741/salon/naddverka_off.mdl",
	pos = Vector(360.5,0.05,0),
    ang = Angle(0,0,0),
	scale = 1,
	hide = 2, 	
}
ENT.ClientProps["Naddver_off_left"] = { 
    model = "models/metrostroi_train/81-741/salon/naddverka_off.mdl",
	pos = Vector(325.3,-0.03,0.05),
    ang = Angle(0,180,0),
	scale = 1,
	hide = 2, 	
}
--Задняя часть
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
        {ID = "RearTrainLineIsolationToggle",x=400, y=0, w=300, h=100, tooltip=""},
        {ID = "RearBrakeLineIsolationToggle",x=000, y=0, w=300, h=100, tooltip=""},
    }
}
--Задняя часть наддверок
--[[for i=1,29 do
ENT.ClientProps["led_l_f2_rear"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1)*1.435+29.81,11.54,13.3),        
        ang = Angle(0,180,0),
        skin=6,
        hide = 0.49,
		callback = function(ent,cl_ent)
			if cl_ent:GetParent() == ent:GetNW2Entity("ent") then return end
			cl_ent:SetParent(ent:GetNW2Entity("ent"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_f2_rear"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_f2_rear"..i].ang)
    end,      
}
ENT.ClientProps["led_l_f2_rear_ob"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1)*1.435+29.81,11.54,13.3),        
        ang = Angle(0,180,0),
        skin=6,
        hide = 0.49,
		callback = function(ent,cl_ent)
			if cl_ent:GetParent() == ent:GetNW2Entity("ent") then return end
			cl_ent:SetParent(ent:GetNW2Entity("ent"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_f2_rear_ob"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_f2_rear_ob"..i].ang)
    end,      
}
end
for i=1,32 do
ENT.ClientProps["led_l_f1_rear"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1)*1.430-203.81,11.54,13.3),        
        ang = Angle(0,180,0),
        skin=6,
        hide = 0.49,
		callback = function(ent,cl_ent)
			if cl_ent:GetParent() == ent:GetNW2Entity("ent") then return end
			cl_ent:SetParent(ent:GetNW2Entity("ent"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_f1_rear"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_f1_rear"..i].ang)
    end,      
}
ENT.ClientProps["led_l_f1_rear_ob"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1)*1.430-203.81,11.54,13.3),        
        ang = Angle(0,180,0),
        skin=6,
        hide = 0.49,
		callback = function(ent,cl_ent)
			if cl_ent:GetParent() == ent:GetNW2Entity("ent") then return end
			cl_ent:SetParent(ent:GetNW2Entity("ent"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_f1_rear_ob"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_f1_rear_ob"..i].ang)
    end,      
}
ENT.ClientProps["led_l_f3_rear"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1)*1.430+260.31,11.5,13.3),        
        ang = Angle(0,180,0),
        skin=6,
        hide = 0.49,
		callback = function(ent,cl_ent)
			if cl_ent:GetParent() == ent:GetNW2Entity("ent") then return end
			cl_ent:SetParent(ent:GetNW2Entity("ent"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_f3_rear"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_f3_rear"..i].ang)
    end,      
}
ENT.ClientProps["led_l_f3_rear_ob"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1)*1.430+260.31,11.5,13.3),        
        ang = Angle(0,180,0),
        skin=6,
        hide = 0.49,
		callback = function(ent,cl_ent)
			if cl_ent:GetParent() == ent:GetNW2Entity("ent") then return end
			cl_ent:SetParent(ent:GetNW2Entity("ent"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_f3_rear_ob"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_f3_rear_ob"..i].ang)
    end,      
}
ENT.ClientProps["led_l_r2_rear"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_r.mdl",
        pos = Vector(-(i-1)*1.430-211.45,85.7,13.3),        
        ang = Angle(0,180,0),
        skin=6,
        hide = 0.49,
		callback = function(ent,cl_ent)
			if cl_ent:GetParent() == ent:GetNW2Entity("ent") then return end
			cl_ent:SetParent(ent:GetNW2Entity("ent"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_r2_rear"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_r2_rear"..i].ang)
    end,      
}
ENT.ClientProps["led_l_r2_rear_ob"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_r.mdl",
        pos = Vector(-(i-1)*1.430-211.45,85.7,13.3),        
        ang = Angle(0,180,0),
        skin=6,
        hide = 0.49,
		callback = function(ent,cl_ent)
			if cl_ent:GetParent() == ent:GetNW2Entity("ent") then return end
			cl_ent:SetParent(ent:GetNW2Entity("ent"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_r2_rear_ob"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_r2_rear_ob"..i].ang)
    end,      
}
ENT.ClientProps["led_l_r4_rear"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_r.mdl",
        pos = Vector(-(i-1)*1.430+252.65,85.7,13.3),        
        ang = Angle(0,180,0),
        skin=6,
        hide = 0.49,
		callback = function(ent,cl_ent)
			if cl_ent:GetParent() == ent:GetNW2Entity("ent") then return end
			cl_ent:SetParent(ent:GetNW2Entity("ent"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_r4_rear"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_r4_rear"..i].ang)
    end,      
}
ENT.ClientProps["led_l_r4_rear_ob"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_r.mdl",
        pos = Vector(-(i-1)*1.430+252.65,85.7,13.3),        
        ang = Angle(0,180,0),
        skin=6,
        hide = 0.49,
		callback = function(ent,cl_ent)
			if cl_ent:GetParent() == ent:GetNW2Entity("ent") then return end
			cl_ent:SetParent(ent:GetNW2Entity("ent"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_r4_rear_ob"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_r4_rear_ob"..i].ang)
    end,      
}
end

for i=1,31 do
ENT.ClientProps["led_l_r1_rear"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_r.mdl",
        pos = Vector(-(i-1)*1.440+19.93,85.7,13.3),        
        ang = Angle(0,180,0),
        skin=6,
        hide = 0.49,
		callback = function(ent,cl_ent)
			if cl_ent:GetParent() == ent:GetNW2Entity("ent") then return end
			cl_ent:SetParent(ent:GetNW2Entity("ent"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_r1_rear"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_r1_rear"..i].ang)
    end,      
}
ENT.ClientProps["led_l_r1_rear_ob"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_r.mdl",
        pos = Vector(-(i-1)*1.440+19.93,85.7,13.3),        
        ang = Angle(0,180,0),
        skin=6,
        hide = 0.49,
		callback = function(ent,cl_ent)
			if cl_ent:GetParent() == ent:GetNW2Entity("ent") then return end
			cl_ent:SetParent(ent:GetNW2Entity("ent"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_r1_rear_ob"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_r1_rear_ob"..i].ang)
    end,      
}
end]]
--------------------------------------------------------------------------------
-- Add doors
--------------------------------------------------------------------------------
local function GetDoorPosition(b,k,j)
	if j == 0 
	then return Vector(591.9 - 35.0*k     - 232.1*b,-67.5*(1-2*k),4)
	else return Vector(592 - 35.0*(1-k) - 232.1*b,-66*(1-2*k),4)
	end
end

for b=0,2 do
	for k=0,1 do
		ENT.ClientProps["door"..b.."x"..k.."a"] = {
			model =  "models/metrostroi_train/81-740/body/81-740_leftdoor2.mdl",
			pos = GetDoorPosition(b,k,0),
			ang = Angle(0,90 +180*k,0),   
			scale = 1.001,				
			hide = 2,
		}
		ENT.ClientProps["door"..b.."x"..k.."b"] = {
			model =  "models/metrostroi_train/81-740/body/81-740_leftdoor1.mdl",
			pos = GetDoorPosition(b,k,1),
			ang = Angle(0,90 +180*k,0),   
			scale = 1.001,				
			hide = 2,
		}
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
	
	self.FrontBogey = self:GetNW2Entity("FrontBogey")	
	self.RearBogey = self:GetNW2Entity("RearBogey")
	self.MiddleBogey = self:GetNW2Entity("MiddleBogey")
	self.RearCouple = self:GetNW2Entity("RearCouple")
	
	self.PassengerEnts = {}
    self.PassengerPositions = {}
	
	self.PassengerEntsRear = {}
    self.PassengerPositionsRear = {}	
	
	self.PassengerEntsRear = {}
    self.PassengerPositions = {}
	
	if not self:GetNW2Bool("metrostroi_custom_passengers") then 	
    self.PassengerModelsRear = {
        "models/metrostroi/passengers/f1.mdl",
        "models/metrostroi/passengers/f2.mdl",
        "models/metrostroi/passengers/f3.mdl",
        "models/metrostroi/passengers/f4.mdl",
        "models/metrostroi/passengers/f5.mdl",		
        "models/metrostroi/passengers/m1.mdl",
        "models/metrostroi/passengers/m2.mdl",
        "models/metrostroi/passengers/m3.mdl",		
        "models/metrostroi/passengers/m4.mdl",
        "models/metrostroi/passengers/m5.mdl",
		}
	else
    self.PassengerModelRearCustom = {
		"models/humans/group01/female_01.mdl",
		"models/humans/group01/female_02.mdl",
		"models/humans/group01/female_03.mdl",
		"models/humans/group01/female_04.mdl",
		"models/humans/group01/female_06.mdl",
		"models/humans/group01/female_07.mdl",
		"models/humans/group01/male_01.mdl",
		"models/humans/group01/male_02.mdl",
		"models/humans/group01/male_03.mdl",
		"models/humans/group01/male_04.mdl",
		"models/humans/group01/male_05.mdl",
		"models/humans/group01/male_06.mdl",
		"models/humans/group01/male_07.mdl",
		"models/humans/group01/male_08.mdl",
		"models/humans/group01/male_09.mdl",
		}

local female_sequences = {2,5,6,7,11,17}
local male_sequences = {2,3,4,6,10}			
		
	end		
	
end	

for m=0,3 do
    ENT.ClientProps["TrainNumberR"..m] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(635-m*6.6+4*6.6/2,-63.35,18),
        ang = Angle(0,0,-3.29),
		hide = 1,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end	

if Metrostroi.Version >= 1537278077 then
function ENT:ReInitBogeySounds(bogey)
	if not IsValid(bogey) then return end
	
	local MotorType = self:GetNW2Int("MotorType")
	if self:GetNW2Int("MotorType")==1 then		

    -- Bogey-related sounds
    bogey.SoundNames = {}
    bogey.EngineSNDConfig = {}
    
	bogey.MotorSoundType = bogey:GetNWInt("MotorSoundType",1)
    for k,v in pairs(bogey.EngineSNDConfig) do bogey:SetSoundState(v[1],0,0) end
    table.insert(bogey.EngineSNDConfig,{"ted1_740" ,08,00,16,  1})--40
    table.insert(bogey.EngineSNDConfig,{"ted2_740" ,16,08-4,24,1})--35
    table.insert(bogey.EngineSNDConfig,{"ted3_740" ,24,16-4,32,1})--32
    table.insert(bogey.EngineSNDConfig,{"ted4_740" ,32,24-4,40,1})--28
    table.insert(bogey.EngineSNDConfig,{"ted5_740" ,40,32-4,48,1})--22
    table.insert(bogey.EngineSNDConfig,{"ted6_740" ,48,40-4,56,1})--18
    table.insert(bogey.EngineSNDConfig,{"ted7_740" ,56,48-4,64,1})--15
    table.insert(bogey.EngineSNDConfig,{"ted8_740" ,64,56-4,72,1})--10
    table.insert(bogey.EngineSNDConfig,{"ted9_740" ,72,64-4,80,1})--07
    table.insert(bogey.EngineSNDConfig,{"ted10_740",80,72-4,88,1})--05
    --table.insert(bogey.EngineSNDConfig,{"ted11_720",88,80-4   ,0.00})--02

    bogey.SoundNames = {}
	
    bogey.SoundNames["ted1_703"]  = "subway_trains/bogey/engines/703/speed_8.wav"
    bogey.SoundNames["ted2_703"]  = "subway_trains/bogey/engines/703/speed_16.wav"
    bogey.SoundNames["ted3_703"]  = "subway_trains/bogey/engines/703/speed_24.wav"
    bogey.SoundNames["ted4_703"]  = "subway_trains/bogey/engines/703/speed_32.wav"
    bogey.SoundNames["ted5_703"]  = "subway_trains/bogey/engines/703/speed_40.wav"
    bogey.SoundNames["ted6_703"]  = "subway_trains/bogey/engines/703/speed_48.wav"
    bogey.SoundNames["ted7_703"]  = "subway_trains/bogey/engines/703/speed_56.wav"
    bogey.SoundNames["ted8_703"]  = "subway_trains/bogey/engines/703/speed_64.wav"
    bogey.SoundNames["ted9_703"]  = "subway_trains/bogey/engines/703/speed_72.wav"
    bogey.SoundNames["ted10_703"] = "subway_trains/bogey/engines/703/speed_80.wav"
    bogey.SoundNames["ted11_703"] = "subway_trains/bogey/engines/703/speed_88.wav"
    --bogey.SoundNames["tedm_703"]  = "subway_trains/bogey/engines/703/engines_medium.wav"

    --bogey.SoundNames["ted11_720"] = "subway_trains/760/engines/engine_80.wav"
    bogey.SoundNames["ted1_740"]  = "subway_trains/rusich/engines/engine_8.wav"
    bogey.SoundNames["ted2_740"]  = "subway_trains/rusich/engines/engine_16.wav"
    bogey.SoundNames["ted3_740"]  = "subway_trains/rusich/engines/engine_24.wav"
    bogey.SoundNames["ted4_740"]  = "subway_trains/rusich/engines/engine_32.wav"
    bogey.SoundNames["ted5_740"]  = "subway_trains/rusich/engines/engine_40.wav"
    bogey.SoundNames["ted6_740"]  = "subway_trains/rusich/engines/engine_48.wav"
    bogey.SoundNames["ted7_740"]  = "subway_trains/rusich/engines/engine_56.wav"
    bogey.SoundNames["ted8_740"]  = "subway_trains/rusich/engines/engine_64.wav"
    bogey.SoundNames["ted9_740"]  = "subway_trains/rusich/engines/engine_72.wav"
    bogey.SoundNames["ted10_740"] = "subway_trains/rusich/engines/engine_80.wav"

    --bogey.SoundNames["ted11_720"] = "subway_trains/760/engines/engine_80.wav"
    bogey.SoundNames["ted11_720"] = "subway_trains/bogey/engines/720/speed_88.wav"
    bogey.SoundNames["ted1_720"]  = "subway_trains/bogey/engines/720/speed_8.wav"
    bogey.SoundNames["ted2_720"]  = "subway_trains/bogey/engines/720/speed_16.wav"
    bogey.SoundNames["ted3_720"]  = "subway_trains/bogey/engines/720/speed_24.wav"
    bogey.SoundNames["ted4_720"]  = "subway_trains/bogey/engines/720/speed_32.wav"
    bogey.SoundNames["ted5_720"]  = "subway_trains/bogey/engines/720/speed_40.wav"
    bogey.SoundNames["ted6_720"]  = "subway_trains/bogey/engines/720/speed_48.wav"
    bogey.SoundNames["ted7_720"]  = "subway_trains/bogey/engines/720/speed_56.wav"
    bogey.SoundNames["ted8_720"]  = "subway_trains/bogey/engines/720/speed_64.wav"
    bogey.SoundNames["ted9_720"]  = "subway_trains/bogey/engines/720/speed_72.wav"
    bogey.SoundNames["ted10_720"] = "subway_trains/bogey/engines/720/speed_80.wav"
    --*0.975
    --*1.025
	local skr = math.random (1,2)
	local skripit = math.random (1,5)	
    bogey.SoundNames["flangea"]      = "subway_trains/rusich/bogey/skrip1_"..skr..".wav"
    bogey.SoundNames["flangeb"]      = "subway_trains/rusich/bogey/skrip2_"..skripit..".wav"
    bogey.SoundNames["flange1"]      = "subway_trains/rusich/bogey/flange_9.wav"
    bogey.SoundNames["flange2"]      = "subway_trains/rusich/bogey/Flange_10.wav"
    bogey.SoundNames["brakea_loop1"]       = "subway_trains/rusich/bogey/braking_async3.wav"
    bogey.SoundNames["brakea_loop2"]       = "subway_trains/rusich/bogey/braking_async3.wav"
    bogey.SoundNames["brake_loop1"]       = "subway_trains/bogey/brake_rattle3.wav"
    bogey.SoundNames["brake_loop2"]       = "subway_trains/bogey/brake_rattle4.wav"
    bogey.SoundNames["brake_loop3"]       = "subway_trains/bogey/brake_rattle5.wav"
    bogey.SoundNames["brake_loop4"]       = "subway_trains/bogey/brake_rattle6.wav"
    bogey.SoundNames["brake_loopb"]       = "subway_trains/common/junk/junk_background_braking1.wav"
    bogey.SoundNames["brake2_loop1"]       = "subway_trains/bogey/brake_rattle2.wav"
    bogey.SoundNames["brake2_loop2"]       = "subway_trains/bogey/brake_rattle_h.wav"
    bogey.SoundNames["brake_squeal1"]       = "subway_trains/bogey/brake_squeal1.wav"
    bogey.SoundNames["brake_squeal2"]       = "subway_trains/bogey/brake_squeal2.wav"

    -- Remove old sounds
    if bogey.Sounds then
        for k,v in pairs(bogey.Sounds) do
            v:Stop()
        end
    end

    -- Create sounds
    bogey.Sounds = {}
    bogey.Playing = {}
    for k,v in pairs(bogey.SoundNames) do
        --if not file.Exists(v, "MOD") then
--          bogey.SoundNames[k] = nil
        --end
        util.PrecacheSound(v)
        local e = bogey
        if (k == "brake3a") and IsValid(bogey:GetNW2Entity("TrainWheels")) then
            e = bogey:GetNW2Entity("TrainWheels")
        end
        bogey.Sounds[k] = CreateSound(e, Sound(v))
    end

    bogey.Async = nil
    --bogey.MotorSoundType = nil

end
	if self:GetNW2Int("MotorType")==2 then		

    -- Bogey-related sounds
    bogey.SoundNames = {}
    bogey.EngineSNDConfig = {}
    
	bogey.MotorSoundType = bogey:GetNWInt("MotorSoundType",1)
    for k,v in pairs(bogey.EngineSNDConfig) do bogey:SetSoundState(v[1],0,0) end
    table.insert(bogey.EngineSNDConfig,{"ted1_740" ,08,00,16,  1})--40
    table.insert(bogey.EngineSNDConfig,{"ted2_740" ,16,08-4,24,1})--35
    table.insert(bogey.EngineSNDConfig,{"ted3_740" ,24,16-4,32,1})--32
    table.insert(bogey.EngineSNDConfig,{"ted4_740" ,32,24-4,40,1})--28
    table.insert(bogey.EngineSNDConfig,{"ted5_740" ,40,32-4,48,1})--22
    table.insert(bogey.EngineSNDConfig,{"ted6_740" ,48,40-4,56,1})--18
    table.insert(bogey.EngineSNDConfig,{"ted7_740" ,56,48-4,64,1})--15
    table.insert(bogey.EngineSNDConfig,{"ted8_740" ,64,56-4,72,1})--10
    table.insert(bogey.EngineSNDConfig,{"ted9_740" ,72,64-4,80,1})--07
    table.insert(bogey.EngineSNDConfig,{"ted10_740",80,72-4,88,1})--05

    bogey.SoundNames = {}
	
    bogey.SoundNames["ted1_703"]  = "subway_trains/bogey/engines/703/speed_8.wav"
    bogey.SoundNames["ted2_703"]  = "subway_trains/bogey/engines/703/speed_16.wav"
    bogey.SoundNames["ted3_703"]  = "subway_trains/bogey/engines/703/speed_24.wav"
    bogey.SoundNames["ted4_703"]  = "subway_trains/bogey/engines/703/speed_32.wav"
    bogey.SoundNames["ted5_703"]  = "subway_trains/bogey/engines/703/speed_40.wav"
    bogey.SoundNames["ted6_703"]  = "subway_trains/bogey/engines/703/speed_48.wav"
    bogey.SoundNames["ted7_703"]  = "subway_trains/bogey/engines/703/speed_56.wav"
    bogey.SoundNames["ted8_703"]  = "subway_trains/bogey/engines/703/speed_64.wav"
    bogey.SoundNames["ted9_703"]  = "subway_trains/bogey/engines/703/speed_72.wav"
    bogey.SoundNames["ted10_703"] = "subway_trains/bogey/engines/703/speed_80.wav"
    bogey.SoundNames["ted11_703"] = "subway_trains/bogey/engines/703/speed_88.wav"
    --bogey.SoundNames["tedm_703"]  = "subway_trains/bogey/engines/703/engines_medium.wav"

    --bogey.SoundNames["ted11_720"] = "subway_trains/760/engines/engine_80.wav"
    bogey.SoundNames["ted1_740"]  = "subway_trains/rusich/engines_new/engine_8.wav"
    bogey.SoundNames["ted2_740"]  = "subway_trains/rusich/engines_new/engine_16.wav"
    bogey.SoundNames["ted3_740"]  = "subway_trains/rusich/engines_new/engine_24.wav"
    bogey.SoundNames["ted4_740"]  = "subway_trains/rusich/engines_new/engine_32.wav"
    bogey.SoundNames["ted5_740"]  = "subway_trains/rusich/engines_new/engine_40.wav"
    bogey.SoundNames["ted6_740"]  = "subway_trains/rusich/engines_new/engine_48.wav"
    bogey.SoundNames["ted7_740"]  = "subway_trains/rusich/engines_new/engine_56.wav"
    bogey.SoundNames["ted8_740"]  = "subway_trains/rusich/engines_new/engine_64.wav"
    bogey.SoundNames["ted9_740"]  = "subway_trains/rusich/engines_new/engine_72.wav"
    bogey.SoundNames["ted10_740"] = "subway_trains/rusich/engines_new/engine_80.wav"

    --bogey.SoundNames["ted11_720"] = "subway_trains/760/engines/engine_80.wav"
    bogey.SoundNames["ted11_720"] = "subway_trains/bogey/engines/720/speed_88.wav"
    bogey.SoundNames["ted1_720"]  = "subway_trains/bogey/engines/720/speed_8.wav"
    bogey.SoundNames["ted2_720"]  = "subway_trains/bogey/engines/720/speed_16.wav"
    bogey.SoundNames["ted3_720"]  = "subway_trains/bogey/engines/720/speed_24.wav"
    bogey.SoundNames["ted4_720"]  = "subway_trains/bogey/engines/720/speed_32.wav"
    bogey.SoundNames["ted5_720"]  = "subway_trains/bogey/engines/720/speed_40.wav"
    bogey.SoundNames["ted6_720"]  = "subway_trains/bogey/engines/720/speed_48.wav"
    bogey.SoundNames["ted7_720"]  = "subway_trains/bogey/engines/720/speed_56.wav"
    bogey.SoundNames["ted8_720"]  = "subway_trains/bogey/engines/720/speed_64.wav"
    bogey.SoundNames["ted9_720"]  = "subway_trains/bogey/engines/720/speed_72.wav"
    bogey.SoundNames["ted10_720"] = "subway_trains/bogey/engines/720/speed_80.wav"
    --*0.975
    --*1.025
	local skr = math.random (1,2)
	local skripit = math.random (1,5)	
    bogey.SoundNames["flangea"]      = "subway_trains/rusich/bogey/skrip1_"..skr..".wav"
    bogey.SoundNames["flangeb"]      = "subway_trains/rusich/bogey/skrip2_"..skripit..".wav"
    bogey.SoundNames["flange1"]      = "subway_trains/rusich/bogey/flange_9.wav"
    bogey.SoundNames["flange2"]      = "subway_trains/rusich/bogey/Flange_10.wav"
    bogey.SoundNames["brakea_loop1"]       = "subway_trains/rusich/bogey/braking_async3.wav"
    bogey.SoundNames["brakea_loop2"]       = "subway_trains/rusich/bogey/braking_async3.wav"
    bogey.SoundNames["brake_loop1"]       = "subway_trains/bogey/brake_rattle3.wav"
    bogey.SoundNames["brake_loop2"]       = "subway_trains/bogey/brake_rattle4.wav"
    bogey.SoundNames["brake_loop3"]       = "subway_trains/bogey/brake_rattle5.wav"
    bogey.SoundNames["brake_loop4"]       = "subway_trains/bogey/brake_rattle6.wav"
    bogey.SoundNames["brake_loopb"]       = "subway_trains/common/junk/junk_background_braking1.wav"
    bogey.SoundNames["brake2_loop1"]       = "subway_trains/bogey/brake_rattle2.wav"
    bogey.SoundNames["brake2_loop2"]       = "subway_trains/bogey/brake_rattle_h.wav"
    bogey.SoundNames["brake_squeal1"]       = "subway_trains/bogey/brake_squeal1.wav"
    bogey.SoundNames["brake_squeal2"]       = "subway_trains/bogey/brake_squeal2.wav"

    -- Remove old sounds
    if bogey.Sounds then
        for k,v in pairs(bogey.Sounds) do
            v:Stop()
        end
    end

    -- Create sounds
    bogey.Sounds = {}
    bogey.Playing = {}
    for k,v in pairs(bogey.SoundNames) do
        --if not file.Exists(v, "MOD") then
--          bogey.SoundNames[k] = nil
        --end
        util.PrecacheSound(v)
        local e = bogey
        if (k == "brake3a") and IsValid(bogey:GetNW2Entity("TrainWheels")) then
            e = bogey:GetNW2Entity("TrainWheels")
        end
        bogey.Sounds[k] = CreateSound(e, Sound(v))
    end

    bogey.Async = nil
    --bogey.MotorSoundType = nil

end
if self:GetNW2Int("MotorType")==3 then		

    -- Bogey-related sounds
    bogey.SoundNames = {}
    bogey.EngineSNDConfig = {}
    
	bogey.MotorSoundType = bogey:GetNWInt("MotorSoundType",1)
    for k,v in pairs(bogey.EngineSNDConfig) do bogey:SetSoundState(v[1],0,0) end	
	table.insert(bogey.EngineSNDConfig,{"ted1_720" ,08,00,16,1*0.4})
	table.insert(bogey.EngineSNDConfig,{"ted2_720" ,16,08-4,24,1*0.43})
	table.insert(bogey.EngineSNDConfig,{"ted3_720" ,24,16-4,32,1*0.46})
	table.insert(bogey.EngineSNDConfig,{"ted4_720" ,32,24-4,40,1*0.49})
	table.insert(bogey.EngineSNDConfig,{"ted5_720" ,40,32-4,48,1*0.52})
	table.insert(bogey.EngineSNDConfig,{"ted6_720" ,48,40-4,56,1*0.55})
	table.insert(bogey.EngineSNDConfig,{"ted7_720" ,56,48-4,64,1*0.58})
	table.insert(bogey.EngineSNDConfig,{"ted8_720" ,64,56-4,72,1*0.61})
	table.insert(bogey.EngineSNDConfig,{"ted9_720" ,72,64-4,80,1*0.64})
	table.insert(bogey.EngineSNDConfig,{"ted10_720",80,72-4,88,1*0.67})
	table.insert(bogey.EngineSNDConfig,{"ted11_720",88,80-4   ,1*0.7})
	
    bogey.SoundNames = {}	

    bogey.SoundNames["ted1_703"]  = "subway_trains/bogey/engines/703/speed_8.wav"
    bogey.SoundNames["ted2_703"]  = "subway_trains/bogey/engines/703/speed_16.wav"
    bogey.SoundNames["ted3_703"]  = "subway_trains/bogey/engines/703/speed_24.wav"
    bogey.SoundNames["ted4_703"]  = "subway_trains/bogey/engines/703/speed_32.wav"
    bogey.SoundNames["ted5_703"]  = "subway_trains/bogey/engines/703/speed_40.wav"
    bogey.SoundNames["ted6_703"]  = "subway_trains/bogey/engines/703/speed_48.wav"
    bogey.SoundNames["ted7_703"]  = "subway_trains/bogey/engines/703/speed_56.wav"
    bogey.SoundNames["ted8_703"]  = "subway_trains/bogey/engines/703/speed_64.wav"
    bogey.SoundNames["ted9_703"]  = "subway_trains/bogey/engines/703/speed_72.wav"
    bogey.SoundNames["ted10_703"] = "subway_trains/bogey/engines/703/speed_80.wav"
    bogey.SoundNames["ted11_703"] = "subway_trains/bogey/engines/703/speed_88.wav"

    bogey.SoundNames["ted1_717"]  = "subway_trains/bogey/engines/717/engines_8.wav"
    bogey.SoundNames["ted2_717"]  = "subway_trains/bogey/engines/717/engines_16.wav"
    bogey.SoundNames["ted3_717"]  = "subway_trains/bogey/engines/717/engines_24.wav"
    bogey.SoundNames["ted4_717"]  = "subway_trains/bogey/engines/717/engines_32.wav"
    bogey.SoundNames["ted5_717"]  = "subway_trains/bogey/engines/717/engines_40.wav"
    bogey.SoundNames["ted6_717"]  = "subway_trains/bogey/engines/717/engines_48.wav"
    bogey.SoundNames["ted7_717"]  = "subway_trains/bogey/engines/717/engines_56.wav"
    bogey.SoundNames["ted8_717"]  = "subway_trains/bogey/engines/717/engines_64.wav"
    bogey.SoundNames["ted9_717"]  = "subway_trains/bogey/engines/717/engines_72.wav"
    bogey.SoundNames["ted10_717"] = "subway_trains/bogey/engines/717/engines_80.wav"

    bogey.SoundNames["ted11_720"] = "subway_trains/bogey/engines/720/speed_88.wav"
    bogey.SoundNames["ted1_720"]  = "subway_trains/bogey/engines/720/speed_8.wav"
    bogey.SoundNames["ted2_720"]  = "subway_trains/bogey/engines/720/speed_16.wav"
    bogey.SoundNames["ted3_720"]  = "subway_trains/bogey/engines/720/speed_24.wav"
    bogey.SoundNames["ted4_720"]  = "subway_trains/bogey/engines/720/speed_32.wav"
    bogey.SoundNames["ted5_720"]  = "subway_trains/bogey/engines/720/speed_40.wav"
    bogey.SoundNames["ted6_720"]  = "subway_trains/bogey/engines/720/speed_48.wav"
    bogey.SoundNames["ted7_720"]  = "subway_trains/bogey/engines/720/speed_56.wav"
    bogey.SoundNames["ted8_720"]  = "subway_trains/bogey/engines/720/speed_64.wav"
    bogey.SoundNames["ted9_720"]  = "subway_trains/bogey/engines/720/speed_72.wav"
    bogey.SoundNames["ted10_720"] = "subway_trains/bogey/engines/720/speed_80.wav"
    --*0.975
    --*1.025
    bogey.SoundNames["flangea"]      = "subway_trains/bogey/skrip1.wav"
    bogey.SoundNames["flangeb"]      = "subway_trains/bogey/skrip2.wav"
    bogey.SoundNames["flange1"]      = "subway_trains/bogey/flange_9.wav"
    bogey.SoundNames["flange2"]      = "subway_trains/bogey/flange_10.wav"
    bogey.SoundNames["brakea_loop1"]       = "subway_trains/bogey/braking_async1.wav"
    bogey.SoundNames["brakea_loop2"]       = "subway_trains/bogey/braking_async2.wav"
    bogey.SoundNames["brake_loop1"]       = "subway_trains/bogey/brake_rattle3.wav"
    bogey.SoundNames["brake_loop2"]       = "subway_trains/bogey/brake_rattle4.wav"
    bogey.SoundNames["brake_loop3"]       = "subway_trains/bogey/brake_rattle5.wav"
    bogey.SoundNames["brake_loop4"]       = "subway_trains/bogey/brake_rattle6.wav"
    bogey.SoundNames["brake_loopb"]       = "subway_trains/common/junk/junk_background_braking1.wav"
    bogey.SoundNames["brake2_loop1"]       = "subway_trains/bogey/brake_rattle2.wav"
    bogey.SoundNames["brake2_loop2"]       = "subway_trains/bogey/brake_rattle_h.wav"
    bogey.SoundNames["brake_squeal1"]       = "subway_trains/bogey/brake_squeal1.wav"
    bogey.SoundNames["brake_squeal2"]       = "subway_trains/bogey/brake_squeal2.wav"
	
    -- Remove old sounds
    if bogey.Sounds then
        for k,v in pairs(bogey.Sounds) do
            v:Stop()
        end
    end

    -- Create sounds
    bogey.Sounds = {}
    bogey.Playing = {}
    for k,v in pairs(bogey.SoundNames) do
        --if not file.Exists(v, "MOD") then
--          bogey.SoundNames[k] = nil
        --end
        util.PrecacheSound(v)
        local e = bogey
        if (k == "brake3a") and IsValid(bogey:GetNW2Entity("TrainWheels")) then
            e = bogey:GetNW2Entity("TrainWheels")
        end
        bogey.Sounds[k] = CreateSound(e, Sound(v))
    end

    bogey.Async = nil
    --bogey.MotorSoundType = nil

end
if self:GetNW2Int("MotorType")==4 then		

    -- Bogey-related sounds
    bogey.SoundNames = {}
    bogey.EngineSNDConfig = {}
    
	bogey.MotorSoundType = bogey:GetNWInt("MotorSoundType",1)
    for k,v in pairs(bogey.EngineSNDConfig) do bogey:SetSoundState(v[1],0,0) end	
	table.insert(bogey.EngineSNDConfig,{"ted1_740" ,08,00,16,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted2_740" ,16,08-4,24,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted3_740" ,24,16-4,32,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted4_740" ,32,24-4,40,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted5_740" ,40,32-4,48,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted6_740" ,48,40-4,56,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted7_740" ,56,48-4,64,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted8_740" ,64,56-4,72,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted9_740" ,72,64-4,80,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted10_740",80,72-4,88,1*1})
	
    bogey.SoundNames = {}	

    bogey.SoundNames["ted1_703"]  = "subway_trains/bogey/engines/703/speed_8.wav"
    bogey.SoundNames["ted2_703"]  = "subway_trains/bogey/engines/703/speed_16.wav"
    bogey.SoundNames["ted3_703"]  = "subway_trains/bogey/engines/703/speed_24.wav"
    bogey.SoundNames["ted4_703"]  = "subway_trains/bogey/engines/703/speed_32.wav"
    bogey.SoundNames["ted5_703"]  = "subway_trains/bogey/engines/703/speed_40.wav"
    bogey.SoundNames["ted6_703"]  = "subway_trains/bogey/engines/703/speed_48.wav"
    bogey.SoundNames["ted7_703"]  = "subway_trains/bogey/engines/703/speed_56.wav"
    bogey.SoundNames["ted8_703"]  = "subway_trains/bogey/engines/703/speed_64.wav"
    bogey.SoundNames["ted9_703"]  = "subway_trains/bogey/engines/703/speed_72.wav"
    bogey.SoundNames["ted10_703"] = "subway_trains/bogey/engines/703/speed_80.wav"
    bogey.SoundNames["ted11_703"] = "subway_trains/bogey/engines/703/speed_88.wav"

    --bogey.SoundNames["ted11_720"] = "subway_trains/760/engines/engine_80.wav"
    bogey.SoundNames["ted1_740"]  = "subway_trains/rusich/engines_new_1/engine_8.wav"
    bogey.SoundNames["ted2_740"]  = "subway_trains/rusich/engines_new_1/engine_16.wav"
    bogey.SoundNames["ted3_740"]  = "subway_trains/rusich/engines_new_1/engine_24.wav"
    bogey.SoundNames["ted4_740"]  = "subway_trains/rusich/engines_new_1/engine_32.wav"
    bogey.SoundNames["ted5_740"]  = "subway_trains/rusich/engines_new_1/engine_40.wav"
    bogey.SoundNames["ted6_740"]  = "subway_trains/rusich/engines_new_1/engine_48.wav"
    bogey.SoundNames["ted7_740"]  = "subway_trains/rusich/engines_new_1/engine_56.wav"
    bogey.SoundNames["ted8_740"]  = "subway_trains/rusich/engines_new_1/engine_64.wav"
    bogey.SoundNames["ted9_740"]  = "subway_trains/rusich/engines_new_1/engine_72.wav"
    bogey.SoundNames["ted10_740"] = "subway_trains/rusich/engines_new_1/engine_80.wav"

    --bogey.SoundNames["ted11_720"] = "subway_trains/760/engines/engine_80.wav"
    bogey.SoundNames["ted11_720"] = "subway_trains/bogey/engines/720/speed_88.wav"
    bogey.SoundNames["ted1_720"]  = "subway_trains/bogey/engines/720/speed_8.wav"
    bogey.SoundNames["ted2_720"]  = "subway_trains/bogey/engines/720/speed_16.wav"
    bogey.SoundNames["ted3_720"]  = "subway_trains/bogey/engines/720/speed_24.wav"
    bogey.SoundNames["ted4_720"]  = "subway_trains/bogey/engines/720/speed_32.wav"
    bogey.SoundNames["ted5_720"]  = "subway_trains/bogey/engines/720/speed_40.wav"
    bogey.SoundNames["ted6_720"]  = "subway_trains/bogey/engines/720/speed_48.wav"
    bogey.SoundNames["ted7_720"]  = "subway_trains/bogey/engines/720/speed_56.wav"
    bogey.SoundNames["ted8_720"]  = "subway_trains/bogey/engines/720/speed_64.wav"
    bogey.SoundNames["ted9_720"]  = "subway_trains/bogey/engines/720/speed_72.wav"
    bogey.SoundNames["ted10_720"] = "subway_trains/bogey/engines/720/speed_80.wav"
    --*0.975
    --*1.025
	local skr = math.random (1,2)
	local skripit = math.random (1,5)	
    bogey.SoundNames["flangea"]      = "subway_trains/rusich/bogey/skrip1_"..skr..".wav"
    bogey.SoundNames["flangeb"]      = "subway_trains/rusich/bogey/skrip2_"..skripit..".wav"
    bogey.SoundNames["flange1"]      = "subway_trains/rusich/bogey/flange_9.wav"
    bogey.SoundNames["flange2"]      = "subway_trains/rusich/bogey/Flange_10.wav"
    bogey.SoundNames["brakea_loop1"]       = "subway_trains/rusich/bogey/braking_async4.wav"
    bogey.SoundNames["brakea_loop2"]       = "subway_trains/rusich/bogey/braking_async4.wav"
    bogey.SoundNames["brake_loop1"]       = "subway_trains/bogey/brake_rattle3.wav"
    bogey.SoundNames["brake_loop2"]       = "subway_trains/bogey/brake_rattle4.wav"
    bogey.SoundNames["brake_loop3"]       = "subway_trains/bogey/brake_rattle5.wav"
    bogey.SoundNames["brake_loop4"]       = "subway_trains/bogey/brake_rattle6.wav"
    bogey.SoundNames["brake_loopb"]       = "subway_trains/common/junk/junk_background_braking1.wav"
    bogey.SoundNames["brake2_loop1"]       = "subway_trains/bogey/brake_rattle2.wav"
    bogey.SoundNames["brake2_loop2"]       = "subway_trains/bogey/brake_rattle_h.wav"
    bogey.SoundNames["brake_squeal1"]       = "subway_trains/bogey/brake_squeal1.wav"
    bogey.SoundNames["brake_squeal2"]       = "subway_trains/bogey/brake_squeal2.wav"
	
    -- Remove old sounds
    if bogey.Sounds then
        for k,v in pairs(bogey.Sounds) do
            v:Stop()
        end
    end

    -- Create sounds
    bogey.Sounds = {}
    bogey.Playing = {}
    for k,v in pairs(bogey.SoundNames) do
        --if not file.Exists(v, "MOD") then
--          bogey.SoundNames[k] = nil
        --end
        util.PrecacheSound(v)
        local e = bogey
        if (k == "brake3a") and IsValid(bogey:GetNW2Entity("TrainWheels")) then
            e = bogey:GetNW2Entity("TrainWheels")
        end
        bogey.Sounds[k] = CreateSound(e, Sound(v))
    end

    bogey.Async = nil
    --bogey.MotorSoundType = nil

end
if self:GetNW2Int("MotorType")==5 then		

    -- Bogey-related sounds
    bogey.SoundNames = {}
    bogey.EngineSNDConfig = {}
    
	bogey.MotorSoundType = bogey:GetNWInt("MotorSoundType",1)
    for k,v in pairs(bogey.EngineSNDConfig) do bogey:SetSoundState(v[1],0,0) end	
	table.insert(bogey.EngineSNDConfig,{"ted1_740" ,08,00,16,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted2_740" ,16,08-4,24,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted3_740" ,24,16-4,32,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted4_740" ,32,24-4,40,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted5_740" ,40,32-4,48,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted6_740" ,48,40-4,56,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted7_740" ,56,48-4,64,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted8_740" ,64,56-4,72,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted9_740" ,72,64-4,80,1*1})
	table.insert(bogey.EngineSNDConfig,{"ted10_740",80,72-4,88,1*1})
	
    bogey.SoundNames = {}	

    bogey.SoundNames["ted1_703"]  = "subway_trains/bogey/engines/703/speed_8.wav"
    bogey.SoundNames["ted2_703"]  = "subway_trains/bogey/engines/703/speed_16.wav"
    bogey.SoundNames["ted3_703"]  = "subway_trains/bogey/engines/703/speed_24.wav"
    bogey.SoundNames["ted4_703"]  = "subway_trains/bogey/engines/703/speed_32.wav"
    bogey.SoundNames["ted5_703"]  = "subway_trains/bogey/engines/703/speed_40.wav"
    bogey.SoundNames["ted6_703"]  = "subway_trains/bogey/engines/703/speed_48.wav"
    bogey.SoundNames["ted7_703"]  = "subway_trains/bogey/engines/703/speed_56.wav"
    bogey.SoundNames["ted8_703"]  = "subway_trains/bogey/engines/703/speed_64.wav"
    bogey.SoundNames["ted9_703"]  = "subway_trains/bogey/engines/703/speed_72.wav"
    bogey.SoundNames["ted10_703"] = "subway_trains/bogey/engines/703/speed_80.wav"
    bogey.SoundNames["ted11_703"] = "subway_trains/bogey/engines/703/speed_88.wav"

    --bogey.SoundNames["ted11_720"] = "subway_trains/760/engines/engine_80.wav"
	local eng = math.random (1,2)	
    bogey.SoundNames["ted1_740"]  = "subway_trains/rusich/engines_1/engine_8.wav"
    bogey.SoundNames["ted2_740"]  = "subway_trains/rusich/engines_1/engine_16_"..eng..".wav"
    bogey.SoundNames["ted3_740"]  = "subway_trains/rusich/engines_1/engine_24_"..eng..".wav"
    bogey.SoundNames["ted4_740"]  = "subway_trains/rusich/engines_1/engine_32.wav"
    bogey.SoundNames["ted5_740"]  = "subway_trains/rusich/engines_1/engine_40.wav"
    bogey.SoundNames["ted6_740"]  = "subway_trains/rusich/engines_1/engine_48.wav"
    bogey.SoundNames["ted7_740"]  = "subway_trains/rusich/engines_1/engine_56.wav"
    bogey.SoundNames["ted8_740"]  = "subway_trains/rusich/engines_1/engine_64.wav"
    bogey.SoundNames["ted9_740"]  = "subway_trains/rusich/engines_1/engine_72.wav"
    bogey.SoundNames["ted10_740"] = "subway_trains/rusich/engines_1/engine_80.wav"

    --bogey.SoundNames["ted11_720"] = "subway_trains/760/engines/engine_80.wav"
    bogey.SoundNames["ted11_720"] = "subway_trains/bogey/engines/720/speed_88.wav"
    bogey.SoundNames["ted1_720"]  = "subway_trains/bogey/engines/720/speed_8.wav"
    bogey.SoundNames["ted2_720"]  = "subway_trains/bogey/engines/720/speed_16.wav"
    bogey.SoundNames["ted3_720"]  = "subway_trains/bogey/engines/720/speed_24.wav"
    bogey.SoundNames["ted4_720"]  = "subway_trains/bogey/engines/720/speed_32.wav"
    bogey.SoundNames["ted5_720"]  = "subway_trains/bogey/engines/720/speed_40.wav"
    bogey.SoundNames["ted6_720"]  = "subway_trains/bogey/engines/720/speed_48.wav"
    bogey.SoundNames["ted7_720"]  = "subway_trains/bogey/engines/720/speed_56.wav"
    bogey.SoundNames["ted8_720"]  = "subway_trains/bogey/engines/720/speed_64.wav"
    bogey.SoundNames["ted9_720"]  = "subway_trains/bogey/engines/720/speed_72.wav"
    bogey.SoundNames["ted10_720"] = "subway_trains/bogey/engines/720/speed_80.wav"
    --*0.975
    --*1.025
	local skr = math.random (1,2)
	local skripit = math.random (1,5)	
    bogey.SoundNames["flangea"]      = "subway_trains/rusich/bogey/skrip1_"..skr..".wav"
    bogey.SoundNames["flangeb"]      = "subway_trains/rusich/bogey/skrip2_"..skripit..".wav"
    bogey.SoundNames["flange1"]      = "subway_trains/rusich/bogey/flange_9.wav"
    bogey.SoundNames["flange2"]      = "subway_trains/rusich/bogey/Flange_10.wav"
    bogey.SoundNames["brakea_loop1"]       = "subway_trains/rusich/bogey/braking_async4.wav"
    bogey.SoundNames["brakea_loop2"]       = "subway_trains/rusich/bogey/braking_async4.wav"
    bogey.SoundNames["brake_loop1"]       = "subway_trains/bogey/brake_rattle3.wav"
    bogey.SoundNames["brake_loop2"]       = "subway_trains/bogey/brake_rattle4.wav"
    bogey.SoundNames["brake_loop3"]       = "subway_trains/bogey/brake_rattle5.wav"
    bogey.SoundNames["brake_loop4"]       = "subway_trains/bogey/brake_rattle6.wav"
    bogey.SoundNames["brake_loopb"]       = "subway_trains/common/junk/junk_background_braking1.wav"
    bogey.SoundNames["brake2_loop1"]       = "subway_trains/bogey/brake_rattle2.wav"
    bogey.SoundNames["brake2_loop2"]       = "subway_trains/bogey/brake_rattle_h.wav"
    bogey.SoundNames["brake_squeal1"]       = "subway_trains/bogey/brake_squeal1.wav"
    bogey.SoundNames["brake_squeal2"]       = "subway_trains/bogey/brake_squeal2.wav"
	
    -- Remove old sounds
    if bogey.Sounds then
        for k,v in pairs(bogey.Sounds) do
            v:Stop()
        end
    end

    -- Create sounds
    bogey.Sounds = {}
    bogey.Playing = {}
    for k,v in pairs(bogey.SoundNames) do
        --if not file.Exists(v, "MOD") then
--          bogey.SoundNames[k] = nil
        --end
        util.PrecacheSound(v)
        local e = bogey
        if (k == "brake3a") and IsValid(bogey:GetNW2Entity("TrainWheels")) then
            e = bogey:GetNW2Entity("TrainWheels")
        end
        bogey.Sounds[k] = CreateSound(e, Sound(v))
    end

    bogey.Async = nil
    --bogey.MotorSoundType = nil

end
end
end

function ENT:Think()
    self.BaseClass.Think(self)
	
if Metrostroi.Version >= 1537278077 then	
	local refresh = false--true		
	if self:GetNW2Int("MotorType")==1 then		
		if IsValid(self.FrontBogey) and self.FrontBogey.SoundNames and (self.FrontBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines/engine_8.wav" 
	or self.FrontBogey.EngineSNDConfig and self.FrontBogey.EngineSNDConfig[1] and self.FrontBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.FrontBogey)
	end
	if IsValid(self.RearBogey) and self.RearBogey.SoundNames and (self.RearBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines/engine_8.wav" 
	or self.RearBogey.EngineSNDConfig and self.RearBogey.EngineSNDConfig[1] and self.RearBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.RearBogey)
	end		
	end
	if self:GetNW2Int("MotorType")==2 then		
		if IsValid(self.FrontBogey) and self.FrontBogey.SoundNames and (self.FrontBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines_new/engine_8.wav" 
	or self.FrontBogey.EngineSNDConfig and self.FrontBogey.EngineSNDConfig[1] and self.FrontBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.FrontBogey)
	end
	if IsValid(self.RearBogey) and self.RearBogey.SoundNames and (self.RearBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines_new/engine_8.wav" 
	or self.RearBogey.EngineSNDConfig and self.RearBogey.EngineSNDConfig[1] and self.RearBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.RearBogey)
	end	
	end
	if self:GetNW2Int("MotorType")==3 then		
		if IsValid(self.FrontBogey) and self.FrontBogey.SoundNames and (self.FrontBogey.SoundNames["ted1_720"] ~= "subway_trains/bogey/engines/720/speed_8.wav"  
	or self.FrontBogey.EngineSNDConfig and self.FrontBogey.EngineSNDConfig[1] and self.FrontBogey.EngineSNDConfig[1][5] ~= 0.4) or refresh then
		self:ReInitBogeySounds(self.FrontBogey)
	end
	if IsValid(self.RearBogey) and self.RearBogey.SoundNames and (self.RearBogey.SoundNames["ted1_720"] ~= "subway_trains/bogey/engines/720/speed_8.wav" 
	or self.RearBogey.EngineSNDConfig and self.RearBogey.EngineSNDConfig[1] and self.RearBogey.EngineSNDConfig[1][5] ~= 0.4) or refresh then
		self:ReInitBogeySounds(self.RearBogey)
	end		
	end
	if self:GetNW2Int("MotorType")==4 then		
	if IsValid(self.FrontBogey) and self.FrontBogey.SoundNames and (self.FrontBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines_new_1/engine_8.wav" 
	or self.FrontBogey.EngineSNDConfig and self.FrontBogey.EngineSNDConfig[1] and self.FrontBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.FrontBogey)
	end
	if IsValid(self.RearBogey) and self.RearBogey.SoundNames and (self.RearBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines_new_1/engine_8.wav" 
	or self.RearBogey.EngineSNDConfig and self.RearBogey.EngineSNDConfig[1] and self.RearBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.RearBogey)
	end	
	end
	if self:GetNW2Int("MotorType")==5 then		
	if IsValid(self.FrontBogey) and self.FrontBogey.SoundNames and (self.FrontBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines_1/engine_8.wav" 
	or self.FrontBogey.EngineSNDConfig and self.FrontBogey.EngineSNDConfig[1] and self.FrontBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.FrontBogey)
	end
	if IsValid(self.RearBogey) and self.RearBogey.SoundNames and (self.RearBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines_1/engine_8.wav" 
	or self.RearBogey.EngineSNDConfig and self.RearBogey.EngineSNDConfig[1] and self.RearBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.RearBogey)
	end	
	end	
end	

--Генерация пропов для задней секции.
local Pricep740 = self:GetNW2Entity("gmod_pricep_kuzov")
if IsValid(Pricep740) then
if not Pricep740.ButtonMap then
Pricep740.ButtonMap = {}
Pricep740.ClientProps = {}
Pricep740.ClientSounds = {}
Pricep740.AutoAnims = {}

Pricep740.ClientProps["Zavod_table_sochl"] = { 
    model = "models/metrostroi_train/81-741/salon/zavod.mdl",
	pos = Vector(286.9,44,48),
    ang = Angle(90,180,0),
	scale = 3,	
	hide = 1,	
}
Pricep740.ClientProps["Zavod_table_sochl_torec"] = {  --Торец табличка зад
    model = "models/metrostroi_train/81-741/salon/zavod.mdl",
	pos = Vector(-331.95,-15,59),
    ang = Angle(90,0,0),
	scale = 3,	
	hide = 1,	
}
Pricep740.ClientProps["Naddver_off_740"] = { 
    model = "models/metrostroi_train/81-741/salon/naddverka_off_741.mdl",
	pos = Vector(-15.2,37.15,57.6),
    ang = Angle(0,180,0),
	scale = 1,
	hide = 2, 	
}
--Новые модели 2023.

Pricep740.ClientProps["RearTrain"] = {
	model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
	pos = Vector(-336, -25, -54),
	ang = Angle(0,90,0),
	hide = 1,			
}
Pricep740.ClientProps["RearBrake"] = {
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
	pos = Vector(-336, 25, -54),
	ang = Angle(0,90,0),
	hide = 1,		
}
Pricep740.ClientSounds["RearBrakeLineIsolation"] = {{"RearBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}--660, 23, -56
Pricep740.ClientSounds["RearTrainLineIsolation"] = {{"RearTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}

Pricep740.ClientProps["krepezh1"] = {
    model = "models/metrostroi_train/81-740/body/krepezh.mdl",
    pos = Vector(64, 0, -75),
    ang = Angle(0,180,0), 
	hide = false,		
}
Pricep740.ClientProps["handrails_offside"] = {
    model = "models/metrostroi_train/81-740/body/740_body_additional.mdl",
    pos = Vector(21.8, 10, -76.5),
    ang = Angle(0,180,0),
	hide = false,	
}
--правый ряд
for i = 1,11 do
Pricep740.ClientProps["lamps_salon_on_test"..i-1] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(345-54.23*i,0.55,-74.75),
    ang = Angle(0,180,0),
    color = Color(245,238,223),	
	hide = 1,	 
}
Pricep740.ClientProps["lamps_salon_on_test1"..i] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(345-54.23*i,-57.55,-74.75),
    ang = Angle(0,180,0),
    color = Color(245,238,223),	
	hide = 1,	
}

Pricep740.ClientProps["lamps_salon_on_avar1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(234,-57.5,-74.75),
    ang = Angle(0,180,0),
	hide = 2,	
}
Pricep740.ClientProps["lamps_salon_on_avar2"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(-255,0.58,-74.75),
    ang = Angle(0,180,0),
	hide = 2,	
}
Pricep740.ClientProps["lamps_salon_off1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_off_rear.mdl", 
    pos = Vector(195,0,-75),
    ang = Angle(0,180,0),
	hide = 2,		
}

Pricep740.ClientProps["handrails1"] = {
	model = "models/metrostroi_train/81-741/salon/handrails/handrails.mdl",
	pos = Vector(0, 0.5, -2),
	ang = Angle(0,0,0),
	hide = 2,		
}
Pricep740.ClientProps["salon1"] = {
	model = "models/metrostroi_train/81-741/salon/salon_rear.mdl",
	pos = Vector(-9.85, 0, 6),
	ang = Angle(0,180,0),
	hide = 2,    		
}
Pricep740.ClientProps["door_cab_b"] = {
	model = "models/metrostroi_train/81-740/salon/door_br.mdl",
	pos = Vector(-334.5, 15, 8.8),
	ang = Angle(0,180,0),
	scale = 1,
	hide = 2,
}
for m=0,3 do	
Pricep740.ClientProps["TrainNumberL"..m] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
		pos = Vector(-310+m*6.6-4*6.6/2, 63.4, 18),
        ang = Angle(0,180,-3.29),
		hide = 1,
		callback = function(Pricep740)
            self.WagonNumber = false	
		end,	
	}
end	
function self:UpdateWagonNumber()	
for m=0,3 do
        --if i< count then
			if self.WagonNumber then	
            local leftNum = Pricep740.ClientEnts["TrainNumberL"..m]
            local rightNum = self.ClientEnts["TrainNumberR"..m]
	        local num = math.floor(self.WagonNumber%(10^(m+1))/10^m)				
	        if IsValid(rightNum) then
                rightNum:SetPos(self:LocalToWorld(Vector(635-m*6.6+4*6.6/2, -63.5 ,18)))
                rightNum:SetSkin(num)
            end		
	        local num = math.floor(self.WagonNumber%(10^(m+1))/10^m)				
            if IsValid(leftNum) then		
                leftNum:SetLocalPos(Vector(-310+m*6.6-4*6.6/2, 63.4, 18))
                leftNum:SetSkin(num)
				end
            end				
		end
	end

local function GetDoorPositionRear(b,k,j)
	if j == 0 			--	x						--	y        --	z
	then return Vector(195.5 - -35.0*k - 232.1*b, -66*(1-2*k), 4.3)
	else return Vector(265.6 - 35.0*(1+k) - 232.1*b,-67.5*(1-2*k),4.3)
	end
end

for b=0,2 do
	for k=0,1 do
		Pricep740.ClientProps["door"..b.."x1"..k.."a1"] = {
			model = "models/metrostroi_train/81-740/body/81-740_leftdoor1.mdl",
			pos = GetDoorPositionRear(b,k,0),
			ang = Angle(0,90 +180*k,0),        
			scale = 1.001,					
			hide = 2,	
}
		Pricep740.ClientProps["door"..b.."x1"..k.."b1"] = {
			model = "models/metrostroi_train/81-740/body/81-740_leftdoor2.mdl",
			pos = GetDoorPositionRear(b,k,1),
			ang = Angle(0,90 +180*k,0),   
			scale = 1.001,					 
			hide = 2,   
}
Pricep740.ButtonMap["RearDoor"] = {
    pos = Vector(-332,-15,55), ---334.8,14.5,9
    ang = Angle(0,90,90),
    width = 642,
    height = 2000,
    scale = 0.1/2, 	
    buttons = {
        {ID = "RearDoor",x=0,y=0,w=642,h=2000, tooltip=Metrostroi.GetPhrase("Common.741.RearDoor"), model = {
            var="RearDoor",sndid="door_cab_t",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},   
	}	
}
Pricep740.ButtonMap["Tickers_rear"] = {
		pos = Vector(286.9,27,66.3), --446 -- 14 -- -0,5
		ang = Angle(0,-90,90),
		width = 1024,
		height = 59,
		scale = 0.054,
		hide=true,
		hideseat=1,		
}
Pricep740.ButtonMap["RearPneumatic"] = {
    pos = Vector(-206-131,45,-46),
    ang = Angle(180,90,270),
    width = 900,
    height = 100,
    scale = 0.1,
    hideseat=0.2,
    hide=true,
	screenHide = true,
	
    buttons = {
		{ID = "RearTrainLineIsolationToggle",x=500, y=0, w=400, h=100, tooltip=Metrostroi.GetPhrase ("Common.740.RearTrainLineIsolationToggle")},
		{ID = "RearBrakeLineIsolationToggle",x=0, y=0, w=400, h=100, tooltip=Metrostroi.GetPhrase ("Common.740.RearBrakeLineIsolationToggle")},
    }
}	
end 
end
end
end
end

function self:OnRemove(nfinal)
    if not nfinal then
        self.RenderBlock = RealTime()
    else
        drawCrosshair = false
        canDrawCrosshair = false
        toolTipText = nil
    end
    self:RemoveCSEnts()
    self.RenderClientEnts = false


    for _,v in pairs(self.Sounds) do
        if type(v) ~= "function" and IsValid(v) then
            v:Stop()
        end
    end
    for k,v in pairs(self.Sounds.loop) do
        for i,sndt in ipairs(v) do
            if IsValid(sndt.sound) then
                sndt.sound:Stop()
            end
        end
    end
    for _,v in pairs(self.PassengerEntsRear or {}) do
        SafeRemoveEntity(v)
    end
    for _,v in pairs(self.PassengerEnts or {}) do
        SafeRemoveEntity(v)
    end	
    if self.GUILocker then self:BlockInput(false) end
	if Metrostroi.Version >= 1537278077 then 
    self.Sounds = {loop = {}, isloop = {}}	
	else
    self.Sounds = {loop = {}}
	end
    self.PassengerEnts = {}
	self.PassengerEntsRear = {}
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

   if not self.RenderClientEnts or self.CreatingCSEnts then return end	
	
if not IsValid(Pricep740) then return end	

--Передняя часть	

if self.RenderClientEnts ~= self:ShouldRenderClientEnts() then
        self.RenderClientEnts = self:ShouldRenderClientEnts()
        if self.RenderClientEnts then
            self:BlockInput(self.HandleMouseInput)
        else		
            self:OnRemove(true)
            for k,v in pairs(self.PassengerEnts or {}) do
                SafeRemoveEntity(v)
            end	
--Передняя часть				
--Задняя часть				
            self:OnRemove(true)
            for k,v in pairs(self.PassengerEntsRear or {}) do
                SafeRemoveEntity(v)
            end			
--Задняя часть				
            self.PassengerEntsRear = {}		
--Задняя часть
--Передняя часть
            self.PassengerEnts = {}			
--Передняя часть			
            return
        end
    end		

	if not self:GetNW2Bool("metrostroi_custom_passengers") then 
    if self.PassengerEntsRear then
        if #self.PassengerEntsRear ~= self:GetNW2Float("PassengerCount") then

            -- Passengers go out
            while #self.PassengerEntsRear > self:GetNW2Float("PassengerCount") do
                local ent = self.PassengerEntsRear[#self.PassengerEntsRear]
                table.remove(self.PassengerPositions,#self.PassengerPositions)
                table.remove(self.PassengerEntsRear,#self.PassengerEntsRear)
                ent:Remove()
            end
            -- Passengers go in
            while #self.PassengerEntsRear < self:GetNW2Float("PassengerCount") do
                local min,max = self:GetStandingAreaRear()
                local pos = min + Vector((max.x-min.x)*math.random(),(max.y-min.y)*math.random(),(max.z-min.z)*math.random())
                local ent = ClientsideModel(table.Random(self.PassengerModelsRear),RENDERGROUP_OPAQUE)			
                ent:SetLocalPos(Pricep740:LocalToWorld(pos))--ent:SetLocalPos(self:LocalToWorld(pos)) 
                ent:SetAngles(Angle(0,math.random(0,360),0))
                ent:SetSkin(math.floor(ent:SkinCount()*math.random()))
                ent:SetModelScale(0.98 + (-0.02+0.04*math.random()),0)
                ent:SetParent(Pricep740)				
                table.insert(self.PassengerPositions,pos)
                table.insert(self.PassengerEntsRear,ent)
            end
        end
	    elseif (self.PassengerEntsRear ~= self.PrevPass) then
		self.PrevPass = self.self.PassengerEntsRear	
        for k,v in pairs(self.PassengerEntsRear) do
            if IsValid(v) then v:Remove() end
            self.PassengerEntsRear[k] = nil
			end
	else
if self:GetNW2Bool("metrostroi_custom_passengers") then 		
		local function SetNewModel(ent)
		if IsValid(ent) and not ent.ChangedModel then
			ent.ChangedModel = true
			local model = tableRandom(PassengerModelRearCustom)
			ent:SetAngles(ent:GetAngles()+Angle(0,180,0))
			ent:SetModel(model)
			--v:SetSkin(mathrandom(1,v:SkinCount()))
			ent:ResetSequence(tableRandom(model:find("female",1,true) and female_sequences or male_sequences))					
				local function SetNewModel(ent)
				if IsValid(ent) and ent.ChangedModel then
				ent.ChangedModel = true					
				end 
				end
				for k,v in pairs(self.PassengerEntsRear)do SetNewModel(v)
				end
				end	
		end
	end	
end		
--[[else
	

	if self:GetNW2Bool("metrostroi_custom_passengers") then 		
    if self.PassengerEntsRearCustom then
        if #self.PassengerEntsRearCustom ~= self:GetNW2Float("PassengerCount") then

            -- Passengers go out
            while #self.PassengerEntsRearCustom > self:GetNW2Float("PassengerCount") do
                local ent = self.PassengerEntsRearCustom[#self.PassengerEntsRearCustom]
                table.remove(self.PassengerPositionsCustom,#self.PassengerPositionsCustom)
                table.remove(self.PassengerEntsRearCustom,#self.PassengerEntsRearCustom)
                ent:Remove()
            end
            -- Passengers go in
            while #self.PassengerEntsRearCustom < self:GetNW2Float("PassengerCount") do
                local min,max = self:GetStandingAreaRear()
                local pos = min + Vector((max.x-min.x)*math.random(),(max.y-min.y)*math.random(),(max.z-min.z)*math.random())
                ent:SetLocalPos(gmod_pricep_kuzov:LocalToWorld(pos))--ent:SetLocalPos(self:LocalToWorld(pos)) 
				ent:ResetSequence(table.Random(model:find("female",1,true) and female_sequences or male_sequences))				
                ent:SetAngles(gmod_pricep_kuzov:GetAngles()+Angle(0,180,0))
                ent:SetParent(gmod_pricep_kuzov)				
                table.insert(self.PassengerPositionsCustom,pos)
                table.insert(self.PassengerEntsRearCustom,ent)
				end
            end
        end
    end]]
end	
----------------------------------------------------------------------------------------------------Задняя часть
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
	
    self.FrontLeak = math.Clamp(self.FrontLeak + 10*(-self:GetPackedRatio("FrontLeak")-self.FrontLeak)*dT,0,1)
    self.RearLeak = math.Clamp(self.RearLeak + 10*(-self:GetPackedRatio("RearLeak")-self.RearLeak)*dT,0,1)
    self:SetSoundState("front_isolation",self.FrontLeak,0.9+0.2*self.FrontLeak)
    self:SetSoundState("rear_isolation",self.RearLeak,0.9+0.2*self.RearLeak)	

    local dPdT = self:GetPackedRatio("BrakeCylinderPressure_dPdT")
    self.ReleasedPdT = math.Clamp(self.ReleasedPdT + 4*(-self:GetPackedRatio("BrakeCylinderPressure_dPdT",0)-self.ReleasedPdT)*dT,0,1)
    --print(dPdT)
    self:SetSoundState("release",math.Clamp(self.ReleasedPdT,0,1)^1.65,1.0)

for avar = 1,2 do	
    -----------------------Задняя часть	
    local colV = self:GetNW2Vector("Lamp7404"..avar)
    local col = Color(colV.x,colV.y,colV.z)		
    Pricep740:ShowHideSmooth("lamps_salon_on_avar"..avar,self:Animate("LampsEmer",self:GetPackedRatio("SalonLighting") == 0.4 and 1 or 0,0,1,5,false),col)
    -----------------------Задняя часть
    -----------------------Передняя часть	
    self:ShowHideSmooth("lamps_salon_on_avar_front"..avar,self:Animate("LampsEmer",self:GetPackedRatio("SalonLighting") == 0.4 and 1 or 0,0,1,5,false),col)	
    -----------------------Передняя часть		
end	

for i = 0,11 do	
    -----------------------Передняя часть
    local colV = self:GetNW2Vector("Lamp7404"..i)
    local col = Color(colV.x,colV.y,colV.z)	
	self:ShowHideSmooth("lamps_salon_on_front"..i,self:Animate("LampsFull",self:GetPackedRatio("SalonLighting") == 1 and 1 or 0,0,1,5,false),col)
	self:ShowHideSmooth("lamps_salon_on_front_left"..i,self:Animate("LampsFull",self:GetPackedRatio("SalonLighting") == 1 and 1 or 0,0,1,5,false),col)
	-----------------------Передняя часть
end
for i = 1,11 do		
    local colV = self:GetNW2Vector("Lamp7404"..i)
    local col = Color(colV.x,colV.y,colV.z)	
    -----------------------Задняя часть	
    Pricep740:ShowHideSmooth("lamps_salon_on_test"..i-1,self:Animate("LampsFull",self:GetPackedRatio("SalonLighting") == 1 and 1 or 0,0,1,5,false),col)
    Pricep740:ShowHideSmooth("lamps_salon_on_test1"..i,self:Animate("LampsFull",self:GetPackedRatio("SalonLighting") == 1 and 1 or 0,0,1,5,false),col)
    -----------------------Задняя часть		
end	

	local net = LocalPlayer():GetName()

	Pricep740:ShowHide("Naddver_off_740",not net:find("VVKonnov") and not net:find("Takkar") and not net:find("George_pot") and not net:find("charliefry") and not net:find("poezdov") and not net:find("JackSever") and not net:find("jack.sever1")
	and not net:find("Dl3ves15"))
	self:ShowHide("Naddver_off_left",not net:find("VVKonnov") and not net:find("Takkar") and not net:find("George_pot") and not net:find("charliefry") and not net:find("poezdov") and not net:find("JackSever") and not net:find("jack.sever1")and 
	not net:find("Dl3ves15"))
	self:ShowHide("Naddver_off_right",not net:find("VVKonnov") and not net:find("Takkar") and not net:find("George_pot") and not net:find("charliefry") and not net:find("poezdov") and not net:find("JackSever") and not net:find("jack.sever1")and 
	not net:find("Dl3ves15"))
	
	if self:GetNW2Bool("DoorTorec") then
	 Pricep740:HidePanel("RearDoor",1) 
	else
	 Pricep740:HidePanel("RearDoor",false)
	end 	

    self:Animate("FrontBrake", self:GetNW2Bool("FbI") and 0 or 1,0,1, 3, false)
    self:Animate("FrontTrain",  self:GetNW2Bool("FtI") and 1 or 0,0,1, 3, false)
    Pricep740:Animate("RearBrake",   self:GetNW2Bool("RbI") and 0 or 1,0,1, 3, false)
    Pricep740:Animate("RearTrain",   self:GetNW2Bool("RtI") and 1 or 0,0,1, 3, false)
	
    local PVZ_otsek = self:GetNW2Bool("PVZ_otsek")
    self:HidePanel("PVZ_otsek_close",not PVZ_otsek)
    self:HidePanel("PVZ_otsek_open", PVZ_otsek)	
    self:HidePanel("PVZ",not PVZ_otsek)		
	
    self:ShowHide("otsek",not PVZ_otsek)	
    self:ShowHide("otsek_open",PVZ_otsek)	

	local ZavodTable = self:GetNW2Int("ZavodTable",1)	
    self:ShowHide("Zavod_table_front",ZavodTable==1)	
    Pricep740:ShowHide("Zavod_table_sochl",ZavodTable==2)
    Pricep740:ShowHide("Zavod_table_sochl_torec",ZavodTable==3)		
	
	-- наддверки и попытка в рандомизацию поломанных сегментов. ОЧЕНЬ СИЛЬНО ЛАГАЕТ
    --[[local scurr = self:GetNW2Int("PassSchemesLED")
    local snext = self:GetNW2Int("PassSchemesLEDN")
    local led_back = self:GetPackedBool("PassSchemesLEDO",false)
    local ledwork = scurr~=0 or snext~=0
	
	for i=1,29 do	
        self:ShowHide("led_l_f2_rear"..i,not led_back and ledwork)
		self:ShowHide("led_l_f4_new"..i,not led_back and ledwork)

		self:ShowHide("led_l_f2_rear_ob"..i,led_back and ledwork)		
		self:ShowHide("led_l_f4_new_ob"..i,led_back and ledwork)			
	end
	for i=1,31 do
	    self:ShowHide("led_l_r1_rear"..i,not led_back and ledwork)
	    self:ShowHide("led_l_f1_new"..i,not led_back and ledwork)

	    self:ShowHide("led_l_f1_new_ob"..i,led_back and ledwork)
	    self:ShowHide("led_l_r1_rear_ob"..i,led_back and ledwork)				
	end	
    for i=1,32 do
	    self:ShowHide("led_l_f_new"..i,not led_back and ledwork)	
	    self:ShowHide("led_l_f3_new"..i,not led_back and ledwork)
	    self:ShowHide("led_l_f5_new"..i,not led_back and ledwork)

	    self:ShowHide("led_l_f_new_ob"..i,led_back and ledwork)	
	    self:ShowHide("led_l_f3_new_ob"..i,led_back and ledwork)
	    self:ShowHide("led_l_f5_new_ob"..i,led_back and ledwork)
        self:ShowHide("led_l_f1_rear_ob"..i,led_back and ledwork)
        self:ShowHide("led_l_r2_rear_ob"..i,led_back and ledwork)		
        self:ShowHide("led_l_f3_rear_ob"..i,led_back and ledwork)	
        self:ShowHide("led_l_r4_rear_ob"..i,led_back and ledwork)		
		
        self:ShowHide("led_l_f1_rear"..i,not led_back and ledwork)	
	    self:ShowHide("led_l_r2_rear"..i,not led_back and ledwork)		
	    self:ShowHide("led_l_f3_rear"..i,not led_back and ledwork)		
	    self:ShowHide("led_l_r4_rear"..i,not led_back and ledwork)	
	    self:ShowHide("led_l_f2_new"..i,not led_back and ledwork)

	    self:ShowHide("led_l_f2_new_ob"..i,led_back and ledwork)		
	end	
	
    local led = scurr
    if snext ~= 0 and CurTime()%.9 > .30 then led = led + snext end
    if scurr < 0 then led = math.floor(CurTime()%9*6.2) end
    if led_back then
        if ledwork then
		
			for i=1,29 do
                if IsValid(self.ClientEnts["led_l_f4_new_ob"..i]) then self.ClientEnts["led_l_f4_new_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1)) end	
                if IsValid(self.ClientEnts["led_l_f2_rear_ob"..i]) then self.ClientEnts["led_l_f2_rear_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1)) end					
				end  		
		
            for i=1,31 do
                if IsValid(self.ClientEnts["led_l_f1_new_ob"..i]) then self.ClientEnts["led_l_f1_new_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1))
				if IsValid(self.ClientEnts["led_l_r1_rear_ob"..i]) then self.ClientEnts["led_l_r1_rear_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1)) end				
				end	
			end	
			
            for i=1,32 do
            if IsValid(self.ClientEnts["led_l_f_new_ob"..i]) then self.ClientEnts["led_l_f_new_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1))	
            if IsValid(self.ClientEnts["led_l_f2_new_ob"..i]) then self.ClientEnts["led_l_f2_new_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1))
            if IsValid(self.ClientEnts["led_l_f3_new_ob"..i]) then self.ClientEnts["led_l_f3_new_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1))
            if IsValid(self.ClientEnts["led_l_f5_new_ob"..i]) then self.ClientEnts["led_l_f5_new_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1))	
			
			if IsValid(self.ClientEnts["led_l_f1_rear_ob"..i]) then self.ClientEnts["led_l_f1_rear_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1)) end
			if IsValid(self.ClientEnts["led_l_r2_rear_ob"..i]) then self.ClientEnts["led_l_r2_rear_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1)) end
			if IsValid(self.ClientEnts["led_l_f3_rear_ob"..i]) then self.ClientEnts["led_l_f3_rear_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1)) end	
			if IsValid(self.ClientEnts["led_l_r4_rear_ob"..i]) then self.ClientEnts["led_l_r4_rear_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1)) end							
				end				
				end	
				end				
				end
				end			
		
        end
    else
        if ledwork then
            for i=1,31 do
                if IsValid(self.ClientEnts["led_l_r1_rear"..i]) then self.ClientEnts["led_l_r1_rear"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1)) end
                if IsValid(self.ClientEnts["led_l_f1_new"..i]) then self.ClientEnts["led_l_f1_new"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1)) end				
				
            for i=1,32 do
                if IsValid(self.ClientEnts["led_l_f1_rear"..i]) then self.ClientEnts["led_l_f1_rear"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1))	
                if IsValid(self.ClientEnts["led_l_r2_rear"..i]) then self.ClientEnts["led_l_r2_rear"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1))				
                if IsValid(self.ClientEnts["led_l_f3_rear"..i]) then self.ClientEnts["led_l_f3_rear"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1))	
                if IsValid(self.ClientEnts["led_l_r4_rear"..i]) then self.ClientEnts["led_l_r4_rear"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1))	
				
                if IsValid(self.ClientEnts["led_l_f_new"..i]) then self.ClientEnts["led_l_f_new"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1))	
                if IsValid(self.ClientEnts["led_l_f2_new"..i]) then self.ClientEnts["led_l_f2_new"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1))
                if IsValid(self.ClientEnts["led_l_f3_new"..i]) then self.ClientEnts["led_l_f3_new"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1))
                if IsValid(self.ClientEnts["led_l_f5_new"..i]) then self.ClientEnts["led_l_f5_new"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1))
				end				
				end	
				end				
				end
				end
				end
				end 
				end 
				end	
				end				
			
	            for i=1,29 do
                if IsValid(self.ClientEnts["led_l_f2_rear"..i]) then self.ClientEnts["led_l_f2_rear"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1)) end
                if IsValid(self.ClientEnts["led_l_f4_new"..i]) then self.ClientEnts["led_l_f4_new"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,1)) end	
				end
				end 
	end]]
	
	--Анимация дверей.
	if not self.DoorStates then self.DoorStates = {} end
    if not self.DoorLoopStates then self.DoorLoopStates = {} end
    for b=0,2 do
        for k=0,1 do
            local st = k==1 and "DoorL" or "DoorR"
            local doorstate = self:GetPackedBool(st)
            local id,sid = st..(b+1),"door"..b.."x"..k
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
            local n_l = "door"..b.."x"..k.."a"
            local n_r = "door"..b.."x"..k.."b"
			local n_l1 = "door"..b.."x1"..k.."a1"
            local n_r1 = "door"..b.."x1"..k.."b1"							
            self:Animate(n_l,state,0,1,15,1)--0.8 + (-0.2+0.4*math.random()),0)
            self:Animate(n_r,state,0,1,15,1)--0.8 + (-0.2+0.4*math.random()),0)	
            Pricep740:Animate(n_r1,state,0,1,15,1)--0.8 + (-0.2+0.4*math.random()),0)			
			Pricep740:Animate(n_l1,state,0,1,15,1)--0.8 + (-0.2+0.4*math.random()),0)
        end
	end
	
    local door_f = self:GetPackedBool("FrontDoor")
    local door_t = Pricep740:GetPackedBool("RearDoor")	
    local door_cab_f = self:Animate("door_cab_f",door_f and 0.99 or -0.05, 0, 0.5, 4.5, 0.55)
    local door_cab_b = Pricep740:Animate("door_cab_b",door_t and 0.99 or -0.05, 0, 0.55, 4.5, 0.55)	

    local door1s = (door_cab_f > 0 or door_f)
    if self.Door1 ~= door1s then
        self.Door1 = door1s
        self:PlayOnce("FrontDoor","bass",door1s and 1 or 0)
    end
    local door2s = (door_cab_b > 0 or door_t)
    if Pricep740.Door2 ~= door2s then
        Pricep740.Door2 = door2s
        Pricep740:PlayOnce("RearDoor","bass",door2s and 1 or 0)
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
	
    local state = self:GetPackedBool("CompressorWork")
    self:SetSoundState("compressor",state and 1.0 or 0,1)	
	
    --local rol10 = math.Clamp(speed/5,0,1)*(1-math.Clamp((speed-50)/8,0,1))
    --local rol70 = math.Clamp((speed-50)/8,0,1)
    local rollingi = math.min(1,self.TunnelCoeff+math.Clamp((self.StreetCoeff-0.82)/0.5,0,1))
    local rollings = math.max(self.TunnelCoeff*0.6,self.StreetCoeff)
    local tunstreet = (rollingi+rollings*0.2)
    local rol5 = math.Clamp(speed/5,0,1)*(1-math.Clamp((speed-10)/5,0,1))
    local rol5p = Lerp((speed-5)/5,0.9,1.1)		
    local rol10 = math.Clamp(speed/12,0,1)*(1-math.Clamp((speed-20)/12,0,1))
    local rol10p = Lerp((speed-12)/12,0.9,1.1)
    local rol30 = math.Clamp((speed-20)/12,0,1)*(1-math.Clamp((speed-40)/12,0,1))
    local rol30p = Lerp((speed-15)/30,0.8,1.2)
    local rol55 = math.Clamp((speed-40)/12,0,1)*(1-math.Clamp((speed-65)/15,0,1))
    local rol55p = Lerp(0.8+(speed-43)/24,0.8,1.2)
    local rol75 = math.Clamp((speed-65)/15,0,1)
    local rol75p = Lerp(0.8+(speed-67)/16,0.8,1.2)
    self:SetSoundState("rolling_5",rollingi*rol5,rol5p)	
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
	
    self:SetSoundState("rolling_low_740"    ,rol10*rollings,rol10p) --15
    self:SetSoundState("rolling_medium2_740",rol40*rollings,rol40p) --57
    self:SetSoundState("rolling_high2_740"  ,rol70*rollings,rol70p) --70	

    local state = self:GetPackedRatio("RNState")
    self.TISUVol = math.Clamp(self.TISUVol+(state-self.TISUVol)*dT*8,0,1)
	
	local AsyncSound = self:GetNW2Int("AsyncSound")
	if AsyncSound==1 then		
    self:SetSoundState("async1", self.TISUVol/1.5, 1)
	end
	if AsyncSound==2 then		
    self:SetSoundState("async2", self.TISUVol/1.5, 1)
	end		
	if AsyncSound==3 then		
    self:SetSoundState("async3", self.TISUVol/1.5, 1)
	end		
	if AsyncSound==4 then		
    self:SetSoundState("async4", self.TISUVol/1.5, 1)
	end		
	if AsyncSound==5 then		
    self:SetSoundState("async5", self.TISUVol/1.5, 1)
	end	
	if AsyncSound==6 then		
    self:SetSoundState("async6", self.TISUVol/1.5, 1)
	end	
	
	local BBEs = self:GetNW2Int("BBESound")	
	if BBEs==1 then		
    self:SetSoundState("bbe_v1", self:GetPackedBool("BBEWork") and 1 or 0, 1)
	end
	if BBEs==2 then		
    self:SetSoundState("bbe_v2", self:GetPackedBool("BBEWork") and 1 or 0, 1)
	end	
	if BBEs==3 then		
    self:SetSoundState("bbe_v3", self:GetPackedBool("BBEWork") and 1 or 0, 1)
	end			

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
    local Pricep740 = self:GetNW2Entity("gmod_pricep_kuzov")
	if Pricep740.ButtonMap then	
	self.RTMaterial:SetTexture("$basetexture", self.Tickers)		
    Pricep740:DrawOnPanel("Tickers_rear",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(512,32+8,1024+16,64+16,0)
    end)
end	
end
function ENT:OnButtonPressed(button)
end
local dist = {
    GV = 150,
}
for id,panel in pairs(ENT.ButtonMap) do
    if not panel.buttons then continue end
    for k,v in pairs(panel.buttons) do
        if v.model then
            local dist = dist[id] or 150
            if v.model.model then
                v.model.hideseat=dist
            elseif v.model.lamp then
                v.model.lamp.hideseat=dist
            end
        end
    end
end

function ENT:OnPlay(soundid,location,range,pitch)
    if location == "stop" then
        if IsValid(self.Sounds[soundid]) then
            self.Sounds[soundid]:Pause()
            self.Sounds[soundid]:SetTime(0)
        end
        return
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
