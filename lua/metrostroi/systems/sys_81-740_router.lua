--отображение номера маршрута и конечной станции на табло

Metrostroi.DefineSystem("81_740_router")

TRAIN_SYSTEM.DontAccelerateSimulation = true
if TURBOSTROI then return end
if CLIENT then	local function createFont(name,font,size,weight,blur,scanlines,underline)    surface.CreateFont("Metrostroi_740_"..name, {        font = font,        size = size,        weight = weight or 400,        blursize = blur or false,        antialias = true,        underline = underline,        italic = false,        strikeout = false,        symbol = false,        rotary = false,        shadow = false,        additive = false,        outline = false,        extended = true,        scanlines = scanlines or false,    })  end  createFont("router","bmt09_fix",242,200,0,0,false)
	local function ShortingString(str)	
		if #str <= 14*2 - 1 then return str end
		local sogltbl = {"б","в","г","д","ж","з","к","л","м","н","п","р","с","т","ф","х","ц","ч","ш","щ"}				local startpos = ""
		for i = 16, #str do
			for k,v in pairs(sogltbl) do
				local startpos = string.find(str,v,i)
				if startpos then 
					if startpos <= 14*2 then 
						return string.sub(str,1,startpos + 1).."." 
					end
				end
			end
		end
		return str
	end

	local function GetLastStation(self)
		if not Metrostroi.StationConfigurations or not Metrostroi.ASNPSetup then
			return "испытания"
		else			if os.date( "%m-%d" ) == "04-01" then	
			if self.ASNPState < 7 then return "ведро говна" end			else			if self.ASNPState < 7 then return "испытания" end			end
			local Selected = Metrostroi.ASNPSetup[self:GetNW2Int("Announcer",0)] or nil
			local Line = Selected and Selected[self:GetNW2Int("ASNP:Line",0)] or nil
			local Path = self:GetNW2Bool("ASNP:Path",false)
			local Station = Line and (not Path and Line[self:GetNW2Int("ASNP:LastStation",0)] or Path and Line[self:GetNW2Int("ASNP:FirstStation",0)]) or nil		--красивый враиант. Спереди показывается одна станция, сзади другая
			--local Station = Line and Line[self:GetNW2Int("ASNP:LastStation",0)] or nil		--вариант, как в реальности. То есть и спереди и сзади одна и та же станция
			if Station then Station = Station[2] or nil end
			--PrintTable(Station)
			if Line and not Station then Station = "маршрут" end
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
			pos = Vector(800.7,-35,61.4),
			ang = Angle(0,90,90),
			width = 1080,
			height = 172,
			scale = 0.065,
		}	end	
	function TRAIN_SYSTEM:ClientDraw()
        --RunConsoleCommand("say", "ура работаёт")
		local self = self.Train
		--if not self.DistanceToPlayer or self.DistanceToPlayer > maxdist then return end
		
		if os.time() - self.LastGettedLastStation > 1 then
			self.LastGettedLastStation = os.time()
			self.ASNPState = self:GetNW2Int("ASNP:State",-1)
			self.GettedLastStation = ShortingString(GetLastStation(self)) --GetLastStation(self)
		end			--print(self.ASNPState)
		--if self.ASNPState < 1 then return end		--[[if train.RouteNumber then			route = train.RouteNumber.RouteNumber		end]]								
		self:DrawOnPanel("InfoScreen",function()
			--surface.SetAlphaMultiplier(1)
			--surface.SetDrawColor(0,0,0) --255*dc.x,250*dc.y,220*dc.z)
			--surface.DrawRect(2,100,88,70)
			local rn = Format("%02d",self:GetNW2Int("ASNP:RouteNumber","00"))				--text		if self:GetNW2Int("740RouterPower") > 62 then 		    if self.ASNPState <= 0 then 				color = Color(47,85,16, 9)			else				color = Color(150,255,70)			end						if self.ASNPState < 2 and self.ASNPState > 0 then 				text = self.GettedLastStation 			end						if self.ASNPState > 2 then 				if string.len(self.GettedLastStation) > 26 then 					if  math.mod(string.len(self.GettedLastStation), 2) == 0 then 						text = rn.."   ".. string.sub(self.GettedLastStation, 1,26) 					else																					text = rn.."   ".. string.sub(self.GettedLastStation, 1,27) 					end				else					text = rn.."   "..self.GettedLastStation 				end								if self.GettedLastStation == "маршрут" then 					text = self.GettedLastStation.."   "..rn 				end			end		--end					--[[last_message = text						if self:GetNW2Int("740RouterPower") > 62 then				color = Color(141,255,49) --on			else				color = Color(47,85,16) --off			end						if self:GetNW2Int("740RouterPower") > 62 then				else				text = last_message			end]]
			--print(self:GetNW2Int("RouteNumber1"))
			draw.Text({
				text = text,
				font = "Metrostroi_740_router",--..self:GetNWInt("Style",1),
				pos = { 540, 66.5 },
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				color = color})		end
		end)	end	else	function TRAIN_SYSTEM:Think(dT)		local Train = self.Train		Train:SetNW2Int("740RouterPower",Train.Electric.Battery80V)		endend