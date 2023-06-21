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

--[[ENT.ClientProps = {}
ENT.ButtonMap = {}
ENT.AutoAnims = {}
ENT.ClientSounds = {}
ENT.ClientPropsInitialized = false

ENT.ClientProps["salonR"] = {
	model = "models/metrostroi_train/81-740/salon/salon_rear.mdl",
    pos = Vector(-211.2, 0, 5.5),
    ang = Angle(0,180,0),
	hide = 2,
}
ENT.ButtonMap["Tickers_rear"] = {
		pos = Vector(286.2,27,65.85), --446 -- 14 -- -0,5
		ang = Angle(0,-90,90),
		width = 1024,
		height = 64,
		scale = 0.054,
		hide=true,
		hideseat=1,		
}

function ENT:Think()
    self.BaseClass.Think(self)
	self:HidePanel("Tickers_rear",Tickers_rear)
end]]

--[[function ENT:Initialize() --не работает, ибо нужна "экранизация"
	self.BaseClass.Initialize(self)
    self.Tickers = self:CreateRT("740Ticker",1024,64)
    render.PushRenderTarget(self.Tickers,0,0,1024, 64)
    render.Clear(0, 0, 0, 0)
    render.PopRenderTarget()
end

function ENT:Draw()
    self.BaseClass.Draw(self)
    local Pricep740 = self:GetNW2Entity("gmod_subway_81-740_4_mvm")
	self.RTMaterial:SetTexture("$basetexture", self.Tickers)		
    self:DrawOnPanel("Tickers_rear",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(512,32+8,1024+16,64+16,0)
    end)
end]]


--[[function ENT:DrawPost(special)
end
Metrostroi.GenerateClientProps()]]