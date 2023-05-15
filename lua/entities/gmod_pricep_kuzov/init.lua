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
	

    -- Get default train mass
    if IsValid(self:GetPhysicsObject()) then
        self.NormalMass = self:GetPhysicsObject():GetMass()
    end	
	self.TrainEntities = {}	
    self:InitializeSounds()
    if self.NoTrain then return end	
    
    self.WireIOSystems = {}
    self.Systems = {}
    self.TrainWires = {}
	
    -- Setup drivers controls
    self.ButtonBuffer = {}
    self.KeyBuffer = {}
    self.KeyMap = {}

    -- Override for if drivers wrench is present
    self.DriversWrenchPresent = false

    -- External interaction areas
    self.InteractionAreas = {}

    if joystick then
        self.JoystickBuffer = {}
    end	
	
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

-- Interaction zones
function ENT:Use(ply)
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
end

-- Trigger output
function ENT:TriggerOutput(name,value)
    if Wire_TriggerOutput then
        Wire_TriggerOutput(self,name,tonumber(value) or 0)
    end
end

-- Trigger input
function ENT:TriggerInput(name, value)
    -- Drivers wrench present
    if name == "DriversWrenchPresent" then
        self.DriversWrenchPresent = (value > 0.5)
    end
end

function ENT:ShowInteractionZones()
    for k,v in pairs(self.InteractionZones) do
        debugoverlay.Sphere(self:LocalToWorld(v.Pos),v.Radius,15,Color(255,185,0),true)
    end
end

function ENT:SpawnButton(model,pos,ang,min,max,soundtbl)
    local ent = ents.Create("gmod_train_button")
    ent:SetPos(self:LocalToWorld(pos))
    ent:SetAngles(self:LocalToWorldAngles(ang ))
    ent:SetParent(self)
    ent.Owner = ply
    ent.Model = model
    ent.Sounds = soundtbl
    ent:Spawn()
    ent:Activate()
    return ent
end
function ENT:SpawnSwitch(model,pos,ang,min,max,soundtbl)
    local ent = ents.Create("gmod_train_swtich")
    ent:SetPos(self:LocalToWorld(pos))
    ent:SetAngles(self:LocalToWorldAngles(ang ))
    ent:SetParent(self)
    ent.Owner = ply
    ent.Model = model
    ent.Min = min
    ent.Max = max
    ent.Sounds = soundtbl
    ent:Spawn()
    ent:Activate()
    return ent
end
function ENT:TriggerTurbostroiInput(sys,name,val)
    if name == "Value" then
        -- Autosend values to client
        if self.SyncTable and table.HasValue(self.SyncTable,sys) then
            self:SetPackedBool(sys,val > 0)
        end
    end
end
--------------------------------------------------------------------------------
-- Create an entity for the seat
--------------------------------------------------------------------------------
function ENT:CreateSeatEntity(seat_info)
    -- Create seat entity
    local seat = ents.Create("prop_vehicle_prisoner_pod")
    seat:SetModel(seat_info.model or "models/nova/jeep_seat.mdl") --jalopy
    seat:SetPos(self:LocalToWorld(seat_info.offset))
    seat:SetAngles(self:GetAngles()+Angle(0,-90,0)+seat_info.angle)
    seat:SetKeyValue("limitview",0)
    seat:Spawn()
    seat:GetPhysicsObject():SetMass(10)
    seat:SetCollisionGroup(COLLISION_GROUP_WORLD)
    self:DrawShadow(false)

    --Assign ownership
    if CPPI and IsValid(self:CPPIGetOwner()) then seat:CPPISetOwner(self:CPPIGetOwner()) end

    -- Hide the entity visually
    if seat_info.type == "passenger" then
        seat:SetColor(Color(0,0,0,0))
        seat:SetRenderMode(RENDERMODE_TRANSALPHA)
    end

    -- Set some shared information about the seat
    self:SetNW2Entity("seat_"..seat_info.type,seat)
    seat:SetNW2String("SeatType", seat_info.type)
    seat:SetNW2Entity("TrainEntity", self)
    seat_info.entity = seat

    -- Constrain seat to this object
    -- constraint.NoCollide(self,seat,0,0)
    seat:SetParent(self)

    -- Add to cleanup list
    table.insert(self.TrainEntities,seat)
    return seat
