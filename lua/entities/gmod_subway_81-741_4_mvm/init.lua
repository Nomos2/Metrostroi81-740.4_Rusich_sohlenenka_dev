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

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BogeyDistance = 650 -- Needed for gm trainspawner
ENT.SyncTable = {
    "SFV1","SFV2","SFV3","SFV4","SFV5","SFV6","SFV7","SFV8","SFV9","SFV10","SFV11",
    "SFV12","SFV13","SFV14","SFV15","SFV16","SFV17","SFV18","SFV19","SFV20","SFV21","SFV22",
    "SFV23","SFV24","SFV25","SFV26","SFV27","SFV28","SFV29","SFV30","SFV31","SFV32","SFV33",
    "RearBrakeLineIsolation","RearTrainLineIsolation",
    "FrontBrakeLineIsolation","FrontTrainLineIsolation","Battery","PVZ_otsek","PVZ_otsek_open",
    "GV",
}
--------------------------------------------------------------------------------
function ENT:Initialize()
    -- Set model and initialize
    self:SetModel("models/metrostroi_train/81-741/body/81-741_4_front.mdl")
	--self:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.BaseClass.Initialize(self)
    self:SetPos(self:GetPos() + Vector(0,0,140))	

    self.NormalMass = 20000
    self:DrawShadow(true)	

    -- Create seat entities
    self.DriverSeat = self:CreateSeat("instructor",Vector(610,11,-35))

    -- Hide seats
    self.DriverSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
    self.DriverSeat:SetColor(Color(0,0,0,0))

    -- Create bogeys
        self.FrontBogey = self:CreateBogey(Vector( 520,0,-75.4),Angle(0,180,0),true,"740")	
--------------------------------------------------------------------------------
        self.RearBogey  = self:CreateBogey(Vector(-520,0,-75),Angle(0,0,0),true,"740NOTR") --110 0 -80  
		self.RearBogey:PhysicsInit(SOLID_VPHYSICS)	
		
		self.FrontBogey:SetNWInt("MotorSoundType",2)
		self.RearBogey:SetNWInt("MotorSoundType",2)		
	    self.RearBogey.DisableContacts = true		
--------------------------------------------------------------------------------
        self.FrontCouple = self:CreateCouple(Vector(607,0,-60),Angle(0,0,0),true,"717")
--------------------------------------------------------------------------------
        self.RearCouple  = self:CreateCouple(Vector(-611,0,-60),Angle(0,-180,0),false,"740")
		self.RearCouple:SetModel("models/metrostroi_train/81-740/bogey/metro_couple_740.mdl") --
		self.RearCouple:PhysicsInit(SOLID_VPHYSICS)
		self.RearCouple:GetPhysicsObject():SetMass(5000)
		
timer.Simple(0, function()
		local rand = math.random()*0.05
		self.MiddleBogey = self:CreateBogey(Vector(-1,0,-74.5),Angle(0,0,0),true,"740G")--тележка  ---160,0,-75 -410,0,-75	
		self.MiddleBogey:SetNWFloat("SqualPitch",1.45+rand)
		self.MiddleBogey:SetNWInt("MotorSoundType",2)
		self.MiddleBogey:SetNWInt("Async",true)
		self.MiddleBogey:SetNWBool("DisableEngines",true)			
		self:SetNW2Entity("MiddleBogey",self.MiddleBogey)	
		self.MiddleBogey.DisableSound = 1			
        self.MiddleBogey:SetNW2Entity("TrainEntity", self.HeadTrain)			
		table.insert(self.TrainEntities,self.MiddleBogey)		
		self.Rear1 = self:CreatePricep(Vector(-326.1,0,0))		--вагон		
end)
	
	self:SetNW2Entity("FrontBogey",self.FrontBogey)
	self:SetNW2Entity("RearBogey",self.RearBogey)
	self:SetNW2Entity("FrontCouple",self.FrontCouple)
	self:SetNW2Entity("RearCouple",self.RearCouple)
	
	self.FrontBogey:SetNWBool("Async",true)
    self.RearBogey:SetNWBool("Async",true)

    local rand = math.random()*0.05
    self.FrontBogey:SetNWFloat("SqualPitch",1.45+rand)
    self.RearBogey:SetNWFloat("SqualPitch",1.45+rand)
--------------------------------------------------------------------------------	
    -- Initialize key mapping
    self.KeyMap = {
        [KEY_F] = "PneumaticBrakeUp",
        [KEY_R] = "PneumaticBrakeDown",
        [KEY_PAD_1] = "PneumaticBrakeSet1",
        [KEY_PAD_2] = "PneumaticBrakeSet2",
        [KEY_PAD_3] = "PneumaticBrakeSet3",
        [KEY_PAD_4] = "PneumaticBrakeSet4",
        [KEY_PAD_5] = "PneumaticBrakeSet5",
        [KEY_PAD_6] = "PneumaticBrakeSet6",
    }
    -- Cross connections in train wires
    self.TrainWireCrossConnections = {
        [4] = 3, -- Orientation F<->B
        [13] = 12, -- Reverser F<->B
        [38] = 37, -- Doors L<->R
    }
-- зоны взаимодействия
    self.InteractionZones = {
        {
            ID = "FrontBrakeLineIsolationToggle",
            Pos = Vector(463.4, -22, -60), Radius = 16,
        },
        {
            ID = "FrontTrainLineIsolationToggle",
            Pos = Vector(463.4, 22, -60), Radius = 16,
        },
        {
            ID = "FrontDoor",
            Pos = Vector(458,30,0), Radius = 20,
        },
        {
            ID = "GVToggle",
            Pos = Vector(128,60,-75), Radius = 20,
        },
        {
            ID = "AirDistributorDisconnectToggle",
            Pos = Vector(-177, -66, -50), Radius = 20,
        },
    }
    self.Lights = {
        -- Interior
		[15] = { "dynamiclight",    Vector(280-144, 40, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 }, --левая лампа аварийная
		[16] = { "dynamiclight",    Vector(420-144, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 },
        [17] = { "dynamiclight",    Vector(705-144, -20, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500, fov=180,farz = 128 },
		
		[15.1] = { "dynamiclight",    Vector(260-144, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 },
        [16.1] = { "dynamiclight",    Vector(675-144, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500, fov=180,farz = 128 },	
    }
    self.FrontDoor = false
	
    self.PVZ_otsek_close = false		
    self.PVZ_otsek = false
    self.PVZ_otsek_open = false		
	
	self.Lamps = {
        broken = {},
    }		
	
end

function ENT:TrainSpawnerUpdate()
	local MotorType = self:GetNW2Int("MotorType")	
       if MotorType == 1 then
            MotorType = math.ceil(math.random()*4+0.5)
          else MotorType = MotorType-1 end	
	self:SetNW2Int("MotorType",MotorType)	
	--self:SetNW2Int("MotorType",math.random(1, 2))	

	local AsyncSound = self:GetNW2Int("AsyncSound")	
       if AsyncSound == 1 then
            AsyncSound = math.ceil(math.random()*5+0.5)
          else AsyncSound = AsyncSound-1 end	
	self:SetNW2Int("AsyncSound",AsyncSound)	
	--self:SetNW2Int("AsyncSound",math.random(1, 2))	

	local ZavodTable = self:GetNW2Int("ZavodTable")	
       if ZavodTable == 1 then
            ZavodTable = math.ceil(math.random()*2+0.5)
          else ZavodTable = ZavodTable-1 end	
	self:SetNW2Int("ZavodTable",ZavodTable)	

	local BBEs = self:GetNW2Int("BBESound")	
       if BBEs == 1 then
            BBEs = math.ceil(math.random()*2+0.5)
          else BBEs = BBEs-1 end	
	self:SetNW2Int("BBESound",BBEs)	
    --рандомизация цвета табло
	--local ALS = math.random(1, 3)
	--self:SetNW2Int("tablo_color", ALS)
	--print(self:GetNW2String("Texture"))
	
    self:UpdateLampsColors()
	
end	

function ENT:UpdateLampsColors()
    local lCol,lCount = Vector(),0
	local mr = math.random
    local rand = mr() > 0.8 and 1 or mr(0.95,0.99)
	local rnd1,rnd2,col = 0.7+mr()*0.3,mr()
	local typ = math.Round(mr())
	local r,g = 15,15
	for i = 1,40 do
		local chtp = mr() > rnd1
		if typ == 0 and not chtp or typ == 1 and chtp then
			if mr() > rnd2 then
				r = -20+mr()*25
				g = 0
			else
				g = -5+mr()*15
				r = g
			end
			col = Vector(245+r,228+g,189)
		else
			if mr() > rnd2 then
				g = mr()*15
				b = g
			else
				g = 15
				b = -10+mr()*25
			end
			col = Vector(255,235+g,235+b)
		end
		lCol = lCol + col
		lCount = lCount + 1
		if i%8.3<1 then
			local id = 9+math.ceil(i/8.3)
			--self:SetLightPower(id,false)
			local tcol = (lCol/lCount)/255
			--self.Lights[id][4] = Vector(tcol.r,tcol.g^3,tcol.b^3)*255
			lCol = Vector() lCount = 0
		end
		self:SetNW2Vector("Lamp7404"..i,col)
		self.Lamps.broken[i] = mr() > rand and mr() > 0.65
		--PrintTable(self.Lamps.broken)
	end
end

function CanConstrain( gmod_pricep_kuzov, self )

	if ( !gmod_pricep_kuzov ) then return false end
	if ( !isnumber( self ) ) then return false end
	if ( !gmod_pricep_kuzov:IsWorld() && !gmod_pricep_kuzov:IsValid() ) then return false end
	if ( !IsValid( gmod_pricep_kuzov:GetPhysicsObjectNum( self ) ) ) then return false end

	return true

end 
function ENT:SpawnFunction(ply, tr,className,rotate)

 local verticaloffset = 5 -- Offset for the train model
    local distancecap = 2000 -- When to ignore hitpos and spawn at set distanace
    local pos, ang = nil
    local inhibitrerail = false

    --TODO: Make this work better for raw base ent

    if tr.Hit and self.NoTrain then
        -- Regular spawn
        if tr.HitPos:Distance(tr.StartPos) > distancecap then
            -- Spawnpos is far away, put it at distancecap instead
            pos = tr.StartPos + tr.Normal * distancecap
        else
            -- Spawn is near
            pos = tr.HitPos + tr.HitNormal * verticaloffset
        end
        ang = Angle(0,tr.Normal:Angle().y,0)
    elseif tr.Hit and not self.NoTrain then
        -- Setup trace to find out of this is a track
        local tracesetup = {}
        tracesetup.start=tr.HitPos
        tracesetup.endpos=tr.HitPos+tr.HitNormal*80
        tracesetup.filter=ply

        local tracedata = util.TraceLine(tracesetup)

        if tracedata.Hit then
            -- Trackspawn
            pos = (tr.HitPos + tracedata.HitPos)/2 + Vector(0,0,verticaloffset)
            ang = tracedata.HitNormal
            ang:Rotate(Angle(0,0,0))
            ang = ang:Angle()
            -- Bit ugly because Rotate() messes with the orthogonal vector | Orthogonal? I wrote "origional?!" :V
        else
            -- Regular spawn
            if tr.HitPos:Distance(tr.StartPos) > distancecap then
                -- Spawnpos is far away, put it at distancecap instead
                pos = tr.StartPos + tr.Normal * distancecap
                inhibitrerail = true
            else
                -- Spawn is near
                pos = tr.HitPos + tr.HitNormal * verticaloffset
            end
            ang = Angle(0,tr.Normal:Angle().y,0)
        end
    else
        -- Trace didn't hit anything, spawn at distancecap
        pos = tr.StartPos + tr.Normal * distancecap
        ang = Angle(0,tr.Normal:Angle().y,0)
    end
    local ent = ents.Create(className or self.ClassName)
    ent:SetPos(pos)
    ent:SetAngles(ang)
    if rotate then ent:SetAngles(ent:LocalToWorldAngles(Angle(0,0,0))) end
    ent.Owner = ply
    ent:Spawn()
    ent:Activate()
    if not inhibitrerail then inhibitrerail = not Metrostroi.RerailTrain(ent) end
    if rotate and inhibitrerail then ent:Remove() return false end
	
	return ent
end	

function ENT:CreatePricep(pos,ang)		--"models/hunter/plates/plate.mdl"	
	local train = Pricep740	
	local Pricep740 = ents.Create("gmod_pricep_kuzov")--ents.Create("base_entity")
	Pricep740:SetModel("models/metrostroi_train/81-741/body/81-741_4_rear.mdl")		
    if not IsValid(Pricep740) or not IsValid(self) then return end	
	Pricep740:SetPos(self:LocalToWorld(pos))
	Pricep740:SetAngles(self:LocalToWorldAngles(Angle(0,0,0)))
	Pricep740:Spawn()
	Pricep740:SetOwner(self:GetOwner())	
	Pricep740:DrawShadow(false)		
	
    if CPPI and IsValid(self:CPPIGetOwner()) then Pricep740:CPPISetOwner(self:CPPIGetOwner()) end		
	
	self:SetNW2Entity("gmod_pricep_kuzov",Pricep740)
	table.insert(self.TrainEntities,Pricep740)
    table.insert(Pricep740.TrainEntities,self)		


    --[[local seat = ents.Create("prop_vehicle_prisoner_pod")
    seat:SetModel("models/nova/jeep_seat.mdl") --jalopy
    seat:SetPos(self:LocalToWorld(Vector(-642,-30.2,-25)))
    seat:SetAngles(self:GetAngles()+Angle(0,0,0))
    seat:SetKeyValue("limitview",0)
    seat:Spawn()
    seat:GetPhysicsObject():SetMass(0)
    seat:SetCollisionGroup(COLLISION_GROUP_WORLD)
    self:DrawShadow(false)
	seat:SetNoDraw(true)
	
    --Assign ownership
    if CPPI and IsValid(self:CPPIGetOwner()) then seat:CPPISetOwner(self:CPPIGetOwner()) end
    seat:SetParent(Pricep740)	

    local seat_1 = ents.Create("prop_vehicle_prisoner_pod")	
    seat_1:SetModel("models/nova/jeep_seat.mdl") --jalopy
    seat_1:SetPos(self:LocalToWorld(Vector(-642,30.2,-25)))
    seat_1:SetAngles(self:GetAngles()+Angle(0,180,0))
    seat_1:SetKeyValue("limitview",0)
    seat_1:Spawn()
    seat_1:GetPhysicsObject():SetMass(0)
    seat_1:SetCollisionGroup(COLLISION_GROUP_WORLD)
    seat_1:DrawShadow(false)
	seat_1:SetNoDraw(true)	

    if CPPI and IsValid(self:CPPIGetOwner()) then seat_1:CPPISetOwner(self:CPPIGetOwner()) end
    seat_1:SetParent(Pricep740)]]	
        
	if 
	Map:find("gm_metro_pink_line_redux_v1") or
	Map:find("gm_jar_pll_redux_v1") or
	Map:find("gm_metro_crossline_r199h") or	
	Map:find("gm_metro_crossline_n4a") or	
	Map:find("gm_metro_crossline_c4") or		
	Map:find("gm_metro_crossline_m12") or	
	Map:find("gm_metro_crossline_n3") or
	Map:find("gm_metro_mosldl_v1") or	
	Map:find("gm_metro_mosldl_v1m") or	
	Map:find("gm_smr_1987") or			
	Map:find("gm_jar_pll_redux_v1_fs") then
        constraint.Axis(
		self.MiddleBogey,
		Pricep740,
		0,
		0,
        Vector(0,0,0),
		Vector(0,0,0),
        0,
		0,
		0,
		1,
		Vector(0,0,1),
		false)
	else
	constraint.AdvBallsocket(
		Pricep740,
		self.MiddleBogey,
		0, --bone
		0, --bone		
		Vector(305,0.5,35),
		Vector(-305,0,0),		
		0, --forcelimit
		0, --torquelimit
		-20, --xmin
		-20, --ymin
		-180, --zmin
		20, --xmax
		20, --ymax
		180, --zmax
		0, --xfric
		0, --yfric
		0, --zfric
		0, --rotonly
		1--nocollide
	)
	constraint.AdvBallsocket(
		Pricep740,
		self.MiddleBogey,
		0, --bone
		0, --bone		
		Vector(305,0.5,-5),
		Vector(-305,0,0),	
		0, --forcelimit
		0, --torquelimit
		-20, --xmin
		-20, --ymin
		-180, --zmin
		20, --xmax
		20, --ymax
		180, --zmax
		0, --xfric
		0, --yfric
		0, --zfric
		0, --rotonly
		1--nocollide
	)
end	
        constraint.Axis(
		self.RearBogey,		
		Pricep740,
		0,
		0,
		Vector(0,0,0),
		Vector(0,0,0),
        0,
		0,
		0,
		0,
		Vector(0,0,-1)
		)
	--Сцепка, крепление к вагону.
	constraint.AdvBallsocket(
		Pricep740,
		self.RearCouple,
		0, --bone
		0, --bone
		Vector(-320.2+20.8,0,-50),
		Vector(0,0,0),
		1, --forcelimit
		1, --torquelimit
		
		-2, --xmin
		-2, --ymin
		-15, --zmin
		
		2, --xmax
		2, --ymax
		15, --zmax
		
		0.1, --xfric
		0.1, --yfric
		1, --zfric
		
		0, --rotonly
		1 --nocollide
	)  	

function Pricep740:TrainSpawnerUpdate()
	local MotorType = self:GetNW2Int("MotorType")	
       if MotorType == 1 then
            MotorType = math.ceil(math.random()*4+0.5)
          else MotorType = MotorType-1 end	
	self:SetNW2Int("MotorType",MotorType)	
	--self:SetNW2Int("MotorType",math.random(1, 2))	

	local AsyncSound = self:GetNW2Int("AsyncSound")	
       if AsyncSound == 1 then
            AsyncSound = math.ceil(math.random()*5+0.5)
          else AsyncSound = AsyncSound-1 end	
	self:SetNW2Int("AsyncSound",AsyncSound)	
	--self:SetNW2Int("AsyncSound",math.random(1, 2))	

	local ZavodTable = self:GetNW2Int("ZavodTable")	
       if ZavodTable == 1 then
            ZavodTable = math.ceil(math.random()*2+0.5)
          else ZavodTable = ZavodTable-1 end	
	self:SetNW2Int("ZavodTable",ZavodTable)	

	local BBEs = self:GetNW2Int("BBESound")	
       if BBEs == 1 then
            BBEs = math.ceil(math.random()*2+0.5)
          else BBEs = BBEs-1 end	
	self:SetNW2Int("BBESound",BBEs)		
    --рандомизация цвета табло
	--local ALS = math.random(1, 3)
	--self:SetNW2Int("tablo_color", ALS)
	--print(self:GetNW2String("Texture"))
end

function Pricep740:Use(ply)
    local tr = ply:GetEyeTrace()
    if not tr.Hit then return end
    local hitpos = self:WorldToLocal(tr.HitPos)
    print(hitpos)
    if self.InteractionZones and ply:GetPos():Distance(tr.HitPos) < 100 then
        for k,v in pairs(self.InteractionZones) do
            if hitpos:Distance(v.Pos) < v.Radius then
                self:ButtonEvent(v.ID,nil,ply)
            end
        end
    end
	
function Pricep740:ShowInteractionZones()
    for k,v in pairs(self.InteractionZones) do
        debugoverlay.Sphere(self:LocalToWorld(v.Pos),v.Radius,15,Color(255,185,0),true)
    end
end	
		
	 self.InteractionZones = {	
        {
            ID = "RearBrakeLineIsolationToggle",
            Pos = Vector(-336, -25, -54), Radius = 16
        },
        {
            ID = "RearTrainLineIsolationToggle",
            Pos = Vector(-536-131,-45,-46), Radius = 16
        },
        {
            ID = "RearDoor",
            Pos = Vector(-310, -13, 7),ang = Angle(0,90,90), Radius = 31
        },
	} 
--------------------------------------------------------------------------------
-- Keyboard input
--------------------------------------------------------------------------------
function Pricep740:IsModifier(key)
    return type(self.KeyMap[key]) == "table"
end

function Pricep740:HasModifier(key)
    return self.KeyMods[key] ~= nil
end

function Pricep740:GetActiveModifiers(key)
    local tbl = {}
    local mods = self.KeyMods[key]
    for k,v in pairs(mods) do
        if self.KeyBuffer[k] ~= nil then
            table.insert(tbl,k)
        end
    end
    return tbl
end

function Pricep740:OnKeyEvent(key,state,ply,helper)
    if state then
        self:OnKeyPress(key)
    else
        self:OnKeyRelease(key)
    end
    local keyT = self.KeyMap[key]
    if self:HasModifier(key) and not helper then
        --If we have a modifier
        local actmods = self:GetActiveModifiers(key)
        if #actmods > 0 then
            --Modifier is being preseed
            for k,v in pairs(actmods) do
                if self.KeyMap[v][key] ~= nil then
                    self:ButtonEvent(self.KeyMap[v][key],state,ply)
                end
            end
            return
        end
    end
    if self:IsModifier(key) then
        if keyT.helper then
            self:ButtonEvent(helper and keyT.helper or keyT[1],state,ply)
        elseif not helper then
            if state and keyT.def and not helper then
                self:ButtonEvent(keyT.def,state,ply)
            elseif not state then
                if keyT.def then
                    self:ButtonEvent(keyT.def,state,ply)
                end
                for k,v in pairs(keyT) do
                    self:ButtonEvent(v,false,ply)
                end
            end
        end
    elseif keyT ~= nil and type(keyT) == "string" and not helper then
        --If we're a regular binded key
        self:ButtonEvent(keyT,state,ply)
    end
end
function Pricep740:OnKeyPress(key)

end

function Pricep740:OnKeyRelease(key)

end

function Pricep740:ProcessKeyMap()
    self.KeyMods = {}

    for mod,v in pairs(self.KeyMap) do
        if type(v) == "table" then
            for k,_ in pairs(v) do
                if not self.KeyMods[k] then
                    self.KeyMods[k]={}
                end
                self.KeyMods[k][mod]=true
            end
        end
    end
end


local function HandleKeyHook(ply,k,state)
    local train = ply:GetTrain()
    if IsValid(train) then
        train.KeyMap[k] = state or nil
    end
end

function Pricep740:HandleKeyboardInput(ply)
    if not self.KeyMods and self.KeyMap then
        self:ProcessKeyMap()
    end

    -- Check for newly pressed keys
    for k,v in pairs(ply.keystate) do
        if self.KeyBuffer[k] == nil then
            self.KeyBuffer[k] = true
            self:OnKeyEvent(k,true,ply)
        end
    end

    -- Check for newly released keys
    for k,v in pairs(self.KeyBuffer) do
        if ply.keystate[k] == nil then
            self.KeyBuffer[k] = nil
            self:OnKeyEvent(k,false,ply)
        end
    end
end	
end

function Pricep740:CreateJointSound(sndnum)
    local jID = self.SpeedSign>0 and 1 or #self.JointPositions
    table.insert(self.Joints,
        {
            type = sndnum,
            state = jID,
            dist = self.JointPositions[jID]
        }
    )
end 

    Pricep740.ButtonBuffer = {}
    Pricep740.KeyBuffer = {}
    Pricep740.KeyMap = {}	
	
self.RearDoor = false	
function Pricep740:Think()	
    self:SetPackedBool("RearDoor",self.RearDoor)	
end
function Pricep740:OnButtonPress(button,ply)
    if button == "RearDoor" and (self.RearDoor or not self.BlockTorec) then self.RearDoor = not self.RearDoor end	
end		
end	
--------------------------------------------------------------------------------
--Основное
function ENT:Think()
    local train = self.HeadTrain	
    local retVal = self.BaseClass.Think(self)
    local power = self.Electric.Battery80V > 62 --Батарея
    local Pricep740 = self:GetNW2Entity("gmod_pricep_kuzov")
    if not IsValid(Pricep740) then return end	
	Pricep740.SyncTable = {	"RearBrakeLineIsolation","RearTrainLineIsolation"}		
    --print(self,self.BPTI.T,self.BPTI.State)

    --[[ if self.BUV.Brake > 0 then
        self:SetPackedRatio("RNState", power and (Train.K2.Value>0 or Train.K3.Value>0) and self.Electric.RN > 0 and (1-self.Electric.RNState)+math.Clamp(1-(math.abs(self.Electric.Itotal)-50)/50,0,1) or 1)
    else
        self:SetPackedRatio("RNState", power and (Train.K2.Value>0 or Train.K3.Value>0) and self.Electric.RN > 0 and self.Electric.RNState+math.Clamp(1-(math.abs(self.Electric.Itotal)-50)/50,0,1) or 1)
    end--]]
    if self.BPTI.State < 0 then
        self:SetPackedRatio("RNState", ((self.BPTI.RNState)-0.5)*math.Clamp((math.abs(self.Electric.Itotal/2)-30-self.Speed*1)/35,0,1)) --снижение скорости
        --self:SetNW2Int("RNFreq", 13)
    else--if self.BPTI.State > 0 then
        self:SetPackedRatio("RNState", (0.95-self.BPTI.RNState)*math.Clamp((math.abs(self.Electric.Itotal/2)-36-self.Speed*1)/35,0,5))
        --self:SetNW2Int("RNFreq", ((self.BPTI.FreqState or 0)-1/3)/(2/3)*12)
    --[[ else
        self:SetPackedRatio("RNState", 0)--]]
    end

		--скорость дверей
		for k,v in pairs(self.Pneumatic.LeftDoorSpeed) do
			self.Pneumatic.LeftDoorSpeed[k] = -2, 12
		end
		
		for k,v in pairs(self.Pneumatic.RightDoorSpeed) do
			self.Pneumatic.RightDoorSpeed[k] = -2, 12
		end
		
	local lightsActive1 = power and self.SFV20.Value > 0 
    local lightsActive2 = power and self.BUV.MainLights 
	local mul = 0
    local Ip = 6.9
    local Im = 1
	for i = 1,40 do
       if (lightsActive2 or (lightsActive1 and math.ceil((i+Ip-Im)%Ip)==1)) then
            if not self.Lamps[i] and not self.Lamps.broken[i] then self.Lamps[i] = CurTime() + math.Rand(0.1,math.Rand(1.15,2.5)) --[[print(self.Lamps[i]-CurTime())]] end
        else
            self.Lamps[i] = nil
        end
        if (self.Lamps[i] and CurTime() - self.Lamps[i] > 0) then
            mul = mul + 1
            self:SetPackedBool("lightsActive"..i,true)
        else
            self:SetPackedBool("lightsActive"..i,false)
        end
    end		
		
    -- получение всяких значений
    self:SetPackedRatio("Speed", self.Speed)
    self:SetPackedBool("CompressorWork",self.Pneumatic.Compressor)
    self:SetPackedBool("Vent2Work",self.Electric.Vent2>0)
    self:SetPackedBool("BBEWork",power and self.BUV.BBE > 0)
	self:SetPackedBool("PVZ_otsek",self.PVZ_otsek)
	self:SetPackedBool("PVZ_otsek_open",self.PVZ_otsek)	
	
    local state = math.abs(self.AsyncInverter.InverterFrequency/(11+self.AsyncInverter.State*5))
    self:SetPackedRatio("asynccurrent", math.Clamp(state*(state+self.AsyncInverter.State/1),0,1)*math.Clamp(self.Speed/6,0,1))
    self:SetPackedRatio("asyncstate", math.Clamp(self.AsyncInverter.State*math.abs(self.AsyncInverter.Current)/200,0,1))
    --self:SetPackedRatio("chopper", math.Clamp(self.Electric.Chopper>0 and self.Electric.IChopper/100 or 0,0,1))	
	
    self:SetPackedRatio("TrainLine", self.Pneumatic.BrakeLinePressure/16.0)
    self:SetPackedRatio("BrakeLine", self.Pneumatic.TrainLinePressure/16.0)
	self:SetPackedRatio("BrakeCylinder", math.min(3.3,self.Pneumatic.BrakeCylinderPressure)/6.0)		
	
    --self:SetNW2Int("PassSchemesLED",self.PassSchemes.PassSchemeCurr)
    --self:SetNW2Int("PassSchemesLEDN",self.PassSchemes.PassSchemeNext) 
    --self:SetPackedBool("PassSchemesLEDO",self.PassSchemes.PassSchemePath)

    self:SetPackedBool("AnnPlay",self.Panel.AnnouncerPlaying > 0)
	
    self:SetPackedBool("FrontDoor",self.FrontDoor)
    --свет в салоне
    local passlight = power and (self.BUV.MainLights and 1 or self.SFV20.Value > 0.5 and 0.4) or 0
	
	self:SetLightPower(15,passlight > 0, passlight and mul/40)
	self:SetLightPower(16,passlight > 0.5, passlight and mul/40)
	self:SetLightPower(17,passlight > 0, passlight and mul/40)
	
	self:SetLightPower(15.1,passlight > 0, passlight and mul/40)
	self:SetLightPower(16.1,passlight > 0.5, passlight and mul/40)		
	
	Pricep740.Lights = {
		[18] = { "dynamiclight",    Vector( 180, -15, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 },
		[19] = { "dynamiclight",    Vector( 10, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 },
        [20] = { "dynamiclight",    Vector( -290, 20, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500, fov=180,farz = 128 }
    }		
	
	self:GetNW2Entity("gmod_pricep_kuzov"):SetLightPower(18,passlight > 0, passlight)
	self:GetNW2Entity("gmod_pricep_kuzov"):SetLightPower(19,passlight > 0.5, passlight)
    self:GetNW2Entity("gmod_pricep_kuzov"):SetLightPower(20,passlight > 0, passlight)
	
    self:SetPackedRatio("SalonLighting",passlight)
    --local mul = self.SF45.Value > 0.5 and self.BUV.MainLights and 1 or self.SF46.Value > 0.5 and 0.5 or 0
    --self:SetLightPower(11,self.BUV.Power and mul > 0, mul)
    --self:SetLightPower(12,self.BUV.Power and mul > 0, mul)
    self.Engines:TriggerInput("Speed",self.Speed)
    --мощность двигателей и тормозов    
   if IsValid(self.FrontBogey) and IsValid(self.RearBogey) and IsValid(self.MiddleBogey) and not self.IgnoreEngine then
        local A = 2*self.Engines.BogeyMoment
        self.FrontBogey.MotorForce = (24000+6500*(A < 0 and 1 or 0))--*add--35300+10000*(A < 0 and 1 or 0)
        self.FrontBogey.Reversed = self.KMR2.Value > 0.5
        self.MiddleBogey.MotorForce  = (24000+6500*(A < 0 and 1 or 0))--*add--+5000--35300
        self.MiddleBogey.Reversed = self.KMR1.Value > 0.5
		self.RearBogey.MotorForce  = (24000+6500*(A < 0 and 1 or 0))--*add--+5000--35300
        self.RearBogey.Reversed = self.KMR1.Value > 0.5		
		self.AsyncInverter:TriggerInput("Speed", self.Speed)	

        -- These corrections are required to beat source engine friction at very low values of motor power
        local P = math.max(0,0.04449 + 1.09879*math.abs(A) - 0.565729*A^2)
        if math.abs(A) > 0.4 then P = math.abs(A) end
        if math.abs(A) < 0.05 then P = 0 end
        if self.Speed < 10 then P = P*(1.0 + 0.5*(10.0-self.Speed)/10.0) end
        self.RearBogey.MotorPower  = P*0.7*((A > 0) and 1 or -1)
        self.FrontBogey.MotorPower = P*0.7*((A > 0) and 1 or -1)

        -- Apply brakes
        self.FrontBogey.PneumaticBrakeForce = (50000.0--[[ +5000+10000--]] ) --20000
        self.FrontBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        self.FrontBogey.ParkingBrakePressure = math.max(0,(3-self.Pneumatic.ParkingBrakePressure)/3)
        self.FrontBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
        self.FrontBogey.DisableContacts = self.BUV.Pant
		self.MiddleBogey.PneumaticBrakeForce = (50000.0--[[ +5000+10000--]] ) --20000
        self.MiddleBogey.BrakeCylinderPressure = self.Pneumatic.MiddleBogeyBrakeCylinderPressure
        self.MiddleBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.MiddleBogeyBrakeCylinderPressure_dPdT
        self.MiddleBogey.ParkingBrakePressure = math.max(0,(3-self.Pneumatic.ParkingBrakePressure)/3)         		
        self.MiddleBogey.DisableContacts = self.BUV.Pant		
		self.RearBogey.PneumaticBrakeForce = (50000.0--[[ +5000+10000--]] ) --20000
        self.RearBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
        self.RearBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
	    self.RearBogey.ParkingBrakePressure = math.max(0,(3-self.Pneumatic.ParkingBrakePressure)/3)		

    end
    return retVal
end
--------------------------------------------------------------------------------	 
--При сцепке открывать краны
function ENT:OnCouple(train,isfront)
    if isfront and self.FrontAutoCouple then
        self.FrontBrakeLineIsolation:TriggerInput("Open",1.0)
        self.FrontTrainLineIsolation:TriggerInput("Open",1.0)
        self.FrontAutoCouple = false
    elseif not isfront and self.RearAutoCouple then
        self.RearBrakeLineIsolation:TriggerInput("Open",1.0)
        self.RearTrainLineIsolation:TriggerInput("Open",1.0)
        self.RearAutoCouple = false
    end
    self.BaseClass.OnCouple(self,train,isfront)
end
function ENT:OnButtonPress(button,ply)
    if button == "FrontDoor" and (self.FrontDoor or not self.BUV.BlockTorec) then self.FrontDoor = not self.FrontDoor end
	
	if button == "PVZ_otsek" then self.PVZ_otsek = not self.PVZ_otsek end	
	if button == "PVZ_otsek_open" then self.PVZ_otsek_open = not self.PVZ_otsek_open end	
end