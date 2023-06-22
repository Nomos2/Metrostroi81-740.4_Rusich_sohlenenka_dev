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

include("shared.lua")
Metrostroi.Version = 1537278077
--
ENT.ClientProps = {}
ENT.ButtonMap = {}
ENT.AutoAnims = {}
ENT.ClientSounds = {}
--
ENT.ClientPropsInitialized = false

--Головная часть 
ENT.ButtonMap["PUU"] = {
    pos = Vector(814.8-144, 43, 2.2), --446 -- 14 -- -0,5
    ang = Angle(0,-90,40),
    width = 685,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
			{ID = "!DoorsClosed",x=93, y=30.5, radius=8, tooltip = "",model = {
			model = "models/metrostroi_train/81-722/button_green.mdl",z=1.85,
            lamp = {model = "models/metrostroi_train/81-722/lamp_green.mdl",var="DoorsClosed"},
        }},
		
        {ID = "StandToggle",x=213, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_green.mdl",z=1.85,
            var="Stand",speed=12, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "notused1234",x=183, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_red.mdl",z=1.85,
            var="Stand123",speed=12, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "notused123",x=123, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_red.mdl",z=1.85,
            var="Stand123",speed=12, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		    {ID = "!HVoltage",x=147.5+37.83*0.16, y=30.5, radius=8, tooltip = "",model = {
			model = "models/metrostroi_train/81-722/button_green.mdl",z=1.85,
            lamp = {model = "models/metrostroi_train/81-722/lamp_green.mdl",var="HVoltage"},
        }},
        {ID = "KAHToggle",x=147.5+37.83*3, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_green.mdl",z=1.85,
            lamp = {model = "models/metrostroi_train/81-722/lamp_green.mdl",var="KAHLamp", anim=true},
            var="KAH",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "KAHkToggle",x=147.5+37.83*3-20, y=27.5+10, w=40,h=20, tooltip="", model = {
            model = "models/metrostroi_train/81/krishka.mdl", ang = 0, z = 1,
            var="KAHk",speed=8,min=0.32,max=0.721, disable="KAHToggle",
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=70,x=15,y=-40,z=-3.6,var="KAHPl", ID="KAHPl",},
            sndvol = 1, snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "ALSToggle",x=147.5+37.83*4, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_green.mdl", z=1.85,
            lamp = {model = "models/metrostroi_train/81-722/lamp_green.mdl",var="ALSLamp",z=0.1, anim=true},
            var="ALS",speed=8, vmin=0, vmax=0, disable="ALSToggle",
            --sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "AccelRateSet",x=147.5+37.88*5-7, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_white.mdl",z=1.85,
            var="AccelRate",speed=8, vmin=0, vmax=0.7,
           -- lamp = {model = "models/metrostroi_train/81-720/buttons/l1.mdl",var="AccelRateLamp",anim=true},
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "RingSet",x=147.5+37.83*6-10, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_white.mdl",z=1.85,
            var="Ring",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		/*
        {ID = "FDepotToggle",x=147.5+37.83*5, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/buttons/b4.mdl",z=6,
            var="FDepot",speed=12, vmin=0, vmax=1,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		*/
        {ID = "PassSchemeToggle",x=151.5+37.83*7.5-8, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_green.mdl",z=1.85,
           lamp = {model = "models/metrostroi_train/81-722/lamp_green.mdl",var="PassSchemeLamp",anim=true},
            var="PassScheme",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		/*
        {ID = "EmergencyCompressorSet",x=148+37.83*9+10, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/buttons/b7.mdl",z=7,
            var="EmergencyCompressor",speed=12, vmin=0, vmax=0.9,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		*/
		
        {ID = "EnableBVSet",x=95+37.83*8, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_white.mdl",z=1.85,
            var="EnableBV",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		
        {ID = "DisableBVSet",x=156+37.83*8, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_yellow.mdl",z=1.85,
            var="DisableBV",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "notused1123",x=490.63, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_yellow.mdl",z=1.85,
            --lamp = {model = "models/metrostroi_train/81-722/lamp_yellow.mdl",var="TickerLamp", z=0.1, anim=true},
            var="notused1123",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "R_Program2Set",x=579.63+36.5*0, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_yellow.mdl",z=1.85,--blue
            var="R_Program2",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "R_AnnouncerToggle",x=576.63+36.5*2.75, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_blue.mdl",z=2.5,--blue
          --  lamp = {model = "models/metrostroi_train/81-720/buttons/l1.mdl",var="R_AnnouncerLamp",anim=true, color=Color(50,150,200)},
            var="R_Announcer",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "R_LineToggle",x=545, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_yellow.mdl",z=1.85,--blue
            lamp = {model = "models/metrostroi_train/81-722/lamp_yellow.mdl",var="R_LineLamp",anim=true},
            var="R_Line",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "R_EmerSet",x=576.63+35.5*1, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_yellow.mdl",skin =2,z=1.85,--blue
            var="R_Emer",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		/*
        {ID = "R_Program1Set",x=576.63+35.2*4, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/buttons/b5.mdl",z=2.7,--blue
            var="R_Program1",speed=8, vmin=0, vmax=0,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
*/
/*
        {ID = "EnableBVEmerSet",x=52, y=110, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/button_circle2.mdl",z=3,
            var="EnableBVEmer",speed=12, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
	*/	
		
		{ID = "EmergencyCompressorSet",x=576.63+36.5*1.05, y=90, radius=15, tooltip = "",model = { --566.63+36.5*1
            model = "models/metrostroi_train/81-722/button_white.mdl", z=1.85,
            var="EmergencyCompressor",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "EmergencyControlsToggle",x=576.63+36.5*2.3, y=90, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_red.mdl", z=1.85,
            lamp = {model = "models/metrostroi_train/81-722/lamp_red.mdl",var="EmergencyControls",z=0, anim=true},
            var="EmergencyControls",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "WiperToggle",x=579.63+35.75*1.8, y=30.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_blue.mdl",z=1.85,
            var="Wiper",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "notused12345",x=531, y=95, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/rc_rotator1.mdl",z=3.85,ang = Angle (0,0,0),
			scale = 0.4,
            var="notused12345",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		--models/metrostroi_train/81-720/rc_rotator1.mdl

        {ID = "!VDop",x=269, y=69, w=107, h=6, tooltip = "Допустимая скорость"},
        {ID = "!VFact",x=269, y=76+9, w=107, h=6, tooltip = "Фактическая скорость"},
        {ID = "!VPred",x=269, y=76+17, w=107, h=6, tooltip = "Предупредительная скорость"},
		{ID = "!VDop2",x=381, y=65, w=26, h=28, tooltip = "Допустимая скорость"},
    }
}

ENT.ClientProps["Head0-_--"] = {
    model = "models/metrostroi_train/81-740/body/headlight.mdl", --_-- обозначает положение фары на маске.
    pos = Vector(324.5-144.5, 4.4, -55.8),
    ang = Angle(-7,0,0),
    scale = 1.1, 
    nohide=true,
}
ENT.ClientProps["Head--_-0"] = {
    model = "models/metrostroi_train/81-740/body/headlight.mdl",
    pos = Vector(324.5-144.5, 85.8, -55.8),
    ang = Angle(-7,0,0),
    scale = 1.1, 
    nohide=true,
}

ENT.ClientProps["Head-0_--"] = {
    model = "models/metrostroi_train/81-740/body/headlight.mdl",
    pos = Vector(324.8-144.5, 17.5, -58.2),
    ang = Angle(-7,0,0),
    scale = 1.1, 
    nohide=true,
}
ENT.ClientProps["Head--_0-"] = {
    model = "models/metrostroi_train/81-740/body/headlight.mdl",
    pos = Vector(324.8-144.5, 72.8, -58.2),
    ang = Angle(-7,0,0),
    scale = 1.1, 
    nohide=true,
}
	
ENT.ClientProps["krepezh"] = {
    model = "models/metrostroi_train/81-740/body/krepezh.mdl",
    pos = Vector(286,0,-71),
    ang = Angle(0,0,0),
    nohide = true,
}

ENT.ClientProps["lamps_salon_off"] = {
    model = "models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl",
    pos = Vector(852-144,0.1,0),
    ang = Angle(0,-180,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_off1"] = {
    model = "models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl",
    pos = Vector(799-144,0.1,0),
    ang = Angle(0,-180,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_off2"] = {
    model = "models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl",
    pos = Vector(746-144,0.1,0),
    ang = Angle(0,-180,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_off3"] = {
    model = "models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl",
    pos = Vector(691-144,0.1,0),
    ang = Angle(0,-180,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_off4"] = {
    model = "models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl",
    pos = Vector(636-144,0.1,0),
    ang = Angle(0,-180,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_off5"] = {
    model = "models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl",
    pos = Vector(581-144,0.1,0),
    ang = Angle(0,-180,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_off6"] = {
    model = "models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl",
    pos = Vector(527-144,0.1,0),
    ang = Angle(0,-180,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_off7"] = {
    model = "models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl",
    pos = Vector(474-144,0.1,0),
    ang = Angle(0,-180,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_off8"] = {
    model = "models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl",
    pos = Vector(419-144,0.1,0),
    ang = Angle(0,-180,0),
    hide=2,
}

ENT.ClientProps["lamps_salon_off_fr"] = {
    model = "models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl",
    pos = Vector(852-144,-58.5,0),
    ang = Angle(0,-180,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_off_fr1"] = {
    model = "models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl",
    pos = Vector(799-144,-58.5,0),
    ang = Angle(0,-180,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_off_fr2"] = {
    model = "models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl",
    pos = Vector(746-144,-58.5,0),
    ang = Angle(0,-180,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_off_fr3"] = {
    model = "models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl",
    pos = Vector(691-144,-58.5,0),
    ang = Angle(0,-180,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_off_fr4"] = {
    model = "models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl",
    pos = Vector(636-144,-58.5,0),
    ang = Angle(0,-180,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_off_fr5"] = {
    model = "models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl",
    pos = Vector(581-144,-58.5,0),
    ang = Angle(0,-180,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_off_fr6"] = {
    model = "models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl",
    pos = Vector(527-144,-58.5,0),
    ang = Angle(0,-180,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_off_fr7"] = {
    model = "models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl",
    pos = Vector(474-144,-58.5,0),
    ang = Angle(0,-180,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_off_fr8"] = {
    model = "models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl",
    pos = Vector(419-144,-58.5,0),
    ang = Angle(0,-180,0),
    hide=2,
}

--Аварийка
ENT.ClientProps["lamps_salon_on_avar1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(689-144,-58,-74.15),
    ang = Angle(0,-180,0),
	hide=2,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on_avar2"] = { 
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(309-144,0.5,-74.15),
    ang = Angle(0,-180,0),
	hide=2,
    color = Color(245,238,223),		
}
--Аварийка


ENT.ClientProps["lamps_salon_on1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(689-144,0.5,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on2"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(636-144,0.5,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on3"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(581-144,0.5,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on4"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(527-144,0.5,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on5"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(473-144,0.5,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on6"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(419-144,0.5,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on7"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(364-144,0.5,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on8"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(309-144,0.5,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on9"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(255-144,0.5,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}

ENT.ClientProps["lamps_salon_on_fr1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(689-144,-58,-74.15),
    ang = Angle(0,180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on_fr2"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(635-144,-58,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on_fr3"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(581-144,-58,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on_fr4"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(527-144,-58,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on_fr5"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(473-144,-58,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on_fr6"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(418.7-144,-58,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on_fr7"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(364-144,-58,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on_fr8"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(310-144,-58,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["lamps_salon_on_fr9"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(255.5-144,-58,-74.15),
    ang = Angle(0,-180,0),
    hide = 1,
    color = Color(245,238,223),		
}
ENT.ClientProps["Wiper_760"] = {
    model = "models/metrostroi_train/81-740/body/81-740_wiper.mdl",
    pos = Vector(176.8,-10,0),
    ang = Angle(0,0,0),
    hide = 2,		
}

ENT.ButtonMap["ALSPANELLAMPS"] = { -- дополнительные лампы АЛС 
	pos = Vector(812-144,17.2,-0.01), --446 -- 14 -- -0,5
	ang = Angle(0,-90,40),
	width = 75,
	height = 50,
	scale = 0.0625,
	hideseat=0.2,

        buttons = {
		{ID = "!LN",x=10.8, y=13.7, radius=10, tooltip = "",model = {
            name="LN", lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",var="LN",z=-3.5, color=Color(120,255,50)},
        }},
		{ID = "!Dnepr",x=28, y=34.1, radius=10, tooltip = "",model = {
            name="Dnepr",lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",var="Dnepr",z=-3.5, color=Color(255,0,0)},
        }},
		{ID = "!XOD",x=28, y=13.7, radius=10, tooltip = "",model = {
            name="XOD",lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",var="XOD",z=-3.5, color=Color(250, 250, 15)},
        }},
		{ID = "!DAU",x=45, y=34.1, radius=10, tooltip = "",model = {
            name="DAU",lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",var="DAU",z=-3.5, color=Color(255,0,0)},
        }},
		{ID = "!AO",x=10.8, y=34.1, radius=10, tooltip = "",model = {
            name="AO",lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",var="AO",z=-3.5, color=Color(255,50,0)},
        }},
		{ID = "!Ispr",x=45, y=13.7, radius=10, tooltip = "",model = {
            name="Ispr",lamp = {model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",var="Ispr",z=-3.5, color=Color(120,255,50)},
		}},	
		{ID = "!Forw",x=55, y=10, w=18, h=10, tooltip = "Движение вперёд"},
        {ID = "!Back",x=55, y=25, w=18, h=10, tooltip = "Движение назад"},
    }
}
ENT.ButtonMap["PUL"] = {
    pos = Vector(807-144, 34.5, -3.1), --446 -- 14 -- -0,5
    ang = Angle(0,-90,21.5),
    width = 100,
    height = 220,
    scale = 0.0450,
    hideseat=0.2,

    buttons = {
        {ID = "DoorSelectLToggle",x=13, y=65, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_white.mdl",z=-4.8,  --models/metrostroi_train/81-720/buttons/b4.mdl
            lamp = {model = "models/metrostroi_train/81-722/lamp_black.mdl",var="DoorLeftLamp",anim=true},
            var="DoorSelectL",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "DoorSelectRToggle",x=70, y=65, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_white.mdl",z=-4.8,
            lamp = {model = "models/metrostroi_train/81-722/lamp_black.mdl",var="DoorRightLamp",anim=true},
            var="DoorSelectR",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "DoorBlockToggle",x=70, y=130, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_red.mdl",z=-6,  --models/metrostroi_train/81-720/buttons/b6.mdl
			lamp = {model = "models/metrostroi_train/81-722/lamp_red.mdl",var="DoorBlockLamp",anim=true},
            var="DoorBlock",speed=8, vmin=0, vmax=0.5,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		/*
        {ID = "!DoorLeftLamp",x=70, y=197, tooltip = "",model = {
           lamp = {model = "models/pult/button_lru.mdl",var="DoorLeftLamp",z=-0.5,skin = 9,anim=true},
        }},
*/
        {ID = "DoorLeftSet",x=70, y=197, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_white.mdl",z=-5.3,
			lamp = {model ="models/metrostroi_train/81-722/lamp_black.mdl", var ="DoorLeftLamp",anim=true},
				--models/metrostroi_train/81-720/button_circle1.mdl
            var="DoorLeft",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["PUR"] = {
    pos = Vector(806.5-144,13.5,-3.3), --446 -- 14 -- -0,5
    ang = Angle(0,-90,22),
    width = 220,
    height = 210,
    scale = 0.0450,
    hideseat=0.2,

    buttons = {
        /*{ID = "AccelRateSet",x=13, y=79.5, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/buttons/b4.mdl",z=-6,
            var="AccelRate",speed=12, vmin=0, vmax=1,
            lamp = {model = "models/metrostroi_train/81-720/buttons/l1.mdl",var="AccelRateLamp",anim=true},
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},*/
		
		{ID = "TPTToggle",x=24, y=55, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_red.mdl",z=-6,
            var="TPT",speed=12, vmin=0, vmax=0.5,
            lamp = {model = "models/metrostroi_train/81-722/lamp_red.mdl",var="TPT",anim=true},
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		
		
		
        {ID = "EmerBrakeAddSet",x=65.5, y=55, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_black.mdl",z=-5.1,  --models/metrostroi_train/81-720/buttons/b2.mdl
            var="EmerBrakeAdd",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "EmerBrakeReleaseSet",x=106, y=55, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_white.mdl",z=-5.1,   --models/metrostroi_train/81-720/buttons/b5.mdl
            var="EmerBrakeRelease",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "EmerBrakeToggle",x=149, y=55, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_black.mdl",z=-5.1,        --b6
           -- lamp = {model = "models/pult/button_lmini.mdl",var="EmerBrakeWork",z=0.1,anim=true,skin=2},
            var="EmerBrake",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "EmergencyBrakeToggle",x=188, y=55, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler2.mdl",z=-10, ang=180,
            var="EmergencyBrake",speed=12, vmin=0, vmax=1,
            sndvol = 0.5, snd = function(val) return val and "switch_on" or "switch_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},

        {ID = "DoorCloseToggle",x=21, y=119, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_green.mdl",z=-5.1, --models/metrostroi_train/81-720/buttons/b5.mdl
            lamp = {model = "models/metrostroi_train/81-722/lamp_green.mdl",z=0.0,var="DoorCloseLamp",anim=true}, --models/metrostroi_train/81-720/buttons/l1.mdl ,anim=true,color=Color(80,255,100)
            var="DoorClose",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "AttentionMessageSet",x=65, y=119, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_yellow.mdl",z=-5.1,
            var="AttentionMessage",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "AttentionSet",x=105, y=119, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_red.mdl",z=-5.1,
            var="Attention",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "AttentionBrakeSet",x=148, y=119, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_red.mdl",z=-5.1,  --models/metrostroi_train/81-720/buttons/b6.mdl
            var="AttentionBrake",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "R_Program1Set",x=188, y=119, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_yellow.mdl",z=-5.1,--blue
            var="R_Program1",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.3, snd = function(val) return val and "button_square_press" or "button_square_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		
		
		
        {ID = "HornBSet",x=25.5, y=191, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_yellow.mdl",z=-5,  --models/metrostroi_train/81-720/button_circle1.mdl
            var="HornB",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "DoorRightSet",x=110, y=191, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_white.mdl",z=-5,  --models/metrostroi_train/81-720/button_circle1.mdl
			lamp = {model = "models/metrostroi_train/81-722/lamp_black.mdl",var="DoorRightLamp",anim=true},
            var="DoorRight",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["RV"] = {
    pos = Vector(806.4-144,52,-4),
    ang = Angle(-1,-90,30),
    width = 60,
    height = 200,
    scale = 0.0450,

    buttons = {
	    {ID = "EmergencyDoorsToggle",x=30, y=15, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_green.mdl",z=-2.8,  --models/metrostroi_train/81-720/tumbler2.mdl
			lamp = {model ="models/metrostroi_train/81-722/lamp_green.mdl", var="EmergencyDoors", anim=true},
            var="EmergencyDoors",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_square_on" or "button_square_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "EmerX1Set",x=30, y=125, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_black.mdl",z=-3,
            var="EmerX1",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "EmerX2Set",x=30, y=180, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_black.mdl",z=-3, --models/metrostroi_train/81-720/button_circle3.mdl
            var="EmerX2",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "EmerCloseDoorsSet",x=30, y=70, radius=15, tooltip = "",model = {
            model = "models/metrostroi_train/81-722/button_black.mdl",z=-3,
            var="EmerCloseDoors",speed=8, vmin=0, vmax=0.7,
            sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["CAMSButtons"] = {
    pos = Vector(807.3-144,46.9,-3.72),
    ang = Angle(-1,-90,30),
    width = 100,
    height = 120,
    scale = 0.055,
	hideseat=0.2,

    buttons = {
        {ID = "CAMS7Set",x=39, y=26, w=20,h=20, tooltip = "",model = {
            model = "models/metrostroi_train/81-740/cabine/pult/buttons/button_lmini.mdl",skin=3,z=0.7,
			var="CAMS7",speed=10, vmin=0, vmax=0.5,
			sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "CAMS9Set",x=9, y=41, w=20,h=20, tooltip = "",model = { 
            model = "models/metrostroi_train/81-740/cabine/pult/buttons/button_lmini.mdl",skin=3,z=0.9,
			var="CAMS9",speed=10, vmin=0, vmax=0.5,
			sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "CAMS5Set",x=9, y=68, w=20,h=20, tooltip = "",model = { 
            model = "models/metrostroi_train/81-740/cabine/pult/buttons/button_lmini.mdl",skin=3,z=0.7,
			var="CAMS5",speed=10, vmin=0, vmax=0.5,
			sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "CAMS10Set",x=70, y=41, w=20,h=20, tooltip = "",model = { 
            model = "models/metrostroi_train/81-740/cabine/pult/buttons/button_lmini.mdl",skin=3,z=0.7,
			var="CAMS10",speed=10, vmin=0, vmax=0.5,
			sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "CAMS6Set",x=70, y=68, w=20,h=20, tooltip = "",model = {
            model = "models/metrostroi_train/81-740/cabine/pult/buttons/button_lmini.mdl",skin=3,z=0.7,
			var="CAMS6",speed=10, vmin=0, vmax=0.5,
			sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "CAMS8Set",x=39, y=86, w=20,h=20, tooltip = "",model = {
            model = "models/metrostroi_train/81-740/cabine/pult/buttons/button_lmini.mdl",skin=3,z=0.7,
			var="CAMS8",speed=10, vmin=0, vmax=0.5,
			sndvol = 0.5, snd = function(val) return val and "button_press" or "button_release" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["PneumoHelper1"] = {
    pos = Vector(788-144,58.5,15.2),
    ang = Angle(0,0,92),
    width = 70,
    height = 76,
    scale = 0.0625,
    buttons = {
        {ID = "!BrakeCylinder",x=35, y=38, radius=38, tooltip = ""},
    }
}
ENT.ButtonMap["PneumoHelper2"] = {
    pos = Vector(788-144,58.2,22.3),
    ang = Angle(0,0,92),
    width = 70,
    height = 76,
    scale = 0.0625,
    buttons = {
        {ID = "!BrakeTrainLine",x=35, y=38, radius=38, tooltip = ""},
    }
}

--Вольтаж
ENT.ButtonMap["VoltHelper2"] = {
    pos = Vector(817-144,50.7,22),
    ang = Angle(0,-90,108),
    width = 60,
    height = 118,
    scale = 0.0625,

    buttons = {
        {ID = "!HV",x=0, y=0, w=60, h=50, tooltip = ""},
        {ID = "!I1_3",x=0, y=64, w=60, h=50, tooltip = ""},
        --{ID = "!I2_4",x=0, y=130, w=60, h=60, tooltip = ""},
    }
}

ENT.ButtonMap["ASNP"] = {
    pos = Vector(822.1-144,-49.8,-6.6), --446 -- 14 -- -0,5
    ang = Angle(0,-170,90),
    width = 120,
    height = 50,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "R_ASNPMenuSet",x=29, y=35, radius=16, z=4, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl", scale=0,
            var="R_ASNPMenu",speed=12, vmin=0, vmax=0.9,
            sndvol = 0.5,snd = function(val) return val and "pnm_button1_on" or "pnm_button1_off" end,
            sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "R_ASNPUpSet",x=110, y=4, radius=8, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl", scale=0,
            var="R_ASNPUp",speed=12, vmin=0, vmax=0.9,z=4, 
            sndvol = 0.5,snd = function(val) return val and "pnm_button1_on" or "pnm_button2_off" end,
            sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "R_ASNPDownSet",x=110, y=18, radius=8, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl", scale=0,
            var="R_ASNPDown",speed=12, vmin=0, vmax=0.9,z=4, 
            sndvol = 0.5,snd = function(val) return val and "pnm_button2_on" or "pnm_button1_off" end,
            sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "R_ASNPOnToggle",x=2, y=10, radius=8, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler2.mdl", ang=0, scale=0.7,z=5,
            var="R_ASNPOn",speed=12, vmin=1, vmax=0,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=90,x=-0.5,z=2,y=-12,scale=0.7,var="R_ASNPOnPl",ID="R_ASNPOnPl",},			
            sndvol = 0.5,snd = function(val) return val and "pnm_on" or "pnm_off" end,
            sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["ASNPScreen"] = {
    pos = Vector(820.05-144,-49.8,-6.6), --446 -- 14 -- -0,5
    ang = Angle(0,-170,90),
    width = 520,
    height = 125,
    scale = 0.01,
    hide=0.8,
}
--ИГЛА
ENT.ButtonMap["IGLA_C"] = {
    pos = Vector(735.85-144,34.1,44.6),
    ang = Angle(0,90,90),
    width = 512,--18333.333333333333333333333333333
    height = 107,--7916.6666666666666666666666666667
    scale = 0.0171,
    hideseat=0.8,
    hide=true,
}
ENT.ButtonMap["IGLAButtons_C"] = {
    pos = Vector(735.85-144,34,45.71),
    ang = Angle(0,90,90),
    width = 147,
    height = 75,
    scale = 0.0625,
    hideseat=0.2,
    buttons = {
        {ID = "IGLA1Set",x=22+32.5*-0.18,y=58,w=14,h=12,tooltip="",model = {
            lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod1.mdl",var="IGLA:ButtonL1",scale = 1,color=Color(175,250,20),x=0.5,y=-2.5,z=-2.5},
        }},
        {ID = "IGLA2Set",x=23+32.5*0.89,y=58,w=14,h=12,tooltip="",model = {
            lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod1.mdl",var="IGLA:ButtonL2",scale = 1,color=Color(175,250,20),x=-2.5,y=-2.7,z=-2.5},
        }},
        {ID = "IGLA23",x=65,y=58,w=14,h=12,tooltip=""},
        {ID = "IGLA3Set",x=80,y=58,w=14,h=12,tooltip="",model = {
            lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod1.mdl",var="IGLA:ButtonL3",scale = 1,color=Color(175,250,20),x=1,y=-2.7,z=-2.5},
        }},
        {ID = "IGLA4Set",x=15+32.5*3,y=58, w=14,h=12,tooltip="",model = {
            lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod1.mdl",var="IGLA:ButtonL4",scale = 1,color=Color(175,250,20),x=1,y=-2.7,z=-2.5},
        }},
        {ID = "!IGLAFire",x=136,y=62,radius=3,tooltip="",model = {
            lamp = {speed=16,model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",var="IGLA:Fire",scale = 0.95,color=Color(255,56,30),z=-2.5,ang=0,},
        }},
        {ID = "!IGLAErr",x=136,y=69.1,radius=3,tooltip="",model = {
            lamp = {speed=16,model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",var="IGLA:Error",scale = 0.95,color=Color(255,168,000),z=-2.5,ang=0},
        }},
    }
}
ENT.ButtonMap["Tickers"] = {
    pos = Vector(162.8-144,-27.2,66.45), --446 -- 14 -- -0,5
    ang = Angle(0,90,90),
    width = 1024,
    height = 64,
    scale = 0.055,
    hide=true,
    hideseat=1,
}
ENT.ButtonMap["BackVent"] = {
    pos = Vector(735.25-143.7,27,47), --446 -- 14 -- -0,5
    ang = Angle(0,90,90),
    width = 80,
    height = 110,
    scale = 0.0625,
    hide=0.8,

    buttons = {
    {ID = "!VentCondMode",x=36, y=35, radius=0, model = {
        model = "models/metrostroi_train/81-720/rc_rotator1.mdl",z=10,ang=-91,
        sndvol = 0.8, snd = function(val) return val and "switch_batt_on" or "switch_batt_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0), scale = 0.9,
        getfunc = function(ent) return ent:GetPackedRatio("VentCondMode") end,var="VentCondMode",
        speed=4, min=0.76,max=0.0
    }},
    {ID = "VentCondMode-",x=11,y=14,w=30,h=40,tooltip=""},
    {ID = "VentCondMode+",x=30,y=14,w=30,h=40,tooltip=""},
    {ID = "!VentStrengthMode",x=36, y=83, radius=0, model = {
        model = "models/metrostroi_train/81-720/rc_rotator1.mdl",z=10,ang=-91,
        sndvol = 0.8, snd = function(val) return val and "switch_batt_on" or "switch_batt_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0), scale = 0.9,
        getfunc = function(ent) return ent:GetPackedRatio("VentStrengthMode") end,var="VentStrengthMode",
        speed=4, min=0.76,max=0.0
    }},
    {ID = "VentStrengthMode-",x=11,y=63,w=30,h=40,tooltip=""},
    {ID = "VentStrengthMode+",x=30,y=63,w=30,h=40,tooltip=""},
    }
}

ENT.ButtonMap["BackPPZ"] = {
    pos = Vector(735.52-144,22,35), --446 -- 14 -- -0,5
    ang = Angle(0,90,90),
    width = 400,
    height = 310,
    scale = 0.0625,
    hideseat=0.8,
    hide=true,
	
	buttons = {
        {ID = "SF1Toggle",x=61.5+0*28.8, y=73, w=20,h=40, tooltip = "",},
        {ID = "SF2Toggle",x=61.5+1*28.8, y=73, w=20,h=40, tooltip = "",},
        {ID = "SF3Toggle",x=61.5+2*28.8, y=73, w=20,h=40, tooltip = "",},
        {ID = "SF4Toggle",x=61.5+3*28.8, y=73, w=20,h=40, tooltip = "",},
        {ID = "SF5Toggle",x=61.5+4*28.8, y=73, w=20,h=40, tooltip = "",},
        {ID = "SF6Toggle",x=61.5+5*28.8, y=73, w=20,h=40, tooltip = "",},
        {ID = "SF7Toggle",x=61.5+6*28.8, y=73, w=20,h=40, tooltip = "",},
        {ID = "SF8Toggle",x=61.5+7*28.8, y=73, w=20,h=40, tooltip = "",},
        {ID = "SF9Toggle",x=61.5+8*28.8, y=73, w=20,h=40, tooltip = "",},
        {ID = "SF10Toggle",x=61.5+9*28.8, y=73, w=20,h=40, tooltip = "",},
        {ID = "SF11Toggle",x=61.5+10*28.8, y=73, w=20,h=40, tooltip = ""},

        {ID = "SF12Toggle",x=61.5+0*28.8, y=205, w=20,h=40, tooltip = "",},
        {ID = "SF13Toggle",x=61.5+1*28.8, y=205, w=20,h=40, tooltip = "",},
        {ID = "SF14Toggle",x=61.5+2*28.8, y=205, w=20,h=40, tooltip = "",},
        {ID = "SF15Toggle",x=61.5+3*28.8, y=205, w=20,h=40, tooltip = "",},
        {ID = "SF16Toggle",x=61.5+4*28.8, y=205, w=20,h=40, tooltip = "",},
        {ID = "SF17Toggle",x=61.5+5*28.8, y=205, w=20,h=40, tooltip = "",},
        {ID = "SF18Toggle",x=61.5+6*28.8, y=205, w=20,h=40, tooltip = "",},
        {ID = "SF19Toggle",x=61.5+7*28.8, y=205, w=20,h=40, tooltip = "",},
        {ID = "SF20Toggle",x=61.5+8*28.8, y=205, w=20,h=40, tooltip = "",},
        {ID = "SF21Toggle",x=61.5+9*28.8, y=205, w=20,h=40, tooltip = "",},
        {ID = "SF22Toggle",x=61.5+10*28.8, y=205, w=20,h=40, tooltip = ""},
    }
}

for k,buttbl in ipairs(ENT.ButtonMap["BackPPZ"].buttons) do
    buttbl.model = {
        model = "models/metrostroi_train/81-720/button_av1.mdl",z=-18, ang=-90,
        var=buttbl.ID:Replace("Toggle",""),speed=9, vmin=0,vmax=1,
        sndvol = 0.8, snd = function(val) return val and "av_on" or "av_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
    }
end
ENT.ButtonMap["PVZ"] = {
    pos = Vector(735.52-144,25,-14), --446 -- 14 -- -0,5
    ang = Angle(0,90,90),
    width = 330,
    height = 160,
    scale = 0.0625,
    hide=0.8,

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

        {ID = "SFV12Toggle",x=0*30, y=55, w=30,h=50, tooltip = "",},
        {ID = "SFV13Toggle",x=1*30, y=55, w=30,h=50, tooltip = "",},
        {ID = "SFV14Toggle",x=2*30, y=55, w=30,h=50, tooltip = "",},
        {ID = "SFV15Toggle",x=3*30, y=55, w=30,h=50, tooltip = "",},
        {ID = "SFV16Toggle",x=4*30, y=55, w=30,h=50, tooltip = "",},
        {ID = "SFV17Toggle",x=5*30, y=55, w=30,h=50, tooltip = "",},
        {ID = "SFV18Toggle",x=6*30, y=55, w=30,h=50, tooltip = "",},
        {ID = "SFV19Toggle",x=7*30, y=55, w=30,h=50, tooltip = "",},
        {ID = "SFV20Toggle",x=8*30, y=55, w=30,h=50, tooltip = "",},
        {ID = "SFV21Toggle",x=9*30, y=55, w=30,h=50, tooltip = "",},
        {ID = "SFV22Toggle",x=10*30, y=55, w=30,h=50, tooltip = ""},

        {ID = "SFV24Toggle",x=0*30, y=110, w=30,h=50, tooltip = "",},
        {ID = "SFV26Toggle",x=1*30, y=110, w=30,h=50, tooltip = "",},
        {ID = "SFV27Toggle",x=2*30, y=110, w=30,h=50, tooltip = "",},
        {ID = "SFV28Toggle",x=3*30, y=110, w=30,h=50, tooltip = "",},
        {ID = "SFV29Toggle",x=4*30, y=110, w=30,h=50, tooltip = "",},
        {ID = "SFV30Toggle",x=5*30, y=110, w=30,h=50, tooltip = "",},
        {ID = "SFV31Toggle",x=6*30, y=110, w=30,h=50, tooltip = "",},
        {ID = "SFV32Toggle",x=7*30, y=110, w=30,h=50, tooltip = "",},
        {ID = "SFV33Toggle",x=8*30, y=110, w=30,h=50, tooltip = "",},
		{ID = "SFV34Toggle",x=9*30, y=110, w=30,h=50, tooltip = "",},
		{ID = "SFV35Toggle",x=10*30, y=110, w=30,h=50, tooltip = ""},
    }
}
for k,buttbl in ipairs(ENT.ButtonMap["PVZ"].buttons) do
    buttbl.model = {
        model = "models/metrostroi_train/81-720/button_av1.mdl",z=-17, ang=-90,
        var=buttbl.ID:Replace("Toggle",""),speed=9, vmin=0,vmax=1,
        sndvol = 0.8, snd = function(val) return val and "av_on" or "av_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
    }
end

ENT.ButtonMap["BackDown"] = {
    pos = Vector(735.52-144,23,12), --446 -- 14 -- -0,5
    ang = Angle(0,90,90),
    width = 400,
    height = 350,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "Pant1Toggle",x=85, y=62, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="Pant1",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Pant2Toggle",x=120, y=62, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="Pant2",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vent2Toggle",x=158+30, y=62, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_b_a.mdl",z=-2.6, ang=180,
            var="Vent2",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "PassLightToggle",x=222, y=62, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="PassLight",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "CabLightToggle",x=260, y=62, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="CabLight",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Headlights1Toggle",x=290, y=62, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="Headlights1",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Headlights2Toggle",x=330, y=62, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="Headlights2",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},

        {ID = "ParkingBrakeToggle",x=81, y=118, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="ParkingBrake",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "TorecDoorsToggle",x=115, y=118, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="TorecDoors",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "BBERToggle",x=152, y=118, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="BBER",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "BBEToggle",x=183, y=118, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="BBE",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "CompressorToggle",x=210, y=118, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="Compressor",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "CabLightStrengthToggle",x=250, y=118, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="CabLightStrength",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "AppLights1Toggle",x=290, y=118, radius=12, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="AppLights1",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "AppLights2Toggle",x=335, y=118, radius=12, tooltip = "", model = {
            model = "models/metrostroi_train/81-720/tumbler1.mdl",z=-2.6, ang=180,
            var="AppLights2",speed=12,
            sndvol = 0.5, snd = function(val) return val and "switch_pvz_on" or "switch_pvz_off" end,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},


        {ID = "!BARSBlock",x=214, y=190, radius=0, model = {
            model = "models/metrostroi_train/81-720/rc_rotator1.mdl",z=12,
            getfunc = function(ent) return ent:GetPackedRatio("BARSBlock") end,var="BARSBlock",
            plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=-90,x=0,y=40,z=-5,var="BARSBlockPl", ID="BARSBlockPl",},
            speed=6, min=0.5,max=0.15,
            sndvol = 1, snd = function(_,val) return val==3 and "switch_batt_on" or val == 0 and "switch_batt_off" or "switch_batt" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "BARSBlock-",x=188,y=172,w=30,h=40,tooltip="",model={
            plomb = {var="BARSBlockPl", ID="BARSBlockPl", },
        }},
        {ID = "BARSBlock+",x=212,y=172,w=30,h=40,tooltip="", model={
            plomb = {var="BARSBlockPl", ID="BARSBlockPl", },
        }},
        {ID = "BatteryToggle",x=334, y=190, radius=20, tooltip = "",model = {
            model = "models/metrostroi_train/81-720/rc_rotator1.mdl",z=12, ang=45,
            var="Battery",speed=2,
            sndvol = 1, snd = function(val) return val and "switch_batt_on" or "switch_batt_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
            vmin=0.15, vmax=0
        }},

        {ID = "!ALSFreqBlock",x=334, y=294, radius=0,tooltip = "", model = {
            model = "models/metrostroi_train/81-720/rc_rotator1.mdl",z=4, ang=180,scale = 0.5,
            getfunc = function(ent) return ent:GetPackedRatio("ALSFreqBlock") end,var="ALSFreqBlock",
			--plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=-90,x=0,y=16,z=-4.8,var="ALSFreqBlockPl", ID="ALSFreqBlockPl",},
            speed=6, min=0.9,max=0.6,
            sndvol = 1, snd = function(_,val) return val==3 and "switch_batt_on" or val == 0 and "switch_batt_off" or "switch_batt" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
			vmin=0.9, vmax=0
        }},
		{ID = "ALSFreqBlock-",x=344-25,y=302-20,w=15,h=22,tooltip="",model={
			--plomb = {var="ALSFreqBlockPl", ID="ALSFreqBlockPl", }
        }},
        {ID = "ALSFreqBlock+",x=344-10,y=302-20,w=15,h=22,tooltip="", model={
			--plomb = {var="ALSFreqBlockPl", ID="ALSFreqBlockPl", }
        }},
    }
}
ENT.ButtonMap["VityazButtons"] = {
    pos = Vector(806.12-144.3,-4.5,-4.2),
    ang = Angle(0,-90,31),
    width = 120,
    height = 90,
    scale = 0.0625,
    hideseat=0.2,
    buttons = {
		{ID = "VityazF4Set",x=1, y=-4, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f1.mdl",z=0, ang=0,var="VityazF1",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz3_press" or "button_vityaz3_release" end,sndmin = 40, --sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "VityazPVUSet",x=20, y=-4, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f1.mdl",z=0, ang=0,var="VityazF1",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz3_press" or "button_vityaz3_release" end,sndmin = 40, --sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VityazVOSet",x=1, y=13, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f2.mdl",z=0, ang=0,var="VityazF2",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz2_press" or "button_vityaz2_release" end,sndmin = 40, --sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VityazCurrentSet",x=1, y=30, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f3.mdl",z=0, ang=0,var="VityazF3",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "VityazSOTSet",x=20, y=30, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f3.mdl",z=0, ang=0,var="VityazF3",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VityazF2Set",x=1, y=47, w=20,h=20, tooltip = "",model = {
           -- model = "models/metrostroi_train/81-720/vyitaz/v_f4.mdl",z=0, ang=0,var="VityazF4",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz4_press" or "button_vityaz4_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "VityazNumSet",x=20, y=47, w=20,h=20, tooltip = "",model = {
           -- model = "models/metrostroi_train/81-720/vyitaz/v_f4.mdl",z=0, ang=0,var="VityazF4",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz4_press" or "button_vityaz4_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},

        {ID = "Vityaz1Set",x=40, y=-4, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_1.mdl",z=0, ang=0, var="Vityaz1",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz4Set",x=40, y=13, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_4.mdl",z=0, ang=0, var="Vityaz4",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz2_press" or "button_vityaz2_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz7Set",x=40, y=30, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_7.mdl",z=0, ang=0, var="Vityaz7",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz2Set",x=58, y=-4, w=20,h=20, tooltip = "",model = {
           -- model = "models/metrostroi_train/81-720/vyitaz/v_2.mdl",z=0, ang=0, var="Vityaz2",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz3_press" or "button_vityaz3_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "VityazTSet",x=20, y=13, w=20,h=20, tooltip = "",model = {
           -- model = "models/metrostroi_train/81-720/vyitaz/v_2.mdl",z=0, ang=0, var="Vityaz2",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz3_press" or "button_vityaz3_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz5Set",x=58, y=13, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_5.mdl",z=0, ang=0, var="Vityaz5",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz8Set",x=58, y=30, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_8.mdl",z=0, ang=0, var="Vityaz8",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz4_press" or "button_vityaz4_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz0Set",x=58, y=47, w=20,h=20, tooltip = "",model = {
           -- model = "models/metrostroi_train/81-720/vyitaz/v_0.mdl",z=0, ang=0, var="Vityaz0",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz2_press" or "button_vityaz2_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz3Set",x=76, y=-4, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_3.mdl",z=0, ang=0, var="Vityaz3",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz3_press" or "button_vityaz3_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz6Set",x=76, y=13, w=20,h=20, tooltip = "",model = {
           -- model = "models/metrostroi_train/81-720/vyitaz/v_6.mdl",z=0, ang=0, var="Vityaz6",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz4_press" or "button_vityaz4_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "Vityaz9Set",x=76, y=30, w=20,h=20, tooltip = "",model = {
           -- model = "models/metrostroi_train/81-720/vyitaz/v_9.mdl",z=0, ang=0, var="Vityaz9",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, --sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VityazF5Set",x=40, y=47, w=20,h=20, tooltip = "",model = {
          --  model = "models/metrostroi_train/81-720/vyitaz/v_f5.mdl",z=0, ang=0, var="VityazF5",speed=16,
			sndvol = 1, snd = function(val) return val and "button_vityaz3_press" or "button_vityaz3_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VityazF6Set",x=96, y=-4, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f6.mdl",z=0, ang=0, var="VityazF6",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz2_press" or "button_vityaz2_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VityazF7Set",x=96, y=13, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f7.mdl",z=0, ang=0, var="VityazF7",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz4_press" or "button_vityaz4_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "VityazNextSet",x=96, y=30, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f7.mdl",z=0, ang=0, var="VityazF7",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz4_press" or "button_vityaz4_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "VityazBackSet",x=96, y=47, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f8.mdl",z=0, ang=0, var="VityazF8",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "VityazF9Set",x=76, y=47, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f9.mdl",z=0, ang=0, var="VityazF9",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz2_press" or "button_vityaz2_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		
		{ID = "VityazF8Set",x=80, y=68, w=35,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f8.mdl",z=0, ang=0, var="VityazF8",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "VityazUTVSet",x=1, y=68, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f8.mdl",z=0, ang=0, var="VityazF8",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "VityazTV1Set",x=20, y=68, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f8.mdl",z=0, ang=0, var="VityazF8",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "VityazTV2Set",x=40, y=68, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f8.mdl",z=0, ang=0, var="VityazF8",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
		{ID = "VityazNothSet",x=60, y=68, w=20,h=20, tooltip = "",model = {
            --model = "models/metrostroi_train/81-720/vyitaz/v_f8.mdl",z=0, ang=0, var="VityazF8",speed=16,
            sndvol = 1, snd = function(val) return val and "button_vityaz1_press" or "button_vityaz1_release" end,sndmin = 40, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["BTO"] = {
    pos = Vector(775.12-144,-21,-44), --446 -- 14 -- -0,5
    ang = Angle(0,0,0),
    width = 224,
    height = 50,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "K29Toggle", x=24,  y=26, radius=75, tooltip="", model = {
            model = "models/metrostroi_train/81-720/720_cran.mdl", ang=-90,
            var="K29",speed=4, max=0.28
        }},
        {ID = "UAVAToggle", x=24+200,  y=26, radius=75, tooltip="", model = {
            model = "models/metrostroi_train/81-720/720_cran.mdl", ang=-90,
            plomb = {var="UAVAPl", ID="UAVAPl", },
            var="UAVA",speed=4, max=0.28
        }},
    }
}

ENT.ButtonMap["FrontPneumatic"] = {
    pos = Vector(835-144,-40.0,-44),
    ang = Angle(0,90,90),
    width = 800,
    height = 100,
    scale = 0.1,
    hideseat=0.2,
    hide=true,
    screenHide = true,

    buttons = {
        {ID = "FrontBrakeLineIsolationToggle",x=100, y=0, w=300, h=100, tooltip=""},
        {ID = "FrontTrainLineIsolationToggle",x=500, y=0, w=300, h=100, tooltip=""},
    }
}
ENT.ClientProps["FrontBrake"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(835-144, -17, -53.9), -- (-23) старое значение по Y
    ang = Angle(30,-90,0),
	scale = 0.55,
    hide = 2,
}
ENT.ClientProps["FrontTrain"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(835-144, 17, -53.9), --23 старое значение по Y
    ang = Angle( -30,-90,0),
	scale = 0.55,
    hide = 2,
}
ENT.ClientSounds["FrontBrakeLineIsolation"] = {{"FrontBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["FrontTrainLineIsolation"] = {{"FrontTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}

--Головная часть
ENT.ButtonMap["CabinDoorL"] = {
    pos = Vector(750-153,59.6,55),
    ang = Angle(0,00,94),
    width = 900,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoorLeft",x=0,y=0,w=900,h=2000, tooltip="", model = {
            var="CabinDoorLeft",sndid="door_cab_l",
            sndvol = 0.1, snd = function(_,val) return val == 1 and "door_cab_open" or val == 2 and "door_cab_roll" or val == 0 and "door_cab_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}
ENT.ButtonMap["CabinDoorL2"] = {
    pos = Vector(790-148,60,55),
    ang = Angle(0,180,86),
    width = 900,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoorLeft",x=0,y=0,w=900,h=2000, tooltip="", model = {
            var="CabinDoorLeft",sndid="door_cab_l",
            sndvol = 0.1, snd = function(_,val) return val == 1 and "door_cab_open" or val == 2 and "door_cab_roll" or val == 0 and "door_cab_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}
ENT.ButtonMap["CabinDoorR"] = {
    pos = Vector(790-148,-59.5,52),
    ang = Angle(0,180,94),
    width = 900,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoorRight",x=0,y=0,w=900,h=2000, tooltip="", model = {
            var="CabinDoorRight",sndid="door_cab_r",
            sndvol = 0.1, snd = function(_,val) return val == 1 and "door_cab_open" or val == 2 and "door_cab_roll" or val == 0 and "door_cab_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}
ENT.ButtonMap["CabinDoorR2"] = {
    pos = Vector(750-153,-60,52),
    ang = Angle(0,0,86),
    width = 900,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoorRight",x=0,y=0,w=900,h=2000, tooltip="", model = {
            var="CabinDoorRight",sndid="door_cab_r",
            sndvol = 0.1, snd = function(_,val) return val == 1 and "door_cab_open" or val == 2 and "door_cab_roll" or val == 0 and "door_cab_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}
ENT.ClientProps["lamp_f"] = {
    model = "models/metrostroi_train/81-720/lamp_revers_up.mdl",
    pos = Vector(333.75-144,5.68,21.15),
    ang = Angle(0,0,0),
    hideseat=0.8,
}
ENT.ClientProps["lamp_b"] = {
    model = "models/metrostroi_train/81-720/lamp_revers_down.mdl",
    pos = Vector(333.6-144,5.68,21.15),
    ang = Angle(0,0,0),
    hideseat=0.8,
}

ENT.ClientProps["fireextinguisher"] = {
    model = "models/metrostroi_train/81-502/fireextinguisher.mdl", scale=0.9,
    pos = Vector(446-144,30.1, -0.6),
    ang = Angle(0,0,0),
    hideseat = 0.8,
}
ENT.ClientProps["fireextinguisher2"] = {
    model = "models/metrostroi_train/81-502/fireextinguisher.mdl", scale=0.9,
    pos = Vector(1050.8-144,-220.5, -0.6),
    ang = Angle(0,140,0),
    hideseat = 0.8,
}
--1st april cabin bucket
if os.date( "%m-%d" ) == "04-01" then
ENT.ClientProps["april_bucket"] = {
    model = "models/props_junk/metalbucket01a.mdl",
    pos = Vector(810.8-144,-45.5, -39.6),
    ang = Angle(0,140,0),
    hide = 1,
}
print("happy bucket day!")
end
ENT.ClientProps["AntennaProp"] = {
    model = "models/metrostroi_train/81-740/body/antenna/antenna.mdl",
    pos = Vector(234.25,21.3,-124.5),
    ang = Angle(-6,0,0),
    hide = 2,
}

---Segments
ENT.ClientProps["speed1"] = {
    model = "models/metrostroi_train/81-720/digits/digit.mdl",
    pos = Vector(810.9-144, 17.1+1.495, -1),
    ang = Angle(140,0,0),
    color = Color(20,255,50),
    hideseat = 0.2,
}
ENT.ClientProps["speed2"] = {
    model = "models/metrostroi_train/81-720/digits/digit.mdl",
    pos = Vector(810.9-144, 18, -1),
    ang = Angle(140,0,0),
    color = Color(20,255,50),
    hideseat = 0.2,
}

for i=1,5 do
    ENT.ClientProps["speeddop"..i] = {
        model = "models/metrostroi_train/81-720/segments/speed_red.mdl",
        pos = Vector(205.3, 1.305*(i-1)+3, 102.58),
        ang = Angle(10,0,0.2),
        skin = 0,
        color = Color(255,55,55),
        scale = 0.99,		
        hideseat = 0.8,
    }
    ENT.ClientProps["speedfact"..i] = {
        model = "models/metrostroi_train/81-720/segments/speed_green.mdl",
        pos = Vector(344.58-144, -1.305*(i-1)+2.95, 103.72),
        ang = Angle(10,0,-0.2),
        skin = 0,
        color = Color(90,255,80),
        hideseat = 0.8,
    }
    ENT.ClientProps["speedrek"..i] = {
        model = "models/metrostroi_train/81-720/segments/speed_yellow.mdl",
        pos = Vector(344.420-144, 1.32*(i-1)+2.75, 103.47),
        ang = Angle(10,0,0.3),
        skin = 0,
        color = Color(255,255,60),
        hideseat = 0.8,
    }
end
ENT.ClientProps["brake_cylinder"] = {
    model = "models/metrostroi_train/equipment/arrow_nm.mdl",
    pos = Vector(790.33-144, 58.98, 12.90),
    ang = Angle(-45.000000,0.000000,-270.000000),
    hideseat = 0.2,
}

ENT.ClientProps["train_line"] = {
    model = "models/metrostroi_train/equipment/arrow_nm.mdl",
    pos = Vector(790.33-144,58.57,20.10),
    ang = Angle(-40.000000,0.000000,-270.000000),
    hideseat = 0.2,
}

ENT.ClientProps["brake_line"] = {
    model = "models/metrostroi_train/equipment/arrow_tm.mdl",
    pos = Vector(790.33-144, 58.54, 20.10),
    ang = Angle(-40.000000,0.000000,-270.000000),
    hideseat = 0.2,
}

--Вольтаж
ENT.ClientProps["volt_hv"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(817.91-144,48.90,19.8),
    ang = Angle(37.156513,-80,108),
    hideseat = 0.2,
	scale = 1,
}--1,0.733
ENT.ClientProps["volt_rail_case"] = {
    model = "models/metrostroi_train/81-740/cabine/electric/voltm.mdl",
    pos = Vector(817.65-144,47.9,21),
    ang = Angle(-16.8,0,0),
    hideseat = 0.2,
}--1,0.712

ENT.ClientProps["amp_i13"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(819.1-144,48.90,15.8),
    ang = Angle(40.156513,-79.4,108.8),
    hideseat = 0.2,
	scale = 1,	
}--1,0.722

ENT.ClientProps["amp_engine_case"] = {
    model = "models/metrostroi_train/81-740/cabine/electric/amperm.mdl",
    pos = Vector(818.85-144,47.9,17),
    ang = Angle(-16.3,-0.5,0),
    hideseat = 0.2,
}--1,0.712

---Доп. модели
ENT.ClientProps["PPZpanel"] = {
    model = "models/metrostroi_train/81-740/cabine/electric/paneltex.mdl",
    pos = Vector(735.5-144,50,50),
    ang = Angle(180,270,0),
    scale = 1,
	hide = 2,
}
--ИГЛА

ENT.ClientProps["PPZpanel_IGLA"] = {
    model = "models/metrostroi_train/81-740/cabine/electric/IGLA.mdl",
    pos = Vector(735.4-144,38,40.5),
    ang = Angle(0,180,0),
    scale = 1,
    hide = 2,
}

ENT.ClientProps["manometresp"] = {
    model = "models/metrostroi_train/81-740/cabine/monometres.mdl",
    pos = Vector(792-144,58.3,15),
    ang = Angle(0,0,2),
    scale = 1,
    hide = 1,
}

ENT.ClientProps["vityazpanel"] = {
    model = "models/metrostroi_train/81-740/cabine/cralix/vityazpanel.mdl",
    pos = Vector(465-144,1.5,0),
    ang = Angle(0,0,0),
    scale = 1,
    hide = 1,
}

ENT.ClientProps["redlights740up1"] = {
    model = "models/metrostroi_train/81-740/body/cralix/headlights81-740up.mdl",
    pos = Vector(464.2-144,0,-0.7),
    ang = Angle(0,0,0),
    scale = 1.01,
    nohide=true,
}
ENT.ClientProps["redlights740up2"] = {
    model = "models/metrostroi_train/81-740/body/cralix/headlights81-740up.mdl",
    pos = Vector(464.2-144,-80,-0.7),
    ang = Angle(0,0,0),
    scale = 1.01,
    nohide=true,
}

ENT.ClientProps["redlights740down1"] = {
    model = "models/metrostroi_train/81-740/body/cralix/headlights81-740down.mdl",
    pos = Vector(468-144.55,0,0),
    ang = Angle(0,0,0),
    scale = 1,
    nohide=true,
}
ENT.ClientProps["redlights740down2"] = {
    model = "models/metrostroi_train/81-740/body/cralix/headlights81-740down.mdl",
    pos = Vector(468-144.55,-83.1,0),
    ang = Angle(0,0,0),
    scale = 1,
    nohide=true,
}
ENT.ClientProps["EmergencyBrakeValve"] = {
	model = "models/metrostroi_train/81-740/cabine/StopKran.mdl",
	pos = Vector(1197-144,-58.8,2),--Vector(455,-55.2,26),
	ang = Angle(0,180,2),
	hide = 2,
}
ENT.ClientProps["stopkran"] = {
    model = "models/metrostroi_train/81-717/stop_mvm.mdl",
    pos = Vector(788.5-144,-59.7,13.2),
    ang = Angle(0,180,2),
	hide = 2,
}
ENT.ButtonMap["GV"] = {
    pos = Vector(222,50,-82),
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
    pos = Vector(366-144,55,-76),
    ang = Angle(-90,90,-90),
    color = Color(150,255,255),
    hideseat = 0.2,
}

ENT.ClientProps["gv_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ClientProps["gv"].pos,
    ang = Angle(-90,90,-90),
    hideseat = 0.2,
}
ENT.ClientProps["door_cab_m"] = {
    model = "", --models/metrostroi_train/81-720/720_door_cab.mdl
    pos = Vector(374.9-144,-45.5+25.5,-12.3),
    ang = Angle(0,-90-1,0)
}
ENT.ClientProps["door_cab_o"] = {
    model = "", --models/metrostroi_train/81-720/720_cab_otsek.mdl
    pos = Vector(374.9-144,26,-15),
    ang = Angle(0,-90+0.45,-0.15)
}
ENT.ClientProps["KRO"] = {
    model = "models/metrostroi_train/81-740/cabine/pult/tum_r.mdl",
    pos = Vector(805.2-144,48.2,-4.8),
    ang = Angle(150,0,180),
    hideseat = 0.2,
}
ENT.ClientProps["KRR"] = {
    model = "models/metrostroi_train/81-740/cabine/pult/tum_r_rad.mdl",
    pos = Vector(802-144,48.2,-6.7),
    ang = Angle(150,0,180),
    hideseat = 0.2,
}
ENT.ClientProps["controller"] = {
    model = "models/metrostroi_train/81-720/720_kv.mdl",
    pos = Vector(796.4-144,24.2,-6.4),
    ang = Angle(0.000000,-90.000000,23.699429),
    hideseat = 0.2,
	scale = 0.8,
}

ENT.ClientProps["km013"] = {
    model = "models/metrostroi_train/81-720/720_km013.mdl",
    pos = Vector(780-144,-8,-25.3),
    ang = Angle(180,90,-110),
    hideseat = 0.2,
}
if not ENT.ClientSounds["br_013"] then ENT.ClientSounds["br_013"] = {} end
table.insert(ENT.ClientSounds["br_013"],{"km013",function(ent,_,var) return "br_013" end,1,1,50,1e3,Angle(-90,0,0)})

ENT.ClientProps["PB"] = {
    model = "models/metrostroi_train/81-720/720_pb.mdl",
    pos = Vector(810.138672-144,35.572510,-30),
    ang = Angle(0.000000,-90.000000,0.000000),
    hideseat = 0.2,
}
if not ENT.ClientSounds["PB"] then ENT.ClientSounds["PB"] = {} end
table.insert(ENT.ClientSounds["PB"],{"PB",function(ent,var) return var > 0 and "pb_on" or "pb_off" end,1,1,30,1e3,Angle(-90,0,0)})

ENT.ClientProps["Pult"] = {
	model = "models/metrostroi_train/81-740/cabine/Pult/pult.mdl",
	pos = Vector(465.4-144, 6, 0),
	ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["bucik_old"] = {
	model = "models/metrostroi_train/81-740/cabine/Pult/bucik.mdl",
	pos = Vector(465.4-144, 6, 0),
	ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["salon"] = {
	model = "models/metrostroi_train/81-740/salon/salon.mdl",
	pos = Vector(0,0,0),
	ang = Angle(0,0,0),
	hide = 2,
}
ENT.ClientProps["handrails"] = {
	model = "models/metrostroi_train/81-740/salon/handrails/handrails.mdl",
	pos = Vector(368-146,-5,0),
	ang = Angle(0,0,0),
	hide = 2,
}	
ENT.ClientProps["door_cab_r"] = {
	model = "models/metrostroi_train/81-740/cabine/cabin_right.mdl",
	pos = Vector(766-144.7, -66.5,0),
	ang = Angle(0,90,0.55),
	scale = 1.001,		
	hide = 2,
}
ENT.ClientProps["door_cab_l"] = {
	model = "models/metrostroi_train/81-740/cabine/cabin_left.mdl",
	pos = Vector(765-144.45, 62.29, 0),
	ang = Angle(0,-90,0.25),
	scale = 1.01,
	hide = 2,
}

--Новые модели 2023.
ENT.ClientProps["Zavod_table_front"] = { --Заводская табличка
    model = "models/metrostroi_train/81-740/salon/zavod.mdl",
	pos = Vector(543.2,15,60),
    ang = Angle(90,-180,0),
	hide = 1,
	scale = 3,	
}
ENT.ClientProps["ASNP_test"] = {
	model = "models/metrostroi_train/81-740/cabine/asnp.mdl",
	pos = Vector(674.5,-51,-8),
	ang = Angle(0,100,0),
	hide = 1,
}
ENT.ClientProps["Gerb_msk"] = {
	model = "models/metrostroi_train/81-740/body/gerb.mdl",
	pos = Vector(565,62.6,35),
	ang = Angle(0,0,-86.8),
	nohide = true,
	scale = 3,
}
ENT.ClientProps["Gerb_msk_right"] = {
	model = "models/metrostroi_train/81-740/body/gerb.mdl",
	pos = Vector(565,-62.6,36),
	ang = Angle(0,180,-86.8),
	nohide = true,
	scale = 3,
}
ENT.ClientProps["Naddver_off"] = {
	model = "models/metrostroi_train/81-740/salon/naddverka_off.mdl",
	pos = Vector(314.75,37.38,58.1),
	ang = Angle(0,0,0),
	scale = 1,	
	nohide = true,
}
--[[for i=1,31 do
    ENT.ClientProps["led_l_f"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1.99)*1.425+289.25-144, -11.5, 13.5),
        ang = Angle(0,0,0),
        skin=6,
		scale = 1.01,		
		hide = 0.49,
    }
    ENT.ClientProps["led_l_f_ob"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1.99)*1.425+289.25-144, -11.5, 13.5),
        ang = Angle(0,0,0),
        skin=6,
		scale = 1.01,		
        hide = 0.49,
    }	
end
for i=1,29 do
ENT.ClientProps["led_l_r"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1.99)*1.45+626.1-144, -11.5, 13.5),
        ang = Angle(0,0,0),
        skin=6,
        hide = 2,
		scale = 1.01,			
    }		
    ENT.ClientProps["led_right_f"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_r.mdl",
        pos = Vector(-(i-1.99)*1.44+631.6-144, -86.1, 13.5),
        ang = Angle(0,0,0),
        skin=6,
		scale = 1.01,		
        hide = 2,
    }
    ENT.ClientProps["led_right1_f"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_r.mdl",
        pos = Vector(-(i-1.99)*1.442+299.2-144, -86.1, 13.5),
        ang = Angle(0,0,0),
        skin=6,
		scale = 1.01,		
        hide = 2,
    }
    ENT.ClientProps["led_right1_f_ob"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_r.mdl",
        pos = Vector(-(i-1.99)*1.442+299.2-144, -86.1, 13.5),
        ang = Angle(0,0,0),
        skin=6,
		scale = 1.01,		
        hide = 2,	
	}
    ENT.ClientProps["led_right_f_ob"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_r.mdl",
        pos = Vector(-(i-1.99)*1.44+631.6-144, -86.1, 13.5),
        ang = Angle(0,0,0),
        skin=6,
		scale = 1.01,		
        hide = 2,
    }	
	ENT.ClientProps["led_l_r_ob"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1.99)*1.45+626.1-144, -11.5, 13.5),
        ang = Angle(0,0,0),
        skin=6,
        hide = 1.5,
		scale = 1.01,			
    }		
end]]

ENT.ButtonMap["Antenna"] = {
    pos = Vector(835-146,-7.5,-19.5),
    ang = Angle(0,90,84),
    width = 240,
    height = 150,
    scale = 0.0625,
    hideseat=0.2,
	
	buttons = {
        {ID = "Antenna",x=0,y=0,w=240,h=150,tooltip="Установить/снять антенну",},
    }
}

--[[for i=1,32 do
ENT.ClientProps["led_l_f_rear"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1.99)*1.425+402.2-144, 11.7, 12.6),
        ang = Angle(0,180,0),
        skin=6,
		scale = 1.01,		
        hide = 0.49,
		callback = function(ent,cl_ent)
        if cl_ent:GetParent() == ent:GetNW2Entity("gmod_subway_kuzov") then return end
			cl_ent:SetParent(ent:GetNW2Entity("gmod_subway_kuzov"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_f_rear"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_f_rear"..i].ang)
    end,      
}
ENT.ClientProps["led_l_f_rear_ob"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1.99)*1.425+402.2-144, 11.7, 12.6),
        ang = Angle(0,180,0),
        skin=6,
		scale = 1.01,		
        hide = 0.49,
		callback = function(ent,cl_ent)
        if cl_ent:GetParent() == ent:GetNW2Entity("gmod_subway_kuzov") then return end
			cl_ent:SetParent(ent:GetNW2Entity("gmod_subway_kuzov"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_f_rear"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_f_rear"..i].ang)
    end,      
}

ENT.ClientProps["led_l_f2_rear"..i] = { --3 дверь задняя секция право
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1.99)*1.425-62.2-144, 11.18, 13),
        ang = Angle(0,180,0),
        skin=6,
        hide = 0.49,
		callback = function(ent,cl_ent)
        if cl_ent:GetParent() == ent:GetNW2Entity("gmod_subway_kuzov") then return end
			cl_ent:SetParent(ent:GetNW2Entity("gmod_subway_kuzov"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_f2_rear"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_f2_rear"..i	].ang)
    end,      
}
ENT.ClientProps["led_l_f2_rear_ob"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1.99)*1.425-62.2-144, 11.18, 13),
        ang = Angle(0,180,0),
        skin=6,
        hide = 0.49,
		callback = function(ent,cl_ent)
        if cl_ent:GetParent() == ent:GetNW2Entity("gmod_subway_kuzov") then return end
			cl_ent:SetParent(ent:GetNW2Entity("gmod_subway_kuzov"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_f2_rear"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_f2_rear"..i	].ang)
    end,      
}
ENT.ClientProps["led_l_zad1_l"..i] = { --1 дверь задняя секция
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1.99)*1.425+351-144, -11.9, 12.6),
        ang = Angle(0,0,0),
        skin=6,
		scale = 1.01,		
        hide = 0.49,
		callback = function(ent,cl_ent)
        if cl_ent:GetParent() == ent:GetNW2Entity("gmod_subway_kuzov") then return end
			cl_ent:SetParent(ent:GetNW2Entity("gmod_subway_kuzov"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_zad1_l"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_zad1_l"..i	].ang)
    end,      
}
ENT.ClientProps["led_l_zad1_l_ob"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1.99)*1.425+351-144, -11.9, 12.6),
        ang = Angle(0,0,0),
        skin=6,
		scale = 1.01,		
        hide = 0.49,
		callback = function(ent,cl_ent)
        if cl_ent:GetParent() == ent:GetNW2Entity("gmod_subway_kuzov") then return end
			cl_ent:SetParent(ent:GetNW2Entity("gmod_subway_kuzov"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_zad1_l"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_zad1_l"..i	].ang)
    end,      
}
ENT.ClientProps["led_l_zad3_l"..i] = { --3 дверь задняя секция лево
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1.99)*1.428-113.11-144, -11.78, 12.6),
        ang = Angle(0,0,0),
        skin=6,
		scale = 1.01,		
        hide = 0.49,
		callback = function(ent,cl_ent)
        if cl_ent:GetParent() == ent:GetNW2Entity("gmod_subway_kuzov") then return end
			cl_ent:SetParent(ent:GetNW2Entity("gmod_subway_kuzov"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_zad3_l"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_zad3_l"..i	].ang)
    end,      
}
ENT.ClientProps["led_l_zad3_l_ob"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1.99)*1.428-113.11-144, -11.78, 12.6),
        ang = Angle(0,0,0),
        skin=6,
		scale = 1.01,		
        hide = 0.49,
		callback = function(ent,cl_ent)
        if cl_ent:GetParent() == ent:GetNW2Entity("gmod_subway_kuzov") then return end
			cl_ent:SetParent(ent:GetNW2Entity("gmod_subway_kuzov"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_zad3_l"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_zad3_l"..i	].ang)
    end,      
}
end

for i=1,31 do
ENT.ClientProps["led_l_zad2_l"..i] = { --2 дверь лево задняя секция
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1.99)*1.435+118.2-144, -11.78, 12.6),
        ang = Angle(0,0,0),
        skin=6,
		scale = 1.01,		
        hide = 0.49,
		callback = function(ent,cl_ent)
        if cl_ent:GetParent() == ent:GetNW2Entity("gmod_subway_kuzov") then return end
			cl_ent:SetParent(ent:GetNW2Entity("gmod_subway_kuzov"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_zad2_l"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_zad2_l"..i	].ang)
    end,      
} 
ENT.ClientProps["led_l_zad2_l_ob"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1.99)*1.435+118.2-144, -11.78, 12.6),
        ang = Angle(0,0,0),
        skin=6,
		scale = 1.01,		
        hide = 0.49,
		callback = function(ent,cl_ent)
        if cl_ent:GetParent() == ent:GetNW2Entity("gmod_subway_kuzov") then return end
			cl_ent:SetParent(ent:GetNW2Entity("gmod_subway_kuzov"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_zad2_l_ob"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_zad2_l_ob"..i	].ang)
    end,      
} 
end

for i=1,29 do
ENT.ClientProps["led_l_f1_rear"..i] = { --2 дверь право задняя секция
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1.99)*1.44+171.55-144, 11.18, 13),
        ang = Angle(0,180,0),
        skin=6,
        hide = 0.49,
		callback = function(ent,cl_ent)
        if cl_ent:GetParent() == ent:GetNW2Entity("gmod_subway_kuzov") then return end
			cl_ent:SetParent(ent:GetNW2Entity("gmod_subway_kuzov"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_f1_rear"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_f1_rear"..i	].ang)
    end,      
}
ENT.ClientProps["led_l_f1_rear_ob"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l.mdl",
        pos = Vector(-(i-1.99)*1.44+171.55-144, 11.18, 13),
        ang = Angle(0,180,0),
        skin=6,
        hide = 0.49,
		callback = function(ent,cl_ent)
        if cl_ent:GetParent() == ent:GetNW2Entity("gmod_subway_kuzov") then return end
			cl_ent:SetParent(ent:GetNW2Entity("gmod_subway_kuzov"))
			cl_ent:SetLocalPos(ent.ClientProps["led_l_f1_rear_ob"..i].pos)
			cl_ent:SetLocalAngles(ent.ClientProps["led_l_f1_rear_ob"..i	].ang)
    end,      
}
end]]
local yventpos = {
    -414.5+0*117-144,
	-414.5+1*117+6.2-144,
	414.5+2*117+5-144,
	414.5+3*117+2-144,
	414.5+4*117+0.5-144,
	-414.5+5*117-2.3-144,
	-414.5+6*117-144,
}

ENT.ButtonMap["CAMS"] = {
    pos = Vector(809.2-144.11,52.37,10.58),
    ang = Angle(0,-57.7,90),
    width = 0,
    height = 0,
    scale = 0.012,
	system = "CAMS",
	hide=0.5,
}
ENT.ButtonMap["Vityaz"] = {
	pos = Vector(816-144, -6.3, 11.8),
    ang = Angle(0,-122.4,90),
    width = 0,
    height = 0,
    scale = 0.007,    
	hide=0.5,
}
 ENT.Lights = {
    [1] = { "headlight",	Vector(690,0,-35), Angle(0,0,0), Color(216,161,92), farz=5144,brightness = 4, hfov=105,vfov=105, texture = "models/metrostroi_train/equipment/headlight",shadows = 1,headlight=true}, --Фары 324.8-144.5, 72.8, -58.2
    [2] = { "headlight",    Vector(968-144,0,50), Angle(-1,0,0), Color(255,0,0), fov=170 ,brightness = 0.3, farz=450,texture = "models/metrostroi_train/equipment/headlight2",shadows = 0,backlight=true}, --Красные фары 
    [3] = { "headlight",    Vector(358-144,40,43.9), Angle(50,40,-0), Color(206,135,80), fov=100,farz=200,brightness = 0,shadows=1}, --отсеки
}

for k=0,3 do
    ENT.ClientProps["TrainNumberR"..k] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(705-k*6.6+4*6.6/2-144, -63.9, 14),
        ang = Angle(0,0,-3.29),
		hide = 1,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    } 	 	  
end

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.Vityaz = self:CreateRT("740Vityaz",1000,1024)
	self.ASNP = self:CreateRT("740ASNP",512,128)
	self.IGLA = self:CreateRT("740IGLA",512,128)
    self.Tickers = self:CreateRT("740Ticker",1024,64)
    render.PushRenderTarget(self.Tickers,0,0,1024, 64)
    render.Clear(0, 0, 0, 0)
    render.PopRenderTarget()
	self.CAMS = self:CreateRT("740CAMS",1024,768)
    self.ReleasedPdT = 0
    self.CraneRamp = 0
    self.CraneRRamp = 0
    self.ReleasedPdT = 0
	
	self.HeadLightBroken1 = false
	self.HeadLightBroken2 = false
	self.HeadLightBroken3 = false
	self.HeadLightBroken4 = false
	
	self.RedLightBroken1 = false
	self.RedLightBroken2 = false
	self.RedLightBroken3 = false
	self.RedLightBroken4 = false	
	
	self.EmergencyValveRamp = 0
	self.StopKranValveRamp = 0
	self.EmergencyValveEPKRamp = 0
	self.EmergencyBrakeValveRamp = 0
    self.FrontLeak = 0
    self.RearLeak = 0

    self.ParkingBrake = 0

    self.PreviousRingState = false
    self.PreviousCompressorState = false
    self.TISUVol = 0

    self.VentRand = {}
    self.VentState = {}
    self.VentVol = {}
    for i=1,7 do
        self.VentRand[i] = math.Rand(0.5,2)
        self.VentState[i] = 0
        self.VentVol[i] = 0
    end
	
	self.FrontBogey = self:GetNW2Entity("FrontBogey")	
	self.RearBogey = self:GetNW2Entity("RearBogey")
	
	self.PassengerEnts = {}
	
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
	
local Cpos = {
    0,0.24,0.5,0.55,0.6,1
}

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
    bogey.SoundNames["brake_squeal1"]       = "subway_trains/rusich/bogey/skrip1_"..skr..".wav"
    bogey.SoundNames["brake_squeal2"]       = "subway_trains/rusich/bogey/skrip2_"..skripit..".wav"
	
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

function ENT:Think()
    self.BaseClass.Think(self)
	
	local refresh = false--true		
	if self:GetNW2Int("MotorType")==1 then		
		if IsValid(self.FrontBogey) and self.FrontBogey.SoundNames and (self.FrontBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines/engine_8.wav" 
	or self.FrontBogey.EngineSNDConfig and self.FrontBogey.EngineSNDConfig[1] and self.FrontBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.FrontBogey)
	end
	if IsValid(self.MiddleBogey) and self.MiddleBogey.SoundNames and (self.MiddleBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines/engine_8.wav" 
	or self.MiddleBogey.EngineSNDConfig and self.MiddleBogey.EngineSNDConfig[1] and self.MiddleBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.MiddleBogey)
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
	if IsValid(self.MiddleBogey) and self.MiddleBogey.SoundNames and (self.MiddleBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines_new/engine_8.wav" 
	or self.MiddleBogey.EngineSNDConfig and self.MiddleBogey.EngineSNDConfig[1] and self.MiddleBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.MiddleBogey)
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
	if IsValid(self.MiddleBogey) and self.MiddleBogey.SoundNames and (self.MiddleBogey.SoundNames["ted1_740"] ~= "subway_trains/bogey/engines/720/speed_8.wav" 
	or self.MiddleBogey.EngineSNDConfig and self.MiddleBogey.EngineSNDConfig[1] and self.MiddleBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.MiddleBogey)
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
	if IsValid(self.MiddleBogey) and self.MiddleBogey.SoundNames and (self.MiddleBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines_new_1/engine_8.wav" 
	or self.MiddleBogey.EngineSNDConfig and self.MiddleBogey.EngineSNDConfig[1] and self.MiddleBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.MiddleBogey)
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
	if IsValid(self.MiddleBogey) and self.MiddleBogey.SoundNames and (self.MiddleBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines_1/engine_8.wav" 
	or self.MiddleBogey.EngineSNDConfig and self.MiddleBogey.EngineSNDConfig[1] and self.MiddleBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.MiddleBogey)
	end		
	if IsValid(self.RearBogey) and self.RearBogey.SoundNames and (self.RearBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines_1/engine_8.wav" 
	or self.RearBogey.EngineSNDConfig and self.RearBogey.EngineSNDConfig[1] and self.RearBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.RearBogey)
	end	
end	

--Генерация пропов для задней секции.
local Pricep740 = self:GetNW2Entity("gmod_subway_kuzov")
if IsValid(Pricep740) then
if not Pricep740.ButtonMap then
Pricep740.ButtonMap = {}
Pricep740.ClientProps = {}
Pricep740.ClientSounds = {}
Pricep740.AutoAnims = {}

Pricep740.ClientProps["salonR"] = {
	model = "models/metrostroi_train/81-740/salon/salon_rear.mdl",
    pos = Vector(-211.2, 0, 5.5),
    ang = Angle(0,180,0),
	hide = 2, 	
}
--Новые модели 2023
Pricep740.ClientProps["Zavod_table_sochl"] = { 
    model = "models/metrostroi_train/81-740/salon/zavod.mdl",
	pos = Vector(287.2,44,48),
    ang = Angle(90,-180,0),
	scale = 3,
	hide = 1,		
}
Pricep740.ClientProps["Zavod_table_sochl_torec"] = { 
    model = "models/metrostroi_train/81-740/salon/zavod.mdl",
	pos = Vector(-332.4,-20,59),
    ang = Angle(90,0,0),
	scale = 3,
	hide = 1, 	
}
Pricep740.ClientProps["Naddver_off_740"] = { 
    model = "models/metrostroi_train/81-740/salon/naddverka_off_740.mdl",
	pos = Vector(-15.8,-37.15,57.1),
    ang = Angle(0,0,0),
	scale = 1,	
}
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
	hide = 2,	
}
Pricep740.ClientSounds["RearBrakeLineIsolation"] = {{"RearBrake",function() return "disconnect_valve_740" end,1,1,50,1e3,Angle(-90,0,0)}}
Pricep740.ClientSounds["RearTrainLineIsolation"] = {{"RearTrain",function() return "disconnect_valve_740" end,1,1,50,1e3,Angle(-90,0,0)}}
	
Pricep740.ClientProps["krepezh1"] = {
    model = "models/metrostroi_train/81-740/body/krepezh.mdl",
    pos = Vector(64.5, 0, -75.2),
    ang = Angle(0,180,0), 
	nohide = true,   	  
}
Pricep740.ClientProps["lamps_salon_on_rear_avar1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(-252.75, 0.3, -74.885),
    ang = Angle(0,180,0),
    color = Color(245,238,223),
	hide = 1,     	 
}
Pricep740.ClientProps["lamps_salon_on_rear_avar2"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(286.15, -57.8, -74.88),
    ang = Angle(0,180,0),
    color = Color(245,238,223),
}

for i = 1,11 do
Pricep740.ClientProps["lamps_salon_on_rear"..i] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(341.5-54*i+1,0.29,-74.88),
    ang = Angle(0,180,0),
    color = Color(245,238,223),	
	hide = 1,  	
}
--правый ряд НЕ ТРОГАТЬ!!!!
Pricep740.ClientProps["lamps_salon_on_rear1"..i] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(341.5-54*i+1,-57.78,-74.88),
    ang = Angle(0,180,0),
    color = Color(245,238,223),
	hide = 1, 	   
}
end
Pricep740.ClientProps["handrails_offside"] = {
    model = "models/metrostroi_train/81-740/body/740_body_additional.mdl",
    pos = Vector(21.8, 10, -76.5),
    ang = Angle(0,180,0),   
	nohide = true,	
}
Pricep740.ClientProps["lamps_salon_off_r"] = {
    model = "models/metrostroi_train/81-740/salon/lamps/lamps_off_rear.mdl",
    pos = Vector(-120.1, 0.1, -75.15),
    ang = Angle(0,180,0), 
	hide = 2,		
}
Pricep740.ClientProps["handrails_rear"] = {
	model = "models/metrostroi_train/81-740/salon/handrails/handrails_r.mdl",
    pos = Vector(-115.5, -1, -73),
    ang = Angle(0,180,0),
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
		pos = Vector(286.2,27,65.85), --446 -- 14 -- -0,5
		ang = Angle(0,-90,90),
		width = 1024,
		height = 64,
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

Pricep740.ClientProps["door_cab_t"] = {
	model = "models/metrostroi_train/81-740/salon/door_br.mdl",
	pos = Vector(-334.5, 15, 8.8),
	ang = Angle(0,180,0),
	hide = 2, 	
}
for k=0,3 do
Pricep740.ClientProps["TrainNumberL"..k] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(-310+k*6.6-4*6.6/2, 63.4, 18),
        ang = Angle(0,180,-3.29),
        hide = 1,
        callback = function(Pricep740)
            self.WagonNumber = false 
		end,
    } 
end	

function self:UpdateWagonNumber()
for k=0,3 do
        --if i< count then			
			if self.WagonNumber then		
            local leftNum = Pricep740.ClientEnts["TrainNumberL"..k]	
	        local num = math.floor(self.WagonNumber%(10^(k+1))/10^k)										
            if IsValid(leftNum) then	
                leftNum:SetLocalPos(Vector(-310+k*6.6-4*6.6/2, 63.4, 18))
                leftNum:SetSkin(num)		
				end	
            end  			
            local rightNum = self.ClientEnts["TrainNumberR"..k]		
	        local num = math.floor(self.WagonNumber%(10^(k+1))/10^k)
            if IsValid(rightNum) then
				rightNum:SetPos(self:LocalToWorld(Vector(705-k*6.6+4*6.6/2-144, -63.9, 14)))
                rightNum:SetSkin(num)
            end											
			self.HeadLightBroken1 = self:GetNW2Bool("HeadLightBroken1",false)
			self.HeadLightBroken2 = self:GetNW2Bool("HeadLightBroken2",false)
			self.HeadLightBroken3 = self:GetNW2Bool("HeadLightBroken3",false)
			self.HeadLightBroken4 = self:GetNW2Bool("HeadLightBroken4",false)
			 
			self.RedLightBroken1 = self:GetNW2Bool("RedLightBroken1",false)
			self.RedLightBroken2 = self:GetNW2Bool("RedLightBroken2",false)
			self.RedLightBroken3 = self:GetNW2Bool("RedLightBroken3",false)
			self.RedLightBroken4 = self:GetNW2Bool("RedLightBroken4",false)			
            end   		
		end	
	if not IsValid(self.RearBogey) then
		self.RearBogey = self:GetNW2Entity("RearBogey")		
	end
	if not IsValid(self.FrontBogey) then
		self.FrontBogey = self:GetNW2Entity("FrontBogey")
	end		
end	
local function GetDoorPositionRear(n,G,j)
	if j == 0 			--	x						--	y        --	z
	then return Vector(195.5 - -35.0*G - 232.1*n, -66*(1-2*G), 4.3)
	else return Vector(265.6 - 35.0*(1+G) - 232.1*n,-67.5*(1-2*G),4.3)
	end
end

for n=0,2 do
	for G=0,1 do
		Pricep740.ClientProps["door"..n.."x"..G.."a1"] = {
			model =  "models/metrostroi_train/81-740/body/81-740_leftdoor1.mdl",
			pos = GetDoorPositionRear(n,G,0),
			ang = Angle(0,90 +180*G,0), 
			hide = 2,				
			scale = 1.001,			    			
		}
		Pricep740.ClientProps["door"..n.."x"..G.."b1"] = {
			model =  "models/metrostroi_train/81-740/body/81-740_leftdoor2.mdl",
			pos = GetDoorPositionRear(n,G,1),
			ang = Angle(0,90 +180*G,0),
			hide = 2,					
			scale = 1.001,		  			
		}
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
--
-- Add doors
--
local function GetDoorPosition(n,G,j)
	if j == 0 		--Правые двери			--Левые двери
	then return Vector(651.5  - 35.0*G     -  338.8*n-144, -67.5*(1-2*G), 4.3)
	else return Vector(651.5  - 35.0*(1-G) -  338.8*n-144, -66*(1-2*G), 4.25)
	end
end 

for n=0,1 do
    for G=0,1 do
        self.ClientProps["door"..n.."x"..G.."a"] = {
			model = "models/metrostroi_train/81-740/body/81-740_leftdoor2.mdl",
			pos = GetDoorPosition(n,G,0),
			ang = Angle(0,90 +180*G,0),
			scale = 1.001,			
			hide = 2,
		}
		self.ClientProps["door"..n.."x"..G.."b"] = {
			model = "models/metrostroi_train/81-740/body/81-740_leftdoor1.mdl",
			pos = GetDoorPosition(n,G,1),
			ang = Angle(0,90 +180*G,0),
			scale = 1.001,			
			hide = 2,				
		}
    end
end

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
                ent:SetParent()				
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
                ent:SetLocalPos(ENT:LocalToWorld(pos))--ent:SetLocalPos(self:LocalToWorld(pos)) 
				ent:ResetSequence(table.Random(model:find("female",1,true) and female_sequences or male_sequences))				
                ent:SetAngles(ENT:GetAngles()+Angle(0,180,0))
                ent:SetParent(ENT)				
                table.insert(self.PassengerPositionsCustom,pos)
                table.insert(self.PassengerEntsRearCustom,ent)
				end
            end
        end
    end]]
end	
	
--Задняя часть
	 self:SetLightPower(3,self.Door5 and self:GetPackedBool("AppLights"),self:GetPackedBool("AppLights") and 1 or 0)
    --ANIMS
    self:Animate("brake_line", self:GetPackedRatio("BL"), 0, 0.753,  256,2)
    self:Animate("train_line", self:GetPackedRatio("TL"),   0, 0.753,  4096,2)
    self:Animate("brake_cylinder", self:GetPackedRatio("BC"), 0, 0.746,  64,12)
	
    self:SetSoundState("ring_vityaz",self:GetPackedBool("BUKPRing",false) and 1.6 or 0,1)
    self:SetSoundState("ring_cams",self:GetPackedBool("CAMSRing",false) and 1.6 or 0,1)
	
	--Вольтаж
    self:Animate("volt_hv",self:GetPackedRatio("HV"),1.0,0.722,94,4)
    self:Animate("amp_i13",self:GetPackedRatio("I13"),1,0.722,92,2)

    self:Animate("controller", (self:GetPackedRatio("Controller")+4)/8, 0, 0.425,  2.5,false)

    self:Animate("FrontBrake", self:GetNW2Bool("FbI") and 0 or 1,0,1, 3, false)
    self:Animate("FrontTrain",  self:GetNW2Bool("FtI") and 1 or 0,0,1, 3, false)
	
    Pricep740:Animate("RearBrake",   self:GetNW2Bool("RbI") and 0 or 1,0,1, 3, false)
    Pricep740:Animate("RearTrain",   self:GetNW2Bool("RtI") and 1 or 0,0,1, 3, false)

    if self.LastGVValue ~= self:GetPackedBool("GV") then
        self.ResetTime = CurTime()+1.5
        self.LastGVValue = self:GetPackedBool("GV")
    end
    self:Animate("gv_wrench",self.LastGVValue and 1 or 0,0.5,1,128,1,false)
    self:ShowHideSmooth("gv_wrench",    CurTime() < self.ResetTime and 1 or 0.1)
	
	self.HeadTrain = self:GetNW2Entity("HeadTrain")	
    local train = self.HeadTrain		
	
	local dT = self.DeltaTime
	
    local dPdT = self:GetPackedRatio("BrakeCylinderPressure_dPdT")
    self.ReleasedPdT = math.Clamp(self.ReleasedPdT + 4*(-self:GetPackedRatio("BrakeCylinderPressure_dPdT",0)-self.ReleasedPdT)*dT,0,1)
    self:SetSoundState("release",math.Clamp(self.ReleasedPdT,0,1)^1.65,1.0)	

    self:Animate("KRO", self:GetPackedRatio("KRO",0), 0.525, 1,  4,false)
    self:Animate("KRR", self:GetPackedRatio("KRR",0), 0.525, 1,  4,false)
    self:Animate("km013", Cpos[self:GetPackedRatio("Cran")] or 0, 0, 0.7,  2,false)
    self:Animate("PB",  self:GetPackedBool("PB") and 1 or 0,0,0.2,  8,false)
	
    if IsValid(ENT) and IsValid(MiddleBogey) then
        --print(MiddleBogey:GetAngles())
		--Fence:ManipulateBoneAngles(0,Fence:WorldToLocalAngles(Angle(MiddleBogey:GetAngles().y-90,-MiddleBogey:GetAngles().z,MiddleBogey:GetAngles().z)))
		--Fence:ManipulateBonePosition(0,Vector(0,0,-68))		 
        --Fence:SetParent(MiddleBogey)
    end
	
	self:ShowHide("AntennaProp",not self:GetNW2Bool("Antenna"))
	
	local ZavodTable = self:GetNW2Int("ZavodTable",1)	
    self:ShowHide("Zavod_table_front",ZavodTable==1)	
    Pricep740:ShowHide("Zavod_table_sochl",ZavodTable==2)
    Pricep740:ShowHide("Zavod_table_sochl_torec",ZavodTable==3)	
	local animation = math.random (5,12)	
	local animation1 = math.random (0.5,1)	
	
	--Головная часть	
for avar = 1,2 do
	--Головная часть
    local colV = self:GetNW2Vector("Lamp7404"..avar)
    local col = Color(colV.x,colV.y,colV.z)	
	self:ShowHideSmooth("lamps_salon_on_avar"..avar,self:Animate("LampsEmer",self:GetPackedRatio("SalonLighting") == 0.4 and 1 or 0,0,animation1,animation,false),col)  
	--Задняя часть
	Pricep740:ShowHideSmooth("lamps_salon_on_rear_avar"..avar,self:Animate("LampsEmer",self:GetPackedRatio("SalonLighting") == 0.4 and 1 or 0,0,animation1,animation,false),col)	
end

for i = 1,10 do	
	--Головная часть
    local colV = self:GetNW2Vector("Lamp7404"..i)
    local col = Color(colV.x,colV.y,colV.z)		
    self:ShowHideSmooth("lamps_salon_on"..i,self:Animate("LampsFull",self:GetPackedRatio("SalonLighting") == 1 and 1 or 0,0,animation1,animation,false),col)
    self:ShowHideSmooth("lamps_salon_on_fr"..i,self:Animate("LampsFull",self:GetPackedRatio("SalonLighting") == 1 and 1 or 0,0,animation1,animation,false),col)	
end
for i = 1,11 do	
	--Головная часть
    local colV = self:GetNW2Vector("Lamp7404"..i)
    local col = Color(colV.x,colV.y,colV.z)			
	--Задняя часть		
	Pricep740:ShowHideSmooth("lamps_salon_on_rear"..i,Pricep740:Animate("LampsFull",self:GetPackedRatio("SalonLighting") == 1 and 1 or 0,0,animation1,animation,false),col)	
    Pricep740:ShowHideSmooth("lamps_salon_on_rear1"..i,Pricep740:Animate("LampsFull",self:GetPackedRatio("SalonLighting") == 1 and 1 or 0,0,animation1,animation,false),col)	
end

	local net = LocalPlayer():GetName()

	self:ShowHide("!BARSBlock_pl",not net:find("VVKonnov") and not net:find("Takkar") and not net:find("George_pot") and not net:find("charliefry_RUS_RUS") and not net:find("poezdov") and not net:find("JackSever") and not net:find("jack.sever1") and not 
	net:find("Dl3ves15"))
	self:ShowHide("BARSBlock-",not net:find("VVKonnov") and not net:find("Takkar") and not net:find("George_pot") and not net:find("charliefry_RUS") and not net:find("poezdov") and not net:find("JackSever") and not net:find("jack.sever1") and not 
	net:find("Dl3ves15"))
	self:ShowHide("BARSBlock+",not net:find("VVKonnov") and not net:find("Takkar") and not net:find("George_pot") and not net:find("charliefry_RUS") and not net:find("poezdov") and not net:find("JackSever") and not net:find("jack.sever1") and not 
	net:find("Dl3ves15"))
	self:ShowHide("Gerb_msk",not net:find("VVKonnov") and not net:find("Takkar") and not net:find("George_pot") and not net:find("charliefry_RUS") and not net:find("poezdov") and not net:find("JackSever") and not net:find("jack.sever1") and not net:
	find("Dl3ves15"))	
	self:ShowHide("Gerb_msk_right",not net:find("VVKonnov") and not net:find("Takkar") and not net:find("George_pot") and not net:find("charliefry_RUS") and not net:find("poezdov") and not net:find("JackSever") and not net:find("jack.sever1")and not 
	net:find("Dl3ves15"))	
	self:ShowHide("Naddver_off",not net:find("VVKonnov") and not net:find("Takkar") and not net:find("George_pot") and not net:find("charliefry_RUS") and not net:find("poezdov") and not net:find("JackSever") and not net:find("jack.sever1") and not 
	net:find("Dl3ves15"))
	self:ShowHide("ASNP_test",not net:find("VVKonnov") and not net:find("Takkar") and not net:find("George_pot") and not net:find("charliefry_RUS") and not net:find("poezdov") and not net:find("JackSever") and not net:find("jack.sever1") and not net
	:find("Dl3ves15"))	
	self:ShowHide("Wiper_760",not net:find("VVKonnov") and not net:find("Takkar") and not net:find("George_pot") and not net:find("charliefry_RUS") and not net:find("poezdov") and not net:find("JackSever") and not net:find("jack.sever1") and not net
	:find("Dl3ves15"))		
	
	self:HidePanel("ASNPScreen",net:find("VVKonnov") or net:find("Takkar") or net:find("George_pot") or net:find("charliefry_RUS") or net:find("poezdov") or net:find("JackSever") or net:find("jack.sever1") and not net:find("Dl3ves15"))	
	self:HidePanel("ASNP",net:find("VVKonnov") or net:find("Takkar") or net:find("George_pot") or net:find("charliefry_RUS") or net:find("poezdov") or net:find("JackSever") or net:find("jack.sever1") and not net:find("Dl3ves15"))
	self:HidePanel("IGLA_C",net:find("VVKonnov") or net:find("Takkar") or net:find("George_pot") or net:find("charliefry_RUS") or net:find("poezdov") or net:find("JackSever") or net:find("jack.sever1") and not net:find("Dl3ves15"))	
	self:HidePanel("IGLAButtons_C",net:find("VVKonnov") or net:find("Takkar") or net:find("George_pot") or net:find("charliefry_RUS") or net:find("poezdov") or net:find("JackSever") or net:find("jack.sever1") and not net:find("Dl3ves15"))
	self:HidePanel("Vityaz",net:find("VVKonnov") or net:find("Takkar") or net:find("George_pot") or net:find("charliefry_RUS") or net:find("poezdov") or net:find("JackSever") or net:find("jack.sever1") and not net:find("Dl3ves15"))	
	self:HidePanel("VityazButtons",net:find("VVKonnov") or net:find("Takkar") or net:find("George_pot") or net:find("charliefry_RUS") or net:find("poezdov") or net:find("JackSever") or net:find("jack.sever1") and not net:find("Dl3ves15"))	
	self:HidePanel("CAMS",net:find("VVKonnov") or net:find("Takkar") or net:find("George_pot") or net:find("charliefry_RUS") or net:find("poezdov") or net:find("JackSever") or net:find("jack.sever1") and not net:find("Dl3ves15"))	
	
	Pricep740:HidePanel("Tickers_rear",net:find("VVKonnov") or net:find("Takkar") or net:find("George_pot") or net:find("charliefry_RUS") or net:find("poezdov") or net:find("JackSever") or net:find("jack.sever1") and not net:find("Dl3ves15"))
	Pricep740:ShowHide("Naddver_off_740",not net:find("VVKonnov") and not net:find("Takkar") and not net:find("George_pot") and not net:find("charliefry_RUS") and not net:find("poezdov") and not net:find("JackSever") 
	and not net:find("jack.sever1") and not net:find("Dl3ves15"))	
	
	local cab_lamp = self:Animate("cab_lamp",self:GetPackedBool("CabinEnabledFull") and 1 or self:GetPackedBool("CabinEnabledEmer") and 0.5 or 0,0,1,5,false)
    self:ShowHideSmooth("cab_emer",cab_lamp)
    self:ShowHideSmooth("cab_full",cab_lamp)

    self:ShowHideSmooth("lamp_f",self:Animate("lamp_forw",self:GetPackedBool("BIForward") and 1 or 0,0,1,5,false))
    self:ShowHideSmooth("lamp_b",self:Animate("lamp_back",self:GetPackedBool("BIBack") and 1 or 0,0,1,5,false))
	
	if self:GetPackedBool("Wiper") and self.Anims["Wiper_760"] then
		local anim = self.Anims["Wiper_760"]	
		if anim == 0 then
			self.WiperDir = true
		elseif anim == 1 then
			self.WiperDir = false
		end
	self:Animate("Wiper_760",self.WiperDir and 1 or 0,0,1,0.32,false)
	end

    local accel = self:GetPackedRatio("BIAccel",0)
    local speed = self:GetNW2Int("BISpeed",0)
    local limit = self:GetNW2Int("BISpeedLimit",0)
    self:ShowHide("speedl",speed ~= -1)
    self:ShowHide("speed1",speed ~= -1)
    self:ShowHide("speed2",speed ~= -1)
    if speed ~= -1 then
        local blink = self:GetNW2Bool("BISpeedLimitBlink") 
        if blink and CurTime()%1 <=0.5 then
            limit = 98
        end
        local nxt = self:GetNW2Int("BISpeedLimitNext",0)
        for i=1,5 do
            if IsValid(self.ClientEnts["speeddop"..i]) then self.ClientEnts["speeddop"..i]:SetSkin(math.Clamp(50-limit/2-(i-1)*10,0,10)) end
            if IsValid(self.ClientEnts["speedfact"..i]) then self.ClientEnts["speedfact"..i]:SetSkin(math.Clamp(speed/2-(i-1)*10,0,10)) end
            if IsValid(self.ClientEnts["speedrek"..i]) then self.ClientEnts["speedrek"..i]:SetSkin(math.Clamp(50-nxt/2-(i-1)*10,0,10)) end
        end
        if IsValid(self.ClientEnts["speed1"]) then self.ClientEnts["speed1"]:SetSkin(speed/10) end
        if IsValid(self.ClientEnts["speed2"]) then self.ClientEnts["speed2"]:SetSkin(speed%10) end
    else
        for i=1,5 do
            if IsValid(self.ClientEnts["speeddop"..i]) then self.ClientEnts["speeddop"..i]:SetSkin(0) end
            if IsValid(self.ClientEnts["speedfact"..i]) then self.ClientEnts["speedfact"..i]:SetSkin(0) end
            if IsValid(self.ClientEnts["speedrek"..i]) then self.ClientEnts["speedrek"..i]:SetSkin(0) end
        end
    end
	
            --for i=1,29 do				
                --if IsValid(self.ClientEnts["led_l_r"..i]) then self.ClientEnts["led_l_r"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2)) 
                --if IsValid(self.ClientEnts["led_right_f_ob"..i]) then self.ClientEnts["led_right_f_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2)) 
                --if IsValid(self.ClientEnts["led_right1_f_ob"..i]) then self.ClientEnts["led_right1_f_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2)) 
                --if IsValid(self.ClientEnts["led_l_f1_rear_ob"..i]) then self.ClientEnts["led_l_f1_rear_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2)) 								
				--end	
	
	-- наддверки и попытка в рандомизацию поломанных сегментов. ОЧЕНЬ СИЛЬНО ЛАГАЕТ 
    --[[local scurr = self:GetNW2Int("PassSchemesLED")
    local snext = self:GetNW2Int("PassSchemesLEDN")
    local led_back = self:GetPackedBool("PassSchemesLEDO",false)
    local ledwork = scurr~=0 or snext~=0
	
	for i=1,29 do	
        self:ShowHide("led_l_r"..i,not led_back and ledwork)
	    self:ShowHide("led_right_f"..i,not led_back and ledwork)	
	    self:ShowHide("led_right1_f"..i,not led_back and ledwork)	
	    self:ShowHide("led_l_f1_rear"..i,not led_back and ledwork)		

        self:ShowHide("led_l_r_ob"..i,led_back and ledwork)
	    self:ShowHide("led_right_f_ob"..i,led_back and ledwork)	
	    self:ShowHide("led_right1_f_ob"..i,led_back and ledwork)	
	    self:ShowHide("led_l_f1_rear_ob"..i,led_back and ledwork)				
	end
	for i=1,31 do
	    self:ShowHide("led_l_f"..i,not led_back and ledwork)
        self:ShowHide("led_l_zad2_l"..i,not led_back and ledwork)
		
	    self:ShowHide("led_l_f_ob"..i,led_back and ledwork)
        self:ShowHide("led_l_zad2_l_ob"..i,led_back and ledwork)		
	end	
    for i=1,32 do
        self:ShowHide("led_l_f_rear"..i,not led_back and ledwork)
        self:ShowHide("led_l_f2_rear"..i,not led_back and ledwork)
        self:ShowHide("led_l_zad1_l"..i,not led_back and ledwork)	
        self:ShowHide("led_l_zad3_l"..i,not led_back and ledwork)	

        self:ShowHide("led_l_f_rear_ob"..i,led_back and ledwork)
        self:ShowHide("led_l_f2_rear_ob"..i,led_back and ledwork)
        self:ShowHide("led_l_zad1_l_ob"..i,led_back and ledwork)	
        self:ShowHide("led_l_zad3_l_ob"..i,led_back and ledwork)		
	end	
	
    local led = scurr
    if snext ~= 0 and CurTime()%.9 > .30 then led = led + snext end
    if scurr < 0 then led = math.floor(CurTime()%9*6.2) end
    if led_back then
        if ledwork then
		
            for i=1,29 do				
                if IsValid(self.ClientEnts["led_l_r_ob"..i]) then self.ClientEnts["led_l_r_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2)) 
                if IsValid(self.ClientEnts["led_right_f_ob"..i]) then self.ClientEnts["led_right_f_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2)) 
                if IsValid(self.ClientEnts["led_right1_f_ob"..i]) then self.ClientEnts["led_right1_f_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2)) 
                if IsValid(self.ClientEnts["led_l_f1_rear_ob"..i]) then self.ClientEnts["led_l_f1_rear_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2)) 								
				end		
				end
				end 
				end	
end				

            for i=1,31 do
                if IsValid(self.ClientEnts["led_l_f_ob"..i]) then self.ClientEnts["led_l_f_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2))
                if IsValid(self.ClientEnts["led_l_zad2_l_ob"..i]) then self.ClientEnts["led_l_zad2_l_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2))	
				end
				end	
			end 	
				
	            for i=1,32 do
                if IsValid(self.ClientEnts["led_l_f_rear_ob"..i]) then self.ClientEnts["led_l_f_rear_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2)) end
                if IsValid(self.ClientEnts["led_l_f2_rear_ob"..i]) then self.ClientEnts["led_l_f2_rear_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2)) end	
                if IsValid(self.ClientEnts["led_l_zad1_l_ob"..i]) then self.ClientEnts["led_l_zad1_l_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2)) end		
				if IsValid(self.ClientEnts["led_l_zad3_l_ob"..i]) then self.ClientEnts["led_l_zad3_l_ob"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2)) end			
				end					
		end	
    else
        if ledwork then
            for i=1,31 do
                if IsValid(self.ClientEnts["led_l_f"..i]) then self.ClientEnts["led_l_f"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2))
                if IsValid(self.ClientEnts["led_l_zad2_l"..i]) then self.ClientEnts["led_l_zad2_l"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2))								
				end
				end
			
	            for i=1,32 do
                if IsValid(self.ClientEnts["led_l_f_rear"..i]) then self.ClientEnts["led_l_f_rear"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2)) end
                if IsValid(self.ClientEnts["led_l_f2_rear"..i]) then self.ClientEnts["led_l_f2_rear"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2)) end	
                if IsValid(self.ClientEnts["led_l_zad1_l"..i]) then self.ClientEnts["led_l_zad1_l"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2)) end		
				if IsValid(self.ClientEnts["led_l_zad3_l"..i]) then self.ClientEnts["led_l_zad3_l"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2)) end			
				end
				end		
				end
				end
				
            for i=1,29 do				
                if IsValid(self.ClientEnts["led_l_r"..i]) then self.ClientEnts["led_l_r"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2)) 
                if IsValid(self.ClientEnts["led_right_f"..i]) then self.ClientEnts["led_right_f"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2)) 
                if IsValid(self.ClientEnts["led_right1_f"..i]) then self.ClientEnts["led_right1_f"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2)) 
                if IsValid(self.ClientEnts["led_l_f1_rear"..i]) then self.ClientEnts["led_l_f1_rear"..i]:SetSkin(math.Clamp(led-((i-1)*1),0,2)) 								
				end		
				end
				end
				end
			end 
	]]
			
	local bool2num ={ [true]=1, [false]=0 }
	local negbool2num ={ [true]=0, [false]=1 }
    local HL1 = bool2num[self:GetPackedBool("Headlights1Enabled")]*negbool2num[self.HeadLightBroken1] or 1
    local HL2 = bool2num[self:GetPackedBool("Headlights1Enabled")]*negbool2num[self.HeadLightBroken2] or 1
    local HL3 = bool2num[self:GetPackedBool("Headlights2Enabled")]*negbool2num[self.HeadLightBroken3] or 1
    local HL4 = bool2num[self:GetPackedBool("Headlights2Enabled")]*negbool2num[self.HeadLightBroken4] or 1
    local RL  = self:Animate("RedLights",  self:GetPackedBool("RedLights") and 1 or 0,0,1,6,false)
	--print(HL1..HL2..HL3..HL4)
	
	local HLs1 = self:Animate("Headlights1", self:GetPackedBool("Headlights1Enabled") and 1 or 0,0,1,6,false)*(HL1+HL2==0 and 0 or 1)
	local HLs2 = self:Animate("Headlights2", self:GetPackedBool("Headlights2Enabled") and 1 or 0,0,1,6,false)*(HL3+HL4==0 and 0 or 1)
	
	
	self:ShowHideSmooth("Head--_-0", not self.HeadLightBroken1 and HLs1 or 0)
	self:ShowHideSmooth("Head0-_--", not self.HeadLightBroken2 and HLs1 or 0)
	self:ShowHideSmooth("Head--_0-", not self.HeadLightBroken3 and HLs2 or 0)
	self:ShowHideSmooth("Head-0_--", not self.HeadLightBroken4 and HLs2 or 0)
	
    self:ShowHideSmooth("redlights740up1",not self.RedLightBroken1 and RL or 0)
    self:ShowHideSmooth("redlights740up2",not self.RedLightBroken2 and RL or 0)
	self:ShowHideSmooth("redlights740down1",not self.RedLightBroken3 and RL or 0)
    self:ShowHideSmooth("redlights740down2",not self.RedLightBroken4 and RL or 0)
    local headlights = HL1*0.1+HL2*0.1+HL3*0.1+HL4*0.1+HLs1*0.2+HLs2*0.4
	--print(headlights)
    self:SetLightPower(1,headlights>0,headlights)
    --self:SetLightPower(1.2,headlights>0 and not self.HeadLightBroken2,headlights)	
	--self:SetLightPower(1.3,headlights>0 and not self.HeadLightBroken3,headlights)
	--self:SetLightPower(1.4,headlights>0 and not self.HeadLightBroken4,headlights)	
    self:SetLightPower(2,RL>0,RL)
	--print(self:GetPackedRatio("Headlights"))
    if IsValid(self.GlowingLights[1]) then
        if self:GetPackedRatio("Headlights") < 1 and self.GlowingLights[1]:GetFarZ() ~= 4096 then
            self.GlowingLights[1]:SetFarZ(4096)
        end
        if self:GetPackedRatio("Headlights") == 1 and self.GlowingLights[1]:GetFarZ() ~= 5144 then
            self.GlowingLights[1]:SetFarZ(5144)
        end
	end
	--Анимация дверей.
	if not self.DoorStates then self.DoorStates = {} end
    if not self.DoorLoopStates then self.DoorLoopStates = {} end
    for n=0,2 do
        for G=0,1 do
            local st = G==1 and "DoorL" or "DoorR"
            local doorstate = self:GetPackedBool(st)
            local id,sid = st..(n+1),"door"..n.."x"..G
            local state = self:GetPackedRatio(id)
            --print(state,self.DoorStates[state])
            if (state ~= 1 and state ~= 0) ~= self.DoorStates[id] then
                if doorstate and state < 1 or not doorstate and state > 0 then
					if doorstate then self:PlayOnce(sid.."s","",1,math.Rand(0.9,1.3)) end--math.Rand(0.9,1.3))
                else
					if state > 0 then
                        self:PlayOnce(sid.."o1","",1,math.Rand(0.9,1.3))
                    else
                        self:PlayOnce(sid.."c1","",1,math.Rand(0.9,1.3))
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
            local n_l = "door"..n.."x"..G.."a"
            local n_r = "door"..n.."x"..G.."b"
			local n_l1 = "door"..n.."x"..G.."a1"
            local n_r1 = "door"..n.."x"..G.."b1"					
            self:Animate(n_l,state,0,1,15,1)--0.8 + (-0.2+0.4*math.random()),0)
            self:Animate(n_r,state,0,1,15,1)--0.8 + (-0.2+0.4*math.random()),0)				
			Pricep740:Animate(n_l1,state,0,1,15,1)--0.8 + (-0.2+0.4*math.random()),0)
	        Pricep740:Animate(n_r1,state,0,1,15,1)--0.8 + (-0.2+0.4*math.random()),0)				
        end
	end
	
	
    local door_m = self:GetPackedBool("PassengerDoor")
    local door_l = self:GetPackedBool("CabinDoorLeft")
    local door_r = self:GetPackedBool("CabinDoorRight")
    --local door_o = self:GetPackedBool("OtsekDoor") or self.CurrentCamera == 7
	
    local door_cab_m = self:Animate("door_cab_m",door_m and 1 or -0.05,0,0.235, 8, 0.05)
	
	    --[[local door1s = (door_cab_m > 0 or door_m)
    if self.Door1 ~= door1s then
        self.Door1 = door1s
        self:PlayOnce("PassengerDoor","bass" ,door1s and 1 or 0)
    end]]

    local door_cab_l = self:Animate("door_cab_l",door_l	/*self:GetPackedBool(169)*/ and 0.99/*self.Door3 or 0.89)*/ or 0,0,1, 4, 1)               --self:Animate("door_cab_l",door_l and 1 or -0.1,1,0.75, 2, 0.5)
    local door_cab_r = self:Animate("door_cab_r",door_r	/*self:GetPackedBool(169)*/ and 0.99/*(self.Door4 or 0.99)*/ or 0,0,1, 4, 1)              --self:Animate("door_cab_r",door_r and 1 or -0.1,0,0.25, 2, 0.5)
    local door_cab_o = self:Animate("door_cab_o",door_o and 1 or -0.05,0,0.3, 8, 0.05) 			--self:Animate("door_cab_r",door_r and 1 or -0.1,0,0.25, 2, 0.5)
	
    local door2s = door_cab_l > 0.05 and door_cab_l and 2 or (door_cab_l == 1.95 and 2 or door_l and 1 or 0)
    if self.Door2 ~= door2s or self.DoorCL ~= door_l then
        self.DoorCL = door_l
        self.Door2 = door2s
        self:PlayOnce("CabinDoorLeft","bass",door2s)
    end
    
    local door3s = door_cab_r > 0.05 and door_cab_r and 2 or (door_cab_r == 1.95 and 2 or door_r and 1 or 0)
    if self.Door3 ~= door3s or self.DoorCR ~= door_r then
        self.DoorCR = door_r
        self.Door3 = door3s
        self:PlayOnce("CabinDoorRight","bass",door3s)
    end	
	
	local door_cab_t = Pricep740:Animate("door_cab_t",Pricep740:GetPackedBool("RearDoor") and 0.99 or -0.05, 0, 0.55, 4.5, 0.55) 	
	local door4s = (door_cab_t > 0 or Pricep740:GetPackedBool("RearDoor"))
    if self.Door4 ~= door4s then
        self.Door4 = door4s
        self:PlayOnce("RearDoor","bass",door4s and 1 or 0)
    end			
    --[[local door5s = (door_cab_o > 0 or door_o)
    if self.Door5 ~= door5s then
        self.Door5 = door5s
        self:PlayOnce("OtsekDoor","bass",door5s and 1 or 0)
    end
    self:HidePanel("PVZ",not self.Door5)]]
	
	if not self:GetNW2Bool("DoorTorec") then
	 Pricep740:HidePanel("RearDoor",false) 
	else
	 Pricep740:HidePanel("RearDoor",1)
	end 

    local dT = self.DeltaTime

    local parking_brake = math.max(0,-self:GetPackedRatio("ParkingBrakePressure_dPdT",0))
    self.ParkingBrake = self.ParkingBrake+(parking_brake-self.ParkingBrake)*dT*10
    self:SetSoundState("parking_brake",self.ParkingBrake,1.4)

    self.FrontLeak = math.Clamp(self.FrontLeak + 10*(-self:GetPackedRatio("FrontLeak")-self.FrontLeak)*dT,0,1)
    Pricep740.RearLeak = math.Clamp(self.RearLeak + 10*(-self:GetPackedRatio("RearLeak")-self.RearLeak)*dT,0,1)
    self:SetSoundState("front_isolation",self.FrontLeak,0.9+0.2*self.FrontLeak)
    Pricep740:SetSoundState("rear_isolation",self.RearLeak,0.9+0.2*Pricep740.RearLeak)

    local ramp = self:GetPackedRatio("Crane_dPdT",0)
    if ramp > 0 then
        self.CraneRamp = self.CraneRamp + ((0.2*ramp)-self.CraneRamp)*dT
    else
        self.CraneRamp = self.CraneRamp + ((0.9*ramp)-self.CraneRamp)*dT
    end
    self.CraneRRamp = math.Clamp(self.CraneRRamp + 1.0*((1*ramp)-self.CraneRRamp)*dT,0,1)
    self:SetSoundState("crane013_release",self.CraneRRamp^1.5,1.0)
    self:SetSoundState("crane013_brake",math.Clamp(-self.CraneRamp*1.5,0,1)^1.3,1.0)
    self:SetSoundState("crane013_brake2",math.Clamp(-self.CraneRamp*1.5-0.95,0,1.5)^2,1.0)

    local emergencyValve = self:GetPackedRatio("EmergencyValve_dPdT", 0)^0.4*1.2
    self.EmergencyValveRamp = math.Clamp(self.EmergencyValveRamp + (emergencyValve-self.EmergencyValveRamp)*dT*16,0,1)
    self:SetSoundState("emer_brake",self.EmergencyValveRamp,1.0)

	local RingSound = self:GetNW2Int("RingSound",1)
	
    local state = self:GetPackedBool("RingEnabled")
	if RingSound==1 then		
    self:SetSoundState("ring",state and 0.40 or 0,1)
	end
	if RingSound==2 then		
    self:SetSoundState("ring_old",state and 0.40 or 0,1)
	end
	if RingSound==3 then		
    self:SetSoundState("ring_new",state and 0.40 or 0,1)
	end	
	if RingSound==4 then		
    self:SetSoundState("ring_1",state and 0.40 or 0,1)
	end	
	
    local state = self:GetPackedBool("CompressorWork")
    self:SetSoundState("compressor",state and 1.0 or 0,1)

    local speed = self:GetPackedRatio("Speed", 0)

    local ventSpeedAdd = math.Clamp(speed/30,0,1)

    local vstate = self:GetPackedBool("Vent2Work")
    for i=1,7 do
        local rand = self.VentRand[i]
        local vol = self.VentVol[i]
        local even = i%2 == 0
        local work = (even and v1state or not even and vstate)
        local target = math.min(1,(work and 1 or 0)+ventSpeedAdd*rand*0.4)*2
        if self.VentVol[i] < target then
            self.VentVol[i] = math.min(target,vol + dT/1.5*rand)
        elseif self.VentVol[i] > target then
            self.VentVol[i] = math.max(0,vol - dT/8*rand*(vol*0.3))
        end
        self.VentState[i] = (self.VentState[i] + 10*((self.VentVol[i]/2)^3)*dT)%1
        local vol1 = math.max(0,self.VentVol[i]-1)
        local vol2 = math.max(0,(self.VentVol[i-1] or self.VentVol[i+1])-1)
		
		local VentSound = self:GetNW2Int("VentSound",1)	
		if VentSound==1 then
        self:SetSoundState("vent"..i,vol1*(0.7+vol2*0.3),0.5+0.5*vol1+math.Rand(-0.01,0.01))
		end
		if VentSound==2 then
        self:SetSoundState("vent1"..i,vol1*(0.7+vol2*0.3),0.5+0.5*vol1+math.Rand(-0.01,0.01))
		end		
		
		if VentSound==1 then		
        if IsValid(self.ClientEnts["vent"..i]) then
            self.ClientEnts["vent"..i]:SetPoseParameter("position",self.VentState[i])
			end
		end		
		
		if VentSound==2 then	
		if IsValid(self.ClientEnts["vent1"..i]) then
            self.ClientEnts["vent1"..i]:SetPoseParameter("position",self.VentState[i])
			end	
		end		
    end
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
	
    Pricep740:SetSoundState("rolling_5_tst",rollingi*rol5,rol5p)	
    Pricep740:SetSoundState("rolling_10_tst",rollingi*rol10,rol10p)
    Pricep740:SetSoundState("rolling_30_tst",rollingi*rol30,rol30p)
    Pricep740:SetSoundState("rolling_55_tst",rollingi*rol55,rol55p)
    Pricep740:SetSoundState("rolling_75_tst",rollingi*rol75,rol75p)	

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
	
    --local state = (RealTime()%4/3)^1.5
    --local strength = 1--self:GetPackedRatio("asyncstate")*(1-math.Clamp((speed-15)/15,0,1))
    local state = self:GetPackedRatio("asynccurrent")--^1.5--RealTime()%2.5/2	
    local strength = self:GetPackedRatio("asyncstate")*(1-math.Clamp((speed-23)/23,0,1))
	--print(state/0.3+0.2)
	--self:SetSoundState("async1", tunstreet*math.Clamp((state)/0.26+0.2,0,1)*strength, 1)
    --self:SetSoundState("chopper", tunstreet*self:GetPackedRatio("chopper"), 1)  	
	
    local state = self:GetPackedRatio("RNState")
    self.TISUVol = math.Clamp(self.TISUVol+(state-self.TISUVol)*dT*8,0,1)
	
	local AsyncSound = self:GetNW2Int("AsyncSound",1)
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
	
	local BBEs = self:GetNW2Int("BBESound",1)	
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
	if soundid:sub(1,4) == "IGLA" then
    return range > 0 and "igla_on" or "igla_off",location,1,pitch
    end
    if soundid == "QF1" then
        local id = range > 0 and "qf1_on" or "qf1_off"
        local speed = self:GetPackedRatio("Speed")
        self.SoundPositions["qf1_on"][1] = 440-Lerp(speed/0.1,0,330)
        return id,location,1-Lerp(speed/10,0.2,0.8),pitch
    end
    return soundid,location,range,pitch
end 
function ENT:DrawPost(special)
    self.RTMaterial:SetTexture("$basetexture", self.Vityaz)
    self:DrawOnPanel("Vityaz",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(440,520,1430,1140,0) --1024 ебет \\\витязь vityaz
    end)
    self.RTMaterial:SetTexture("$basetexture", self.ASNP)
    self:DrawOnPanel("ASNPScreen",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(155,50,480,112.5,0)
    end)
	--ИГЛА
    self.RTMaterial:SetTexture("$basetexture",self.IGLA)
    self:DrawOnPanel("IGLA_C",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(256,64,512,128,0)
    end)
	self.RTMaterial:SetTexture("$basetexture", self.CAMS)
    self:DrawOnPanel("CAMS",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(529,446,1024,768,0) 
    end)
	self.RTMaterial:SetTexture("$basetexture", self.Tickers)
    self:DrawOnPanel("Tickers",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(512,32+8,1024+16,64+16,0)
    end)		
    local Pricep740 = self:GetNW2Entity("gmod_subway_kuzov")
	if Pricep740.ButtonMap then	
	self.RTMaterial:SetTexture("$basetexture", self.Tickers)		
    Pricep740:DrawOnPanel("Tickers_rear",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(512,32+8,1024+16,64+16,0)
    end)
	return end	
end

Metrostroi.GenerateClientProps()