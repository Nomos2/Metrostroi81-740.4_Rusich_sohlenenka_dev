--отображение номера маршрута и конечной станции на табло

Metrostroi.DefineSystem("81_740_4router")

TRAIN_SYSTEM.DontAccelerateSimulation = true
if TURBOSTROI then return end
if CLIENT then
	local function ShortingString(str)
		if utf8.len(str) <= 11 - 1 then return str end
	end

	local function GetLastStation(self)
		if not Metrostroi.StationConfigurations or not Metrostroi.ASNPSetup then
			return "ИСПЫТАНИЯ"
		else
			if self.ASNPState < 7 then return "ИСПЫТ̶́А̵̢͍͖͕̹̥̫̃̒̌͝НИ̸̼̮̥͙͚̝̖̞̯̼̅͐̿Я̷̡̨̨̬̥̖̪̻̩̝̣̝̙͆́̃̃͂̓̄͛ͅͅ" end
			local Selected = Metrostroi.ASNPSetup[self:GetNW2Int("Announcer",0)] or nil
			local Line = Selected and Selected[self:GetNW2Int("ASNP:Line",0)] or nil
			local Path = self:GetNW2Bool("ASNP:Path",false)
			local Station = Line and (not Path and Line[self:GetNW2Int("ASNP:LastStation",0)] or Path and Line[self:GetNW2Int("ASNP:FirstStation",0)]) or nil		--красивый враиант. Спереди показывается одна станция, сзади другая
			--local Station = Line and Line[self:GetNW2Int("ASNP:LastStation",0)] or nil		--вариант, как в реальности. То есть и спереди и сзади одна и та же станция
			if Station then Station = Station[2] or nil end
			--PrintTable(Station)
			if Line and not Station then Station = "МАРШРУТ" end
			if Station then return Station else return "ошибка?" end
		end
	end
	
	--local maxdist = 1024 * 1024 *2 *2 *2 *2 *2

	function TRAIN_SYSTEM:ClientInitialize()
		local self = self.Train
		self.GettedLastStation = ""
		self.LastGettedLastStation = 0
		self.ASNPState = self:GetNW2Int("ASNP:State",-1)
		self.ButtonMap["InfoScreen"] = {
			pos = Vector(656.5,-35,61.4),
			ang = Angle(0,90,90),
			width = 700,
			height = 100,
			scale = 0.1,
		}
	function TRAIN_SYSTEM:ClientDraw()
        --RunConsoleCommand("say", "ура работаёт")
		local self = self.Train
		--if not self.DistanceToPlayer or self.DistanceToPlayer > maxdist then return end
		
		if os.time() - self.LastGettedLastStation > 1 then
			self.LastGettedLastStation = os.time()
			self.ASNPState = self:GetNW2Int("ASNP:State",-1)
			self.GettedLastStation = ShortingString(GetLastStation(self)) --GetLastStation(self)
		end
		--if self.ASNPState < 1 then return end
		self:DrawOnPanel("InfoScreen",function()
			--surface.SetAlphaMultiplier(1)
			--surface.SetDrawColor(0,0,0) --255*dc.x,250*dc.y,220*dc.z)
			--surface.DrawRect(2,100,88,70)
			local rn = Format("%02d",self:GetNW2Int("ASNP:RouteNumber","00"))
			--print(self:GetNW2Int("RouteNumber1"))
				draw.Text({
					text = drawnrn,
					font = "Metrostroi_740_router", -- "Metrostroi_740_routerBold"
					pos = { 70, 53 },
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_CENTER,
					color = color})
					text = text,
					font = "Metrostroi_740_router",
					pos = { 350, 53 },
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_CENTER,
					color = color})
		end)