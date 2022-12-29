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
        {ID = "FrontDoor",x=0,y=0,w=642,h=2000, tooltip="", model = {
            var="FrontDoor",sndid="door_cab_f",
            sndvol = 1, snd = function(val) return val and "door_cab_open" or "door_cab_close" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,180,0),
        }},
    }
}
ENT.ClientProps["salon"] = {
	model = "models/metrostroi_train/81-741/salon/salon.mdl",
	pos = Vector(322.6,0,0),
	ang = Angle(0,180,0),
	hide=2,
}
ENT.ClientProps["handrails"] = {
	model = "models/metrostroi_train/81-741/salon/handrails/handrails.mdl",
	pos = Vector(325.8,0,0),
	ang = Angle(0,-180,0),
	hide=1,
}
ENT.ClientProps["door_cab_f"] = {
	model = "models/metrostroi_train/81-741/body/door_br.mdl",
	pos = Vector(657,-14.4,8.5),
	ang = Angle(0,270,0.1),
	hide=2,
}
ENT.ClientProps["krepezh"] = {
    model = "models/metrostroi_train/81-740/body/krepezh.mdl",
    pos = Vector(263,0,-74.6),
    ang = Angle(0,0,0),
    nohide = true,
}

----Аварийка
ENT.ClientProps["lamps_salon_on_avar_front1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(522.4,-0.2,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_on_avar_front2"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(88.4,57.8,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}
----Аварийка

ENT.ClientProps["lamps_salon_on_front_left1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(34.4,-0.2,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_on_front_left2"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(88.4,-0.2,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_on_front_left3"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(144.4,-0.2,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_on_front_left4"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(197,-0.2,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_on_front_left5"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(251,-0.2,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_on_front_left6"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(305,-0.2,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_on_front_left7"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(359,-0.2,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_on_front_left8"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(413,-0.2,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_on_front_left9"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(467,-0.2,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_on_front_left10"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(522.4,-0.2,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_on_front_left11"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(576.4,-0.2,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}


ENT.ClientProps["lamps_salon_on_front1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(34.4,57.8,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_on_front2"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(88.4,57.8,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_on_front3"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(144.4,57.8,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_on_front4"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(197,57.8,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_on_front5"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(251,57.8,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_on_front6"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(305,57.8,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_on_front7"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(359,57.8,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_on_front8"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(413,57.8,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_on_front9"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(467,57.8,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_on_front10"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(522.4,57.8,-74.5),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["lamps_salon_on_front11"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(576.4,57.8,-74.5),
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
    model = "models/metrostroi_train/81-740/body/740_body_additional.mdl",
    pos = Vector(300.9,-10,-80),
    ang = Angle(0,0.2,0),
    hide=2,
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
ENT.ClientProps["FrontBrake"] = {
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(660, -20, -56.5), 
    ang = Angle(15,-90,0),
    hide = 2,
}
ENT.ClientProps["FrontTrain"] = {
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(660, 20, -56.5),
    ang = Angle( -15,-90,0),
    hide = 2,
}
for i=0,3 do
    ENT.ClientProps["TrainNumberR"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(635-i*6.6+4*6.6/2,-63.35,18),
        ang = Angle(0,0,-5),
        skin=0,
		nohide=true,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end 
ENT.ClientSounds["FrontBrakeLineIsolation"] = {{"FrontBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["FrontTrainLineIsolation"] = {{"FrontTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
for i=1,4 do
    ENT.ClientProps["led_l_f"..i] = {
        model = "models/metrostroi_train/81-741/salon/741_led_l_rear.mdl",
        pos = Vector(-(i-1)*10.5+278.6+39.3, 169.4, 13.7),
        ang = Angle(0,-180,0),
        skin=6,
        hideseat = 1.5,
    }
    ENT.ClientProps["led_l_r"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_r_rear.mdl",
        pos = Vector(-(i-1)*10.5+327, 95.2,13.65), 
        ang = Angle(0,180,0),
        skin=6,
        hideseat = 1.5,
    }	
end

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
        {ID = "RearTrainLineIsolationToggle",x=400, y=0, w=300, h=100, tooltip="Концевой кран тормозной магистрали"},
        {ID = "RearBrakeLineIsolationToggle",x=000, y=0, w=300, h=100, tooltip="Концевой кран напорной магистрали"},
    }
}
ENT.ClientProps["RearTrain"] = {
		model = "models/metrostroi_train/81-740/bogey/disconnect_valve_blue.mdl",
		pos = Vector(0,0,-78),
		ang = Angle(0,180,0),
		hide=2,
		callback = function(ent,cl_ent)
			local VAGONK = ent:GetNW2Entity("VAGON")
			if not IsValid(VAGONK) then
				ent:ShowHide("RearTrain",true)
				return
			end
			cl_ent:SetParent(VAGONK)
			cl_ent:SetPos(VAGONK:LocalToWorld(Vector(-336, -25, -54))) 
			local ang = VAGONK:GetAngles()	
			cl_ent:SetAngles((Angle(-ang.x,180+ang.y,-ang.z)))
        end,		
}
ENT.ClientProps["RearBrake"] = {
    model = "models/metrostroi_train/81-740/bogey/disconnect_valve_red.mdl",
	pos = Vector(0,0,-78),
	ang = Angle(0,180,0),
	hide=2,
	callback = function(ent,cl_ent)
		local VAGONK = ent:GetNW2Entity("VAGON")
		if not IsValid(VAGON) then
				ent:ShowHide("RearBrake",true)
				return
			end
			cl_ent:SetParent(VAGON)
			cl_ent:SetPos(VAGON:LocalToWorld(Vector(-336, 25, -54))) 
			local ang = VAGON:GetAngles()	
			cl_ent:SetAngles((Angle(-ang.x,180+ang.y,-ang.z)))
        end,		
}
ENT.ClientSounds["RearBrakeLineIsolation"] = {{"RearBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}--660, 23, -56
ENT.ClientSounds["RearTrainLineIsolation"] = {{"RearTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
for i=0,3 do
    ENT.ClientProps["TrainNumberL"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
		pos = Vector(0,0,-78),
        ang = Angle(0,180,-3.29),
        skin=1,
		nohide=true,
		callback = function(ent,cl_ent)
		local VAGONK = ent:GetNW2Entity("VAGON")
		if not IsValid(VAGONK) then
			ent:ShowHide("TrainNumberL"..i,true)
			return
		end
		cl_ent:SetParent(VAGONK)
		cl_ent:SetPos(VAGONK:LocalToWorld(Vector(-310+i*6.6-4*6.6/2, 63.4, 18)))
		local ang = VAGONK:GetAngles()	
		cl_ent:SetAngles((Angle(-ang.x,180+ang.y,-3.29-ang.z)))
        end,			
	}
end 
	
ENT.ClientProps["krepezh1"] = {
    model = "models/metrostroi_train/81-740/body/krepezh.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,180,0),
	nohide=true,
	callback = function(ent,cl_ent)
			local VAGONK = ent:GetNW2Entity("VAGON")
			if not IsValid(VAGONK) then
				ent:ShowHide("krepezh1",true)
				return
			end
		cl_ent:SetParent(VAGONK)
		cl_ent:SetPos(VAGONK:LocalToWorld(Vector(61.5, 0, -75)))
		local ang = VAGONK:GetAngles()
		cl_ent:SetAngles((Angle(-ang.x,180+ang.y,-ang.z)))
		end,
}
ENT.ClientProps["handrails_offside"] = {
    model = "models/metrostroi_train/81-740/body/740_body_additional.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,180,0),
	nohide=true,
	callback = function(ent,cl_ent)
			local VAGONK = ent:GetNW2Entity("VAGON")
			if not IsValid(VAGONK) then
				ent:ShowHide("handrails_offside",true)
				return
			end
		cl_ent:SetParent(VAGONK)
		cl_ent:SetPos(VAGONK:LocalToWorld(Vector(21.8, 10, -76.5)))
		local ang = VAGONK:GetAngles()
		cl_ent:SetAngles((Angle(-ang.x,180+ang.y,-ang.z)))
		end,
}

for i = 0,10 do
ENT.ClientProps["lamps_salon_on_test"..i+1] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,180,0),
	hide=2,
	callback = function(ent,cl_ent)
			local VAGONK = ent:GetNW2Entity("VAGON")
			if not IsValid(VAGONK) then
				ent:ShowHide("lamps_salon_on_test"..i+1,true)
				return
			end
		cl_ent:SetParent(VAGONK)
		cl_ent:SetPos(VAGONK:LocalToWorld(Vector(288-54.23*i,0.55,-74.8))) --338.2-63.83*i, 0, 67.0 288
		local ang = VAGONK:GetAngles()
		cl_ent:SetAngles((Angle(-ang.x,180+ang.y,-ang.z)))
		end,
}
ENT.ClientProps["lamps_salon_on_test1"..i+1] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,180,0),
	hide=2,
	callback = function(ent,cl_ent)
			local VAGONK = ent:GetNW2Entity("VAGON")
			if not IsValid(VAGONK) then
				ent:ShowHide("lamps_salon_on_test1"..i+1,true)
				return
			end
		cl_ent:SetParent(VAGONK)
		cl_ent:SetPos(VAGONK:LocalToWorld(Vector(288-54.23*i,-57.55+0.01*i,-74.71))) --338.2-63.83*i, 0, 67.0 288
		local ang = VAGONK:GetAngles()
		cl_ent:SetAngles((Angle(-ang.x,180+ang.y,-ang.z)))
		end,
}
end

ENT.ClientProps["lamps_salon_on_avar1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,180,0),
	hide=2,
	callback = function(ent,cl_ent)
			local VAGONK = ent:GetNW2Entity("VAGON")
			if not IsValid(VAGONK) then
				ent:ShowHide("lamps_salon_on_avar1",true)
				return
			end
		cl_ent:SetParent(VAGONK)
		cl_ent:SetPos(VAGONK:LocalToWorld(Vector(234,-57.5,-74.75))) --338.2-63.83*i, 0, 67.0 288
		local ang = VAGONK:GetAngles()
		cl_ent:SetAngles((Angle(-ang.x,180+ang.y,-ang.z)))
		end,
}
ENT.ClientProps["lamps_salon_on_avar2"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_on_rear_new.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,180,0),
	hide=2,
	callback = function(ent,cl_ent)
			local VAGONK = ent:GetNW2Entity("VAGON")
			if not IsValid(VAGONK) then
				ent:ShowHide("lamps_salon_on_avar2",true)
				return
			end
		cl_ent:SetParent(VAGONK)
		cl_ent:SetPos(VAGONK:LocalToWorld(Vector(-255,0.58,-74.75))) --338.2-63.83*i, 0, 67.0 288
		local ang = VAGONK:GetAngles()
		cl_ent:SetAngles((Angle(-ang.x,180+ang.y,-ang.z)))
		end,
}
ENT.ClientProps["lamps_salon_off1"] = {
    model = "models/metrostroi_train/81-741/salon/lamps/lamps_off_rear.mdl", 
    pos = Vector(0,0,0),
    ang = Angle(0,180,0),
	hide=2,
	callback = function(ent,cl_ent)
			local VAGONK = ent:GetNW2Entity("VAGON")
			if not IsValid(VAGONK) then
				ent:ShowHide("lamps_salon_off1",true)
				return
			end
		cl_ent:SetParent(VAGONK)
		cl_ent:SetPos(VAGONK:LocalToWorld(Vector(195,0,-75))) --338.2-63.83*i, 0, 67.0 288
		local ang = VAGONK:GetAngles()
		cl_ent:SetAngles((Angle(-ang.x,180+ang.y,-ang.z)))
		end,
}

ENT.ClientProps["handrails1"] = {
		model = "models/metrostroi_train/81-740/salon/handrails/handrails_r.mdl",
		pos = Vector(0,0,0),
		ang = Angle(0,180,0),
		hide=2,
		callback = function(ent,cl_ent)
			local VAGONK = ent:GetNW2Entity("VAGON")
			if not IsValid(VAGONK) then
				ent:ShowHide("handrailsR",true)
				return
			end
		cl_ent:SetParent(VAGONK)
		cl_ent:SetPos(VAGONK:LocalToWorld(Vector(-115.5, -1, -73)))
		local ang = VAGONK:GetAngles()
		cl_ent:SetAngles((Angle(-ang.x,180+ang.y,-ang.z)))
		end,
}

ENT.ClientProps["salon1"] = {
		model = "models/metrostroi_train/81-741/salon/salon_rear.mdl",
		pos = Vector(0,0,0),
		ang = Angle(0,180,0),
		hide=2,
		callback = function(ent,cl_ent)
			local VAGONK = ent:GetNW2Entity("VAGON")
			if not IsValid(VAGONK) then
				ent:ShowHide("handrailsR",true)
				return
			end
		cl_ent:SetParent(VAGONK)
		cl_ent:SetPos(VAGONK:LocalToWorld(Vector(195, 0, -75)))
		local ang = VAGONK:GetAngles()
		cl_ent:SetAngles((Angle(-ang.x,180+ang.y,-ang.z)))
		end,
}
ENT.ClientProps["door_cab_t"] = {
		model = "models/metrostroi_train/81-740/salon/door_br.mdl",
		pos = Vector(0,0,-78),
		ang = Angle(0,180,0),
		hide = 2,
		callback = function(ent,cl_ent)
			local VAGONK = ent:GetNW2Entity("VAGON")
			if not IsValid(VAGONK) then
				ent:ShowHide("door_cab_t",true)
				return
			end
			cl_ent:SetParent(VAGONK)
			cl_ent:SetPos(VAGONK:LocalToWorld(Vector(-332, 15, 8.8)))
			local ang = VAGONK:GetAngles()
			cl_ent:SetAngles((Angle(-ang.x,180+ang.y,-ang.z)))
        end,		
}
--Задняя часть
for i=1,4 do
    ENT.ClientProps["led_l_f_rear"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_r_rear.mdl",
		pos = Vector(0,0,0),
        ang = Angle(0,180,0),
        skin=6,
        hideseat = 1.5,
		callback = function(ent,cl_ent)
		local VAGONK = ent:GetNW2Entity("VAGON")
		if not IsValid(VAGONK) then
			ent:ShowHide("led_l_f_rear"..i,true)
			return
		end
		cl_ent:SetParent(VAGONK)
		cl_ent:SetPos(VAGONK:LocalToWorld(Vector(-(i-1)*10.5-31.6, 95.35, 13.25)))
		local ang = VAGONK:GetAngles()	
		cl_ent:SetAngles((Angle(-ang.x,180+ang.y,-ang.z)))
        end,					
    }
    ENT.ClientProps["led_l_f_left"..i] = {
        model = "models/metrostroi_train/81-740/salon/740_led_l_rear.mdl",
		pos = Vector(0,0,0),
        ang = Angle(0,180,0),
        skin=6,
        hideseat = 1.5,
		callback = function(ent,cl_ent)
		local VAGONK = ent:GetNW2Entity("VAGON")
		if not IsValid(VAGONK) then
			ent:ShowHide("led_l_f_left"..i,true)
			return
		end
		cl_ent:SetParent(VAGONK)
		cl_ent:SetPos(VAGONK:LocalToWorld(Vector(-(i-1)*10.5-41, 169.55,13.35)))
		local ang = VAGONK:GetAngles()	
		cl_ent:SetAngles((Angle(-ang.x,180+ang.y,-ang.z)))
        end,					
    }	
end
--[[ENT.ButtonMap["Tickers_rear"] = {
    pos = Vector(-37,27.5,66), --446 -- 14 -- -0,5
    ang = Angle(0,-90,90),
    width = 1024,
    height = 64,
    scale = 0.0545,
    hide=true,
    hideseat=1,
}]]
--------------------------------------------------------------------------------
-- Add doors
--------------------------------------------------------------------------------
local function GetDoorPosition(i,k,j)
	if j == 0 
	then return Vector(591.9 - 35.0*k     - 232.5*i,-67.5*(1-2*k),4)
	else return Vector(592 - 35.0*(1-k) - 232.5*i,-66*(1-2*k),4)
	end
end
local function GetDoorPositionRear(i,k,j)
	if j == 0 			--	x						--	y        --	z
	then return Vector(195.5 - -35.0*k - 232.1*i, -66*(1-2*k), 4.3)
	else return Vector(265.6 - 35.0*(1-k) - 232.1*i,-67.5*(1-2*k),4.3)
	end
end

local function GetDoorPositionRearLeft(i,k,j)
	if j == 0 			--	x						--	y        --	z 195.5 265.6
	then return Vector(230.5 - -35.0*k - 232.1*i, 66*(1-2*k), 4.3)
	else return Vector(160.3 - -35.0*(1-k) - 232.1*i,67.4*(1-2*k),4.3)
	end
end

for i=0,2 do
	for k=0,1 do
		ENT.ClientProps["door"..i.."x"..k.."a"] = {
			model =  "models/metrostroi_train/81-740/body/81-740_leftdoor2.mdl",
			pos = GetDoorPosition(i,k,0),
			ang = Angle(0,90 +180*k,0),   
			scale = 1.001,				
            hide = 1,
		}
		ENT.ClientProps["door"..i.."x"..k.."b"] = {
			model =  "models/metrostroi_train/81-740/body/81-740_leftdoor1.mdl",
			pos = GetDoorPosition(i,k,1),
			ang = Angle(0,90 +180*k,0),   
			scale = 1.001,				
            hide = 1,
		}

	end 

end

	for i=0,2 do
	for k=0,0 do
		ENT.ClientProps["door"..i.."x1"..k.."a1"] = {
			model = "models/metrostroi_train/81-740/body/81-740_leftdoor3.mdl",
			pos = GetDoorPositionRear(i,k,0),
			ang = Angle(0,180*k,0),      
			hide=2,
			scale = 1.001,					
			callback = function(self,cl_ent)
			local VAGONK = self:GetNW2Entity("VAGON")
			if not IsValid(VAGONK) then
			self:ShowHide("door"..i.."x1"..k.."a1",true)
			return
			end
			
			cl_ent:SetParent(VAGONK)
			cl_ent:SetPos(VAGONK:LocalToWorld(Vector(GetDoorPositionRear(i,k,0))))
			local ang = VAGONK:GetAngles()	
			cl_ent:SetAngles((Angle(-ang.x,180+ang.y,-ang.z)))
			end,
		}
		ENT.ClientProps["door"..i.."x1"..k.."b1"] = {
			model = "models/metrostroi_train/81-740/body/81-740_leftdoor4.mdl",
			pos = GetDoorPositionRear(i,k,1),
			ang = Angle(0,180*k,0),   
			hide=2,
			scale = 1.001,					
			callback = function(self,cl_ent)
			
			local VAGONK = self:GetNW2Entity("VAGON")
			if not IsValid(VAGONK) then
			self:ShowHide("door"..i.."x1"..k.."b1",true)
			return
			end
			
			cl_ent:SetParent(VAGONK)
			cl_ent:SetPos(VAGONK:LocalToWorld(Vector(GetDoorPositionRear(i,k,1))))
			local ang = VAGONK:GetAngles()	
			cl_ent:SetAngles((Angle(-ang.x,180+ang.y,-ang.z)))
			end,
		}
		
		ENT.ClientProps["door"..i.."x2"..k.."a2"] = {
			model = "models/metrostroi_train/81-740/body/81-740_leftdoor6.mdl",
			pos = GetDoorPositionRearLeft(i,k,0),
			ang = Angle(0,180*k,0),      
			hide=2,
			scale = 1.001,					
			callback = function(self,cl_ent)
			local VAGONK = self:GetNW2Entity("VAGON")
			if not IsValid(VAGONK) then
			self:ShowHide("door"..i.."x2"..k.."a2",true)
			return
			end
			
			cl_ent:SetParent(VAGONK)
			cl_ent:SetPos(VAGONK:LocalToWorld(Vector(GetDoorPositionRearLeft(i,k,0))))
			local ang = VAGONK:GetAngles()	
			cl_ent:SetAngles((Angle(-ang.x,180+ang.y,-ang.z)))
			end,
		}
		ENT.ClientProps["door"..i.."x3"..k.."a3"] = {
			model = "models/metrostroi_train/81-740/body/81-740_leftdoor5.mdl",
			pos = GetDoorPositionRearLeft(i,k,0),
			ang = Angle(0,180*k,0),      
			hide=2,
			scale = 1.001,					
			callback = function(self,cl_ent)
			local VAGONK = self:GetNW2Entity("VAGON")
			if not IsValid(VAGONK) then
			self:ShowHide("door"..i.."x3"..k.."a3",true)
			return
			end
			
			cl_ent:SetParent(VAGONK)
			cl_ent:SetPos(VAGONK:LocalToWorld(Vector(GetDoorPositionRearLeft(i,k,1))))
			local ang = VAGONK:GetAngles()	
			cl_ent:SetAngles((Angle(-ang.x,180+ang.y,-ang.z)))
			end,
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
	
	self.FrontBogey = self:GetNW2Entity("FrontBogey")	
	self.RearBogey = self:GetNW2Entity("RearBogey")
	self.MiddleBogey = self:GetNW2Entity("MiddleBogey")
	self.RearCouple = self:GetNW2Entity("RearCouple")
	
	VAGON = self:GetNW2Entity("VAGON")
	
end
function ENT:UpdateWagonNumber()
    for i=0,3 do
        --if i< count then
            local num = math.floor(self.WagonNumber%(10^(i+1))/10^i)
            local rightNum = self.ClientEnts["TrainNumberR"..i]
            
            if IsValid(rightNum) then
                rightNum:SetPos(self:LocalToWorld(Vector(635-i*6.6+4*6.6/2, -63.5 ,18)))
                rightNum:SetSkin(num)
            end
			local leftNum = self.ClientEnts["TrainNumberL"..i]
            if IsValid(leftNum) then
                leftNum:SetSkin(num)
	if not IsValid(VAGONK) then
		VAGON = self:GetNW2Entity("VAGON")		
	end
			
            end	
    end 
end

function ENT:ReInitBogeySounds(bogey)
	if not IsValid(bogey) then return end
	
	local MotorType = self:GetNW2Int("MotorType",1)
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
    self.SoundNames["ted11_720"] = "subway_trains/bogey/engines/720/speed_88.wav"
    self.SoundNames["ted1_720"]  = "subway_trains/bogey/engines/720/speed_8.wav"
    self.SoundNames["ted2_720"]  = "subway_trains/bogey/engines/720/speed_16.wav"
    self.SoundNames["ted3_720"]  = "subway_trains/bogey/engines/720/speed_24.wav"
    self.SoundNames["ted4_720"]  = "subway_trains/bogey/engines/720/speed_32.wav"
    self.SoundNames["ted5_720"]  = "subway_trains/bogey/engines/720/speed_40.wav"
    self.SoundNames["ted6_720"]  = "subway_trains/bogey/engines/720/speed_48.wav"
    self.SoundNames["ted7_720"]  = "subway_trains/bogey/engines/720/speed_56.wav"
    self.SoundNames["ted8_720"]  = "subway_trains/bogey/engines/720/speed_64.wav"
    self.SoundNames["ted9_720"]  = "subway_trains/bogey/engines/720/speed_72.wav"
    self.SoundNames["ted10_720"] = "subway_trains/bogey/engines/720/speed_80.wav"
    --*0.975
    --*1.025
	local skr = math.random (1,4)
	local skripit = math.random (1,5)	
    bogey.SoundNames["flangea"]      = "subway_trains/rusich/bogey/skrip1_"..skr..".wav"
    bogey.SoundNames["flangeb"]      = "subway_trains/rusich/bogey/skrip2_"..skripit..".wav"
    bogey.SoundNames["flange1"]      = "subway_trains/rusich/bogey/flange_9.wav"
    bogey.SoundNames["flange2"]      = "subway_trains/rusich/bogey/Flange_10.wav"
    bogey.SoundNames["brakea_loop1"]       = "subway_trains/rusich/bogey/braking_async3.wav"
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
    table.insert(bogey.EngineSNDConfig,{"ted11_740",88,72-4,96,1})--05	

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
    bogey.SoundNames["ted11_740"] = "subway_trains/rusich/engines_new/engine_88.wav"	

    --bogey.SoundNames["ted11_720"] = "subway_trains/760/engines/engine_80.wav"
    self.SoundNames["ted11_720"] = "subway_trains/bogey/engines/720/speed_88.wav"
    self.SoundNames["ted1_720"]  = "subway_trains/bogey/engines/720/speed_8.wav"
    self.SoundNames["ted2_720"]  = "subway_trains/bogey/engines/720/speed_16.wav"
    self.SoundNames["ted3_720"]  = "subway_trains/bogey/engines/720/speed_24.wav"
    self.SoundNames["ted4_720"]  = "subway_trains/bogey/engines/720/speed_32.wav"
    self.SoundNames["ted5_720"]  = "subway_trains/bogey/engines/720/speed_40.wav"
    self.SoundNames["ted6_720"]  = "subway_trains/bogey/engines/720/speed_48.wav"
    self.SoundNames["ted7_720"]  = "subway_trains/bogey/engines/720/speed_56.wav"
    self.SoundNames["ted8_720"]  = "subway_trains/bogey/engines/720/speed_64.wav"
    self.SoundNames["ted9_720"]  = "subway_trains/bogey/engines/720/speed_72.wav"
    self.SoundNames["ted10_720"] = "subway_trains/bogey/engines/720/speed_80.wav"
    --*0.975
    --*1.025
	local skr = math.random (1,4)
	local skripit = math.random (1,5)	
    bogey.SoundNames["flangea"]      = "subway_trains/rusich/bogey/skrip1_"..skr..".wav"
    bogey.SoundNames["flangeb"]      = "subway_trains/rusich/bogey/skrip2_"..skripit..".wav"
    bogey.SoundNames["flange1"]      = "subway_trains/rusich/bogey/flange_9.wav"
    bogey.SoundNames["flange2"]      = "subway_trains/rusich/bogey/Flange_10.wav"
    bogey.SoundNames["brakea_loop1"]       = "subway_trains/rusich/bogey/braking_async3.wav"
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
end

function ENT:Think()
    self.BaseClass.Think(self)
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
	if IsValid(self.MiddleBogey) and self.MiddleBogey.SoundNames and (self.MiddleBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines/engine_8.wav" 
	or self.MiddleBogey.EngineSNDConfig and self.MiddleBogey.EngineSNDConfig[1] and self.MiddleBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.MiddleBogey)
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
	if IsValid(self.MiddleBogey) and self.MiddleBogey.SoundNames and (self.MiddleBogey.SoundNames["ted1_740"] ~= "subway_trains/rusich/engines_new/engine_8.wav" 
	or self.MiddleBogey.EngineSNDConfig and self.MiddleBogey.EngineSNDConfig[1] and self.MiddleBogey.EngineSNDConfig[1][5] ~= 1) or refresh then
		self:ReInitBogeySounds(self.MiddleBogey)
	end		
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

for avar = 1,2 do	
    -----------------------Задняя часть	
    self:ShowHideSmooth("lamps_salon_on_avar"..avar,self:Animate("LampsEmer",self:GetPackedRatio("SalonLighting") == 0.4 and 1 or 0,0,1,5,false))
    -----------------------Задняя часть
    -----------------------Передняя часть	
    self:ShowHideSmooth("lamps_salon_on_avar_front"..avar,self:Animate("LampsEmer",self:GetPackedRatio("SalonLighting") == 0.4 and 1 or 0,0,1,5,false))	
    -----------------------Передняя часть		
end	

for i = 0,10 do	
    -----------------------Задняя часть	
    self:ShowHideSmooth("lamps_salon_on_test"..i+1,self:Animate("LampsFull",self:GetPackedRatio("SalonLighting") == 1 and 1 or 0,0,1,5,false))
    self:ShowHideSmooth("lamps_salon_on_test1"..i+1,self:Animate("LampsFull",self:GetPackedRatio("SalonLighting") == 1 and 1 or 0,0,1,5,false))
    -----------------------Задняя часть		
    -----------------------Передняя часть		
	self:ShowHideSmooth("lamps_salon_on_front"..i+1,self:Animate("LampsFull",self:GetPackedRatio("SalonLighting") == 1 and 1 or 0,0,1,5,false))
	self:ShowHideSmooth("lamps_salon_on_front_left"..i+1,self:Animate("LampsFull",self:GetPackedRatio("SalonLighting") == 1 and 1 or 0,0,1,5,false))
    -----------------------Передняя часть		
end	

    self:Animate("FrontBrake", self:GetNW2Bool("FbI") and 0 or 1,0,1, 3, false)
    self:Animate("FrontTrain",  self:GetNW2Bool("FtI") and 1 or 0,0,1, 3, false)
    self:Animate("RearBrake",   self:GetNW2Bool("RbI") and 0 or 1,0,1, 3, false)
    self:Animate("RearTrain",   self:GetNW2Bool("RtI") and 1 or 0,0,1, 3, false)

    local scurr = self:GetNW2Int("PassSchemesLED")
    local snext = self:GetNW2Int("PassSchemesLEDN")
    local led_back = self:GetPackedBool("PassSchemesLEDO",false)
    local ledwork = scurr~=0 or snext~=0
    for i=1,4 do
        self:ShowHide("led_l_f"..i,not led_back and ledwork)
        self:ShowHide("led_l_r"..i,not led_back and ledwork)
        self:ShowHide("led_l_f_rear"..i,not led_back and ledwork)
        self:ShowHide("led_l_f_left"..i,not led_back and ledwork)
    end
    local led = scurr
    if snext ~= 0 and CurTime()%.5 > .25 then led = led + snext end
    if scurr < 0 then led = math.floor(CurTime()%5*6.2) end
    if led_back then
        if ledwork then
        end
    else
        if ledwork then
            for i=1,4 do
                if IsValid(self.ClientEnts["led_l_f"..i]) then self.ClientEnts["led_l_f"..i]:SetSkin(math.Clamp(led-((i-1)*6),0,6)) end
                if IsValid(self.ClientEnts["led_l_r"..i]) then self.ClientEnts["led_l_r"..i]:SetSkin(math.Clamp(led-((i-1)*6),0,6)) end			
                if IsValid(self.ClientEnts["led_l_f_rear"..i]) then self.ClientEnts["led_l_f_rear"..i]:SetSkin(math.Clamp(led-((i-1)*6),0,6)) end
                if IsValid(self.ClientEnts["led_l_f_left"..i]) then self.ClientEnts["led_l_f_left"..i]:SetSkin(math.Clamp(led-((i-1)*6),0,6)) end
            end
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
	
		--Анимация дверей задней части.
	if not self.DoorStates then self.DoorStates = {} end
    if not self.DoorLoopStates then self.DoorLoopStates = {} end
    for i=0,2 do
        for k=0,1 do
            local st = k==1 and "DoorL" or "DoorR"
            local doorstate = self:GetPackedBool(st)
            local id,sid = st..(i+1),"door"..i.."x"..k
            local state = self:GetPackedRatio(id)
            if self.DoorStates[id] then
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
	
			--Анимация дверей задней части.
	if not self.DoorStates then self.DoorStates = {} end
    if not self.DoorLoopStates then self.DoorLoopStates = {} end
    for i=0,2 do
        for k=0,1 do
            local st = k==1 and "DoorR" or "DoorL"
            local doorstate = self:GetPackedBool(st)
            local id,sid = st..(i+1),"door"..i.."x2"..k.."a2"
            local state = self:GetPackedRatio(id)
            if self.DoorStates[id] then
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
			local n_l1eft = "door"..i.."x2"..k.."a2"
			self:Animate(n_l1eft,state,0,1,15,1)--0.8 + (-0.2+0.4*math.random()),0)
        end
	end
	
	if not self.DoorStates then self.DoorStates = {} end
    if not self.DoorLoopStates then self.DoorLoopStates = {} end
    for i=0,2 do
        for k=0,1 do
            local st = k==1 and "DoorR" or "DoorL"
            local doorstate = self:GetPackedBool(st)
            local id,sid = st..(i+1),"door"..i.."x3"..k.."a3"
            local state = self:GetPackedRatio(id)
            if self.DoorStates[id] then
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
            local n_r1right = "door"..i.."x3"..k.."a3"
            self:Animate(n_r1right,state,0,1,15,1)--0.8 + (-0.2+0.4*math.random()),0)
        end
	end
	
    local door_f = self:GetPackedBool("FrontDoor")
    local door_t = self:GetPackedBool("RearDoor")	
    local door_cab_f = self:Animate("door_cab_f",door_f and 0.99 or -0.05, 0, 0.55, 4.5, 0.55)
    local door_cab_b = self:Animate("door_cab_b",door_t and 0.99 or -0.05, 0, 0.55, 4.5, 0.55)
	
	local RearDoor = self:Animate("RearDoor",door_t and  0.5/*(self.Door2 or 0.99)*/ or 0,0,1, 4, 1) 	

    local door1s = (door_cab_f > 0 or door_f)
    if self.Door1 ~= door1s then
        self.Door1 = door1s
        self:PlayOnce("FrontDoor","bass",door1s and 1 or 0)
    end
    local door2s = (door_cab_b > 0 or door_t)
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