end
--------------------------------------------------------------------------------
-- Turn light on or off
--------------------------------------------------------------------------------
function ENT:SetLightPower(index,power,brightness)
    local lightData = self.Lights[index]
    self.GlowingLights = self.GlowingLights or {}
    self.LightBrightness = self.LightBrightness or {}
    brightness = brightness or 1

    -- Check if light already glowing
    if (power and (self.GlowingLights[index])) and
       (brightness == self.LightBrightness[index]) then return end

    -- If light already glowing and only brightness changed
    if (power and (self.GlowingLights[index])) and
       (brightness ~= self.LightBrightness[index]) then
        local light = self.GlowingLights[index]
        if (lightData[1] == "glow") or (lightData[1] == "light") then
            local brightness = brightness * (lightData.brightness or 0.5)
            light:SetKeyValue("rendercolor",
                Format("%i %i %i",
                    lightData[4].r*brightness,
                    lightData[4].g*brightness,
                    lightData[4].b*brightness
                )
            )
        end
        if (lightData[1] == "headlight") then
            -- Set Brightness
            local brightness = brightness * (lightData.brightness or 1.25)
            light:SetKeyValue("lightcolor",
                Format("%i %i %i 255",
                    lightData[4].r*brightness,
                    lightData[4].g*brightness,
                    lightData[4].b*brightness
                )
            )
        end
        if (lightData[1] == "dynamiclight") then
            --light:SetKeyValue("brightness", brightness * (lightData.brightness or 2))
            light:SetKeyValue("_light",
                Format("%i %i %i",
                    lightData[4].r*brightness,
                    lightData[4].g*brightness,
                    lightData[4].b*brightness
                )
            )
        end
        self.LightBrightness[index] = brightness
        return
    end

    -- Turn off light
    SafeRemoveEntity(self.GlowingLights[index])
    self.GlowingLights[index] = nil
    self.LightBrightness[index] = brightness

    -- Create light
    if (lightData[1] == "headlight") and (power) then
        local light = ents.Create("env_projectedtexture")
        light.DormantFix = true
        light:SetTransmitWithParent(true)
        light:SetParent(self)
        light:SetPos(self:LocalToWorld(lightData[2]))
        light:SetAngles(self:LocalToWorldAngles(lightData[3]))

        -- Set parameters
        light:SetKeyValue("enableshadows", lightData.shadows or 1)
        light:SetKeyValue("farz", lightData.farz or 2048)
        light:SetKeyValue("nearz", lightData.nearz or 16)
        light:SetKeyValue("lightfov", lightData.fov or 120)

        -- Set Brightness
        local brightness = brightness * (lightData.brightness or 1.25)
        light:SetKeyValue("lightcolor",
            Format("%i %i %i 255",
                lightData[4].r*brightness,
                lightData[4].g*brightness,
                lightData[4].b*brightness
            )
        )

        -- Turn light on
        light:Spawn() --"effects/flashlight/caustics"
        light:Input("SpotlightTexture",nil,nil,lightData.texture or "effects/flashlight001")
        self.GlowingLights[index] = light
    end
    if (lightData[1] == "glow") and (power) then
        local light = ents.Create("env_sprite")
        light.DormantFix = true
        light:SetTransmitWithParent(true)
        light:SetParent(self)
        light:SetLocalPos(lightData[2])
        light:SetLocalAngles(lightData[3])

        -- Set parameters
        local brightness = brightness * (lightData.brightness or 0.5)
        light:SetKeyValue("rendercolor",
            Format("%i %i %i",
                lightData[4].r*brightness,
                lightData[4].g*brightness,
                lightData[4].b*brightness
            )
        )
        light:SetKeyValue("rendermode", lightData.type or 3) -- 9: WGlow, 3: Glow
        light:SetKeyValue("renderfx", 14)
        light:SetKeyValue("model", lightData.texture or "sprites/glow1.vmt")
--      light:SetKeyValue("model", "sprites/light_glow02.vmt")
--      light:SetKeyValue("model", "sprites/yellowflare.vmt")
        light:SetKeyValue("scale", lightData.scale or 1.0)
        light:SetKeyValue("spawnflags", 1)

        -- Turn light on
        light:Spawn()
        self.GlowingLights[index] = light
    end
    if (lightData[1] == "light") and (power) then
        local light = ents.Create("env_sprite")
        light.DormantFix = true
        light:SetTransmitWithParent(true)
        light:SetParent(self)
        light:SetLocalPos(lightData[2])
        light:SetLocalAngles(lightData[3])

        -- Set parameters
        local brightness = brightness * (lightData.brightness or 0.5)
        light:SetKeyValue("rendercolor",
            Format("%i %i %i",
                lightData[4].r*brightness,
                lightData[4].g*brightness,
                lightData[4].b*brightness
            )
        )
        light:SetKeyValue("rendermode", lightData.type or 9) -- 9: WGlow, 3: Glow
        light:SetKeyValue("renderfx", 14)
