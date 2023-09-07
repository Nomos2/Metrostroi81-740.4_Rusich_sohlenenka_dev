local Map = game.GetMap():lower() or ""
if(Map:find("gm_metro_minsk") 
or Map:find("gm_metro_nsk_line")
or Map:find("gm_metro_kalinin")
or Map:find("gm_metro_krl")
or Map:find("gm_dnipro")
or Map:find("gm_bolshya_kolsewya_line")
or Map:find("gm_metrostroi_practice_d")
or Map:find("gm_metronvl")
or Map:find("gm_metropbl")) then
	return
end

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.SyncTable = {"RearBrakeLineIsolation","RearTrainLineIsolation"}
 
function ENT:Initialize()
    self:SetModel("models/metrostroi_train/81-740/body/81-740_4_rear.mdl")
    self:SetPos(self:GetPos() + Vector(0,0,0))
	
    self.Joints = {}
    self.JointPositions = {}
    if self:GetModel() == "models/error.mdl" then
        self:SetModel("models/props_lab/reciever01a.mdl")
    end	
    if not self.NoPhysics then
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
    else
        self:SetSolid(SOLID_VPHYSICS)
    end
    self:SetUseType(SIMPLE_USE)
    if CPPI and IsValid(self.Owner) then
        self:CPPISetOwner(self.Owner)
    end    
	
	self.InteractionZones = {	
        {
            ID = "RearBrakeLineIsolationToggle",
            Pos = Vector(-206-131,-25,-46), Radius = 31
        },
        {
            ID = "RearTrainLineIsolationToggle",
            Pos = Vector(-206-131,25,-46), Radius = 31
        },
        {
            ID = "RearDoor",
            Pos = Vector(-310, -6, 7), Radius = 31
        },
	} 

    -- Get default train mass
    if IsValid(self:GetPhysicsObject()) then
        self.NormalMass = self:GetPhysicsObject():GetMass()
    end	   

	self.NormalMass = 19500		

    self.WireIOSystems = {}
    self.Systems = {}
    self.TrainEntities = {}
    self.TrainWires = {}	
	
	self.Lights = {
		[14] = { "dynamiclight",    Vector( 220, -20, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 },
		[15] = { "dynamiclight",    Vector( 10, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 },
        [16] = { "dynamiclight",    Vector( -310, 20, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 250, fov=180,farz = 128 },
		
		[14.1] = { "dynamiclight",    Vector( 200, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 500 , fov=180,farz = 128 }, --полный свет
        [16.1] = { "dynamiclight",    Vector( -310, 0, 40), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 250, fov=180,farz = 128 } 	
    }	
	
	self.RearDoor = false	
	self.Lamps = {
        broken = {},
    }	
	
    local rand = math.random() > 0.9 and 1 or math.random(0.95,0.99)
    for i = 1,20 do
        if math.random() > rand then self.Lamps.broken[i] = math.random() > 0.7 end
    end
	
    self:UpdateLampsColors()		
	
end	

function ENT:TrainSpawnerUpdate()
    self:SetNW2Entity("gmod_subway_81-740_4", self.HeadTrain)    
	local train = self.HeadTrain	
    train:UpdateLampsColors()			
end

function ENT:UpdateLampsColors()
    local lCol,lCount = Vector(),20
	local mr = math.random
    local rand = mr() > 0.8 and 1 or mr(0.95,0.99)
	local rnd1,rnd2,col = 0.7+mr()*0.3,mr()
	local typ = math.Round(mr())
	local r,g = 15,15
	for i = 1,40 do
		local chtp = mr() > rnd1
		if typ == 0 and chtp then
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
		self.Lamps.broken[i] = math.random() > rand and math.random() > 0.7	
		--PrintTable(self.Lamps.broken)	
	end
end
	
function ENT:Think()	
    self:SetNW2Entity("gmod_subway_81-740_4", self.HeadTrain)    
	local train = self.HeadTrain		
	local Panel = train.Panel		
	local retVal = train.BaseClass.Think(self)
    local power = train.Electric.Battery80V > 62
	
	self:SetPackedBool("RearDoor",self.RearDoor)	
    self:SetPackedBool("Vent2Work",train.Electric.Vent2>0)	
    self:SetPackedBool("BBEWork",power and train.BUV.BBE > 0)
    self:SetPackedBool("CompressorWork",train.Pneumatic.Compressor) 
    self:SetPackedBool("AnnPlay",Panel.AnnouncerPlaying > 0)	 
	
    if self.AnnouncementToLeaveWagon ~= train.AnnouncementToLeaveWagon then self.AnnouncementToLeaveWagon = train.AnnouncementToLeaveWagon end
	
      self:SetPackedBool("DoorL",train.DoorLeft)
      self:SetPackedBool("DoorR",train.DoorRight)    
      self.LeftDoorsOpening = train.DoorLeft
      self.RightDoorsOpening = train.DoorRight
      self.LeftDoorsOpen = train.LeftDoorsOpen
      self.RightDoorsOpen = train.RightDoorsOpen 
	  
		--скорость дверей
		for k,v in pairs(train.Pneumatic.LeftDoorSpeed) do
			train.Pneumatic.LeftDoorSpeed[k] = -2, 6
		end
		
		for k,v in pairs(train.Pneumatic.RightDoorSpeed) do
			train.Pneumatic.RightDoorSpeed[k] = -2, 6
		end

	local lightsActive1 = power and train.SFV20.Value > 0 
    local lightsActive2 = power and train.BUV.MainLights 
	local mul = 0
    local Ip = 6.9
    local Im = 1
	for i = 1,20 do
       if (lightsActive2 or (lightsActive1 and math.ceil((i+Ip-Im)%Ip)==1)) then
            if not train.Lamps[i] and not train.Lamps.broken[i] then train.Lamps[i] = CurTime() + math.Rand(0.1,math.Rand(1.15,2.5)) --[[print(self.Lamps[i]-CurTime())]] end
        else
            train.Lamps[i] = nil
        end
        if (train.Lamps[i] and CurTime() - train.Lamps[i] > 0) then
            mul = mul + 1
            train:SetPackedBool("lightsActive"..i,true)
        else
            train:SetPackedBool("lightsActive"..i,false)
        end
    end	   

	local passlight = power and (train.BUV.MainLights and 1 or train.SFV20.Value > 0.5 and 0.4) or 0 
    train:SetPackedRatio("SalonLighting",passlight) 	
	self:SetLightPower(14,passlight > 0, passlight and mul/20) 
    self:SetLightPower(15,passlight > 0.5, passlight and mul/20)
	self:SetLightPower(16,passlight > 0, passlight and mul/20) 
	
	self:SetLightPower(14.1,passlight > 0, passlight and mul/20) 
	self:SetLightPower(16.1,passlight > 0, passlight and mul/20) 	
	
    return retVal		 
end	

function ENT:OnRemove()
    -- Remove all linked objects
    constraint.RemoveAll(self)
    if self.TrainEntities then
        for k,v in pairs(self.TrainEntities) do
            SafeRemoveEntity(v)
        end
end	
end

function ENT:OnButtonPress(button,ply)
    self:SetNW2Entity("gmod_subway_81-740_4", self.HeadTrain)	
	local train = self.HeadTrain
    if not IsValid(train) or not IsValid(self) then return end		
    if button == "RearDoor" and (self.RearDoor or not train.BUV.BlockTorec) then self.RearDoor = not self.RearDoor end
end	