--      light:SetKeyValue("model", "sprites/glow1.vmt")
        light:SetKeyValue("model", lightData.texture or "sprites/light_glow02.vmt")
--      light:SetKeyValue("model", "sprites/yellowflare.vmt")
        light:SetKeyValue("scale", lightData.scale or 1.0)
        --Size of Glow Proxy Geometry
        light:SetKeyValue("spawnflags", 1)

        -- Turn light on
        light:Spawn()
        self.GlowingLights[index] = light
    end
    if (lightData[1] == "dynamiclight") and (power) then
        local light = ents.Create("light_dynamic")
        light:SetParent(self)

        -- Set position
        light:SetLocalPos(lightData[2])
        light:SetLocalAngles(lightData[3])

        -- Set parameters
        light:SetKeyValue("_light",
            Format("%i %i %i",
                lightData[4].r*brightness,
                lightData[4].g*brightness,
                lightData[4].b*brightness
            )
        )
        light:SetKeyValue("style", 0)
        light:SetKeyValue("distance", lightData.distance or 300)
        light:SetKeyValue("brightness", (lightData.brightness or 2))

        -- Turn light on
        light:Spawn()
        light:Fire("TurnOn","","0")
        self.GlowingLights[index] = light
    end
end

--------------------------------------------------------------------------------
-- Joystick input
--------------------------------------------------------------------------------
function ENT:HandleJoystickInput(ply)
    for k,v in pairs(jcon.binds) do
        if v:GetCategory() == "Metrostroi" then
            local jvalue = Metrostroi.GetJoystickInput(ply,k)
            if (jvalue != nil) and (self.JoystickBuffer[k] ~= jvalue) then
                local inputname = Metrostroi.JoystickSystemMap[k]
                self.JoystickBuffer[k] = jvalue
                if inputname then
                    if type(jvalue) == "boolean" then
                        if jvalue then
                            jvalue = 1.0
                        else
                            jvalue = 0.0
                        end
                    end
                    self:TriggerInput(inputname,jvalue)
                end
            end
        end
    end
end




--------------------------------------------------------------------------------
-- Keyboard input
--------------------------------------------------------------------------------
function ENT:IsModifier(key)
    return type(self.KeyMap[key]) == "table"
end

function ENT:HasModifier(key)
    return self.KeyMods[key] ~= nil
end

function ENT:GetActiveModifiers(key)
    local tbl = {}
    local mods = self.KeyMods[key]
    for k,v in pairs(mods) do
        if self.KeyBuffer[k] ~= nil then
            table.insert(tbl,k)
        end
    end
    return tbl
end

function ENT:OnKeyEvent(key,state,ply,helper)
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
function ENT:OnKeyPress(key)

end

function ENT:OnKeyRelease(key)

end

function ENT:ProcessKeyMap()
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

function ENT:HandleKeyboardInput(ply)
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
hook.Add("PlayerButtonUp","metrostroi_button",function(ply, button)
    local train,seat = ply:GetTrain()
    if IsValid(train) and train.KeyBuffer then
        if train.KeyBuffer[button] then
            train.KeyBuffer[button] = nil
            train:OnKeyEvent(button,false,ply,train.DriverSeat ~= seat)
        end
    end
end)
hook.Add("PlayerButtonDown","metrostroi_button",function(ply, button)
    local train,seat = ply:GetTrain()
    if IsValid(train) and train.KeyBuffer then
        if train.KeyBuffer[button] == nil then
            train.KeyBuffer[button] = true
            train:OnKeyEvent(button,true,ply,train.DriverSeat ~= seat)
        end
    end
end)

function ENT:CreateJointSound(sndnum)
    local jID = self.SpeedSign>0 and 1 or #self.JointPositions
    table.insert(self.Joints,
        {
            type = sndnum,
            state = jID,
            dist = self.JointPositions[jID]
        }
    )
end

--------------------------------------------------------------------------------
-- Process Cabin button and keyboard input
--------------------------------------------------------------------------------
function ENT:OnButtonPress(button,ply)
end

function ENT:OnButtonRelease(button)

end

-- Clears the serverside keybuffer and fires events
function ENT:ClearKeyBuffer()
    for k,v in pairs(self.KeyBuffer) do
        local button = self.KeyMap[k]
        if button ~= nil then
            if type(button) == "string" then
                self:ButtonEvent(button,false)
            else
                --Check modifiers as well
                for k2,v2 in pairs(button) do
                    self:ButtonEvent(v2,false)
                end
            end
        end
    end
    self.KeyBuffer = {}
end

local function ShouldWriteToBuffer(buffer,state)
    if state == nil then return false end
    if state == false and buffer == nil then return false end
    return true
end

local function ShouldFireEvents(buffer,state)
    if state == nil then return true end
    if buffer == nil and state == false then return false end
    return (state ~= buffer)
end

-- Checks a button with the buffer and calls
-- OnButtonPress/Release as well as TriggerInput

function ENT:ButtonEvent(button,state,ply)
    if ShouldFireEvents(self.ButtonBuffer[button],state) then
        if state == false then
            if self:OnButtonRelease(button,ply) then return end
            self:TriggerInput(button,0.0)
        else
            if self:OnButtonPress(button,ply) then return end
            self:TriggerInput(button,1.0)
            if self.Plombs and button:sub(-2,-1) == "Pl" and self.Plombs[button:sub(1,-3)]  then
                local plomb = self.Plombs[button:sub(1,-3)]
                self:BrokePlomb(button:sub(1,-3),ply)
                if type(plomb) == "table" then
                    for i=2,#plomb do
                        self:BrokePlomb(plomb[i],ply,i>1)
                    end
                end
                self:PlayOnce("plomb","cabin",0.7)
            end
        end
    end

    if ShouldWriteToBuffer(self.ButtonBuffer[button],state) then
        self.ButtonBuffer[button]=state
    end
end

function ENT:Think()

self.PrevTime = self.PrevTime or CurTime()
    self.DeltaTime = (CurTime() - self.PrevTime)
    self.PrevTime = CurTime()
    -- Apply mass of passengers
    if self.NormalMass then self:GetPhysicsObject():SetMass(self.NormalMass + 60*self:GetNW2Float("PassengerCount")) end
    if self.AnnouncementToLeaveWagon and self:GetNW2Float("PassengerCount") == 0  then self.AnnouncementToLeaveWagon = false end
    -- Process the keymap for modifiers
    -- TODO: Need a neat way of calling this once after self.KeyMap is populated
    if not self.KeyMods and self.KeyMap then
        self:ProcessKeyMap()
    end

    -- Keyboard input is done via PlayerButtonDown/Up hooks that call ENT:OnKeyEvent
    -- Joystick input
    if IsValid(self.DriverSeat) then
        local ply = self.DriverSeat:GetPassenger(0)

        if IsValid(ply) then
            --if self.KeyMap then self:HandleKeyboardInput(ply) end
            if joystick then self:HandleJoystickInput(ply) end
            self:SetNW2Bool("GoldenReverser",IsValid(ply) and IsValid(ply:GetWeapon("train_kv_wrench_gold")))
        end
    if self.Plombs and self.Plombs.Init then
        for k,v in pairs(self.Plombs) do
            if k == "Init" then continue end
            if self.Plombs.Init then
                --self[k]:TriggerInput("Reset",true)
                self[k]:TriggerInput("Block",true)
            end
            if type(v) == "table" then
                self:SetPackedBool(k.."Pl",v[1])
            else
                self:SetPackedBool(k.."Pl",v)
            end
        end
        self.Plombs.Init = nil
    end
    end
end	

--------------------------------------------------------------------------------
-- Handle cabin buttons
--------------------------------------------------------------------------------
-- Receiver for CS buttons, Checks if people are the legit driver and calls buttonevent on the train
net.Receive("metrostroi-mouse-move", function(len, ply)
    local train = net.ReadEntity()
    if not IsValid(train) then return end
    if train.CursorMove then
        local sys = net.ReadString()
        local dX = net.ReadFloat()
        local dY = net.ReadFloat()
        train:CursorMove(sys,dX,dY)
    end
end)

net.Receive("metrostroi-cabin-button", function(len, ply)
    local train = net.ReadEntity()
    local button = net.ReadString()
    local eventtype = net.ReadBit()
    local seat = ply:GetVehicle()
    local outside = net.ReadBool()
    if outside then
        if not IsValid(train) then return end
        if outside and (train.CPPICanPickup and not train:CPPICanPickup(ply)) then return end
        if not outside and ply != train.DriverSeat.lastDriver then return end
        if not outside and train.DriverSeat.lastDriverTime and (CurTime() - train.DriverSeat.lastDriverTime) > 1 then return end
    else
        if not IsValid(train) then return end
        if (seat != train.DriverSeat) and (seat != train.InstructorsSeat) and (train.CPPICanPhysgun and not train:CPPICanPhysgun(ply)) and not button:find("Door") then return end
    end
    train:ButtonEvent(button,(eventtype > 0),ply)
end)

-- Receiver for panel touchs, Checks if people are the legit driver and calls buttonevent on the train
net.Receive("metrostroi-panel-touch", function(len, ply)
    local panel = net.ReadString()
    local x = net.ReadInt(11)
    local y = net.ReadInt(11)
    local outside = net.ReadBool()
    local state = net.ReadBool()
    local seat = ply:GetVehicle()
    local train

    if seat and IsValid(seat) and not outside then
        -- Player currently driving
        train = seat:GetNW2Entity("TrainEntity")
        if (not train) or (not train:IsValid()) then return end
        if (seat != train.DriverSeat) and (seat != train.InstructorsSeat) and not train:CPPICanPhysgun(ply) then return end
    else
        -- Player not driving, check recent train
        train = IsValid(ply.lastVehicleDriven) and ply.lastVehicleDriven:GetNW2Entity("TrainEntity") or NULL
        if outside then
            local trace = util.TraceLine({
                start = ply:EyePos(),
                endpos = ply:EyePos() + ply:EyeAngles():Forward() * 100,
                filter = function( ent ) if ent:GetClass():find("subway") then return true end end
            })
            train = trace.Entity
        end
        if !IsValid(train) then return end
        if outside and train.CPPICanPickup and not train:CPPICanPickup(ply) then return end
        if not outside and ply != train.DriverSeat.lastDriver then return end
        if not outside and train.DriverSeat.lastDriverTime and (CurTime() - train.DriverSeat.lastDriverTime) > 1 then return end
    end
    if panel == "" and train.PanelTouch then train:PanelTouch(state,x,y) return end
    if panel ~= "" and not train[panel] then print("Metrostroi:System not found,"..panel) return end
    if panel ~= "" and not train[panel].Touch then print("Metrostroi:Touch function not found in system "..panel) return end
    if panel ~= "" then train[panel]:Touch(state,x,y) else train:Touch(state,x,y) end
end)

-- Denies entry if player recently sat in the same train seat
-- This prevents getting stuck in seats when trying to exit
local function CanPlayerEnter(ply,vec,role)
    local train = vec:GetNW2Entity("TrainEntity")

    if IsValid(train) and IsValid(ply.lastVehicleDriven) and ply.lastVehicleDriven.lastDriverTime != nil then
        if CurTime() - ply.lastVehicleDriven.lastDriverTime < 1 then return false end
    end
end 

net.Receive("MetrostroiBindPress",function()
    local ent = net.ReadEntity()
    local bind = net.ReadString()
    if IsValid(ent) and ent.OnKeyEvent then
        ent:OnKeyEvent(bind,true)
        ent:OnKeyEvent(bind,false)
    end
end)
function ENT:BrokePlomb(but,ply,nosnd)
    if ply then
        local nomsg,noplomb = hook.Run("MetrostroiPlombBroken",self,but,ply)
        if noplomb then return end
        if not nosnd and not nomsg then RunConsoleCommand("say",ply:GetName().." broke seal on "..but.."!") end
    end
    self[but]:TriggerInput("Block",false)
    self.Plombs[but] = false
    self:SetPackedBool(but.."Pl",false)
end

if game.SinglePlayer() then
    util.AddNetworkString("PlayerButtonDown_metrostroi")
    util.AddNetworkString("PlayerButtonUp_metrostroi")
    hook.Add("PlayerButtonDown","metrostori_button",function(ply,button)
        if not IsFirstTimePredicted() then return end
        net.Start("PlayerButtonDown_metrostroi")
            net.WriteUInt(button,16)
        net.Send(ply)
    end)
    hook.Add("PlayerButtonUp","metrostori_button",function(ply,button)
        if not IsFirstTimePredicted() then return end
        net.Start("PlayerButtonUp_metrostroi")
            net.WriteUInt(button,16)
        net.Send(ply)
    end)
end