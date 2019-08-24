local padding = ScreenScale(32)
-- create character panel
DEFINE_BASECLASS("ixCharMenuPanel")
local PANEL = {}

function PANEL:Init()
	local parent = self:GetParent()
	local halfWidth = parent:GetWide() * 0.5 - (padding * 2)
	local halfHeight = parent:GetTall() * 0.5 - (padding * 2)
	self:ResetPayload(true)
	self.bNoBackgroundBlur = true
	self.factionButtons = {}
	self.repopulatePanels = {}
	-- faction selection subpanel
	self.factionPanel = self:AddSubpanel("faction", true)
	self.factionPanel:SetTitle("Factions")
	self.factionPanel.OnSetActive = function()
		-- if we only have one faction, we are always selecting that one so we can skip to the description section
		if (#self.factionButtons == 1) then
			self:SetActiveSubpanel("description", 0)
		end
	end

	local modelList = self.factionPanel:Add("Panel")
	modelList:Dock(RIGHT)
	modelList:SetSize(halfWidth + padding * 2, halfHeight)

	local proceed = modelList:Add("ixMenuButton")
	proceed:SetText("proceed")
	proceed:SetContentAlignment(6)
	proceed:Dock(BOTTOM)
	proceed.DoClick = function()
		self.progress:IncrementProgress()

		self:Populate()
		self:SetActiveSubpanel("description")
	end

	self.factionModel = modelList:Add("ixModelPanel")
	self.factionModel:Dock(FILL)
	self.factionModel:SetModel("models/error.mdl")
	self.factionModel:SetFOV(78)
	self.factionModel.PaintModel = self.factionModel.Paint
	self.factionButtonsPanel = self.factionPanel:Add("ixCharMenuButtonList")
	self.factionButtonsPanel:SetWide(halfWidth)
	self.factionButtonsPanel:Dock(LEFT)

	local factionBack = self.factionButtonsPanel:Add("ixMenuButton")
	factionBack:SetText("return")
	factionBack.DoClick = function()
		self.progress:DecrementProgress()

		self:SetActiveSubpanel("faction", 0)
		self:SlideDown()

		parent.mainPanel:Undim()
	end

	-- character customization subpanel
	self.description = self:AddSubpanel("description")
	self.description:SetTitle("customise")

	local descriptionModelList = self.description:Add("Panel")
	descriptionModelList:Dock(RIGHT)
	descriptionModelList:SetSize(halfWidth, ScrH() + padding * 2)
	self.descriptionModel = descriptionModelList:Add("ixModelPanel")
	self.descriptionModel:Dock(FILL)
	self.descriptionModel:SetModel("models/outerrimrp/playermodels/male_merc1.mdl")
	self.descriptionModel:SetFOV(55)


	self.descriptionModel:SetCamPos( Vector( 50,50,50 ) ) -- 50 50 50 IS DEFAULT
	self.descriptionModel.PaintModel = self.descriptionModel.Paint

	self.descriptionPanel = self.description:Add("Panel")
	self.descriptionPanel:SetWide(halfWidth + padding * 2)
	self.descriptionPanel:Dock(LEFT)
	
	self.descriptionModel2 = descriptionModelList:Add("ixModelPanel")
	self.descriptionModel2:Dock(FILL)
	self.descriptionModel2:SetModel("models/tnb/techcom/male_02.mdl")
	
	local head = self.descriptionModel2:GetEntity()
    local scale = Vector(1,1,1)*0.001
    local count = head:GetBoneCount()
	head:SetParent(self.descriptionModel:GetEntity(),1)	
    for i = 0, count - 1 do
        if (i ~= head:LookupBone("ValveBiped.Bip01_Head1")) then
            if(i == head:LookupBone("ValveBiped.Bip01_Neck1")) then
                head:ManipulateBoneScale(i, head:GetManipulateBoneScale(i) * Vector(1,1,1)*0.5)
            else
                head:ManipulateBoneScale(i, head:GetManipulateBoneScale(i) * scale)
            end
        end
    end
    head:AddEffects(EF_BONEMERGE)
	
	self.descriptionModel2:SetFOV(55)
	self.descriptionModel2:GetEntity():SetParent(self.descriptionModel:GetEntity(),1)
	self.descriptionModel2:GetEntity():AddEffects(EF_BONEMERGE)
	self.descriptionModel2:SetCamPos( Vector( 50,50,50 ) ) -- 50 50 50 IS DEFAULT 60 15 50
	self.descriptionModel2.PaintModel = self.descriptionModel2.Paint

	local descriptionBack = descriptionModelList:Add("ixMenuButton")
	descriptionBack:SetText("return")
	descriptionBack:SetContentAlignment(4)
	descriptionBack:Dock(BOTTOM)
	descriptionBack.DoClick = function()
		self.progress:DecrementProgress()
		if (#self.factionButtons == 1) then
			factionBack:DoClick()
		else
			self:SetActiveSubpanel("faction")
		end
	end
	
	local descriptionProceed = self.descriptionPanel:Add("ixMenuButton")
	descriptionProceed:SetText("proceed")
	descriptionProceed:SetContentAlignment(6)
	descriptionProceed:Dock(BOTTOM)
	descriptionProceed.DoClick = function()
		if (self:VerifyProgression("description")) then
			-- there are no panels on the attributes section other than the create button, so we can just create the character
			if (#self.attributesPanel:GetChildren() < 2) then
				self.payload:Set("headmodel",self.descriptionModel2:GetModel())
				self.payload:Set("outfitpath",self.descriptionModel:GetModel())
				local bgs = self.descriptionModel:GetEntity():GetBodyGroups()
				local bgcount = self.descriptionModel:GetEntity():GetNumBodyGroups()
				local bgtable = {}
				for k,v in pairs(bgs) do
					if self.descriptionModel:GetEntity():GetBodygroup(v.id) > 0 then
						bgtable[v.name] = {v.id, self.descriptionModel:GetEntity():GetBodygroup(v.id)}
					end
				end
				self.payload:Set("bgtable", bgtable)
				self:SendPayload()
				return
			end
			self.progress:IncrementProgress()
			self:SetActiveSubpanel("attributes")
		end
	end
	local sliders = {}
	local dermaSliders = {}
	local bg = self.descriptionModel:GetEntity():GetBodyGroups()
	local _loopIndex = 0 
	for a,b in pairs(bg) do
		sliders[b.name]={["x"]=425,["y"]=_loopIndex*31,["bodygroupIndex"]=b.id,["display"]=b.name,["bgNum"]=b.num}
		_loopIndex=_loopIndex+1
	end
	self.headPanel = self.descriptionPanel:Add("DScrollPanel")
	for _,_v in pairs(sliders) do
		if _v.bgNum >= 2 then
			local rightbutton = self.descriptionModel:Add("ixMenuButton")
			rightbutton:SetPos( Scaling(_v.x,_v.y,1) )
			rightbutton:SetSize( 30, 30 )
			
			local _bgIndex = 0
			rightbutton.DoClick = function()
				if _bgIndex < _v.bgNum then
					_bgIndex = _bgIndex + 1
					self.descriptionModel:GetEntity():SetBodygroup(_v.bodygroupIndex,_bgIndex)
				end
			end	
			
			local leftbutton = self.descriptionModel:Add("ixMenuButton")
			leftbutton:SetPos( Scaling(_v.x - 375,_v.y,1))
			leftbutton:SetSize( 30, 30 )
			leftbutton.DoClick = function()
				if _bgIndex >= 1 then
					_bgIndex = _bgIndex - 1
					self.descriptionModel:GetEntity():SetBodygroup(_v.bodygroupIndex,_bgIndex)
				end
			end
		end
	end
	
	self.headPanel = self.descriptionPanel:Add("DScrollPanel")
	self.headPanel:SetPos(310,255)
	self.headPanel:SetSize(300,ScrH()*(250/1080))
	self.itemPanel = self.descriptionPanel:Add("DScrollPanel")
	self.itemPanel:SetPos(0,0)
	self.itemPanel:SetSize(300,ScrH()*(250/1080))
	self.skinPanel = self.descriptionPanel:Add("DScrollPanel")
	self.skinPanel:SetPos(310,0)
	self.skinPanel:SetSize(300,ScrH()*(250/1080))

	self.descriptionModelButtons = self:Add("Panel")
	self.descriptionModelButtons:SetPos(ScrW()/2,200)
	self.descriptionModelButtons:SetSize(ScrW() * 1000/1920,ScrH() * 600/1080)

	-- attributes subpanel
	self.attributes = self:AddSubpanel("attributes")
	self.attributes:SetTitle("chooseSkills")

	local attributesModelList = self.attributes:Add("Panel")
	attributesModelList:Dock(LEFT)
	attributesModelList:SetSize(halfWidth, halfHeight)

	local attributesBack = attributesModelList:Add("ixMenuButton")
	attributesBack:SetText("return")
	attributesBack:SetContentAlignment(4)
	attributesBack:Dock(BOTTOM)
	attributesBack.DoClick = function()
		self.progress:DecrementProgress()
		self:SetActiveSubpanel("description")
	end
	self.attributesModel = attributesModelList:Add("ixModelPanel")
	self.attributesModel:Dock(FILL)
	--self.attributesModel:SetModel(self.factionModel:GetModel())
	self.attributesModel:SetFOV(65)
	self.attributesModel.PaintModel = self.attributesModel.Paint

	self.attributesPanel = self.attributes:Add("Panel")
	self.attributesPanel:SetWide(halfWidth + padding * 2)
	self.attributesPanel:Dock(RIGHT)

	local create = self.attributesPanel:Add("ixMenuButton")
	create:SetText("finish")
	create:SetContentAlignment(6)
	create:Dock(BOTTOM)
	create.DoClick = function()
		self:SendPayload()
	end

	-- creation progress panel
	self.progress = self:Add("ixSegmentedProgress")
	self.progress:SetBarColor(ix.config.Get("color"))
	self.progress:SetSize(parent:GetWide(), 0)
	self.progress:SizeToContents()
	self.progress:SetPos(0, parent:GetTall() - self.progress:GetTall())

	-- setup payload hooks
	self:AddPayloadHook("model", function(value) 
		local faction = ix.faction.indices[self.payload.faction]

		if (faction) then
			local model = faction.models or "models/outerrimrp/playermodels/male_merc1.mdl"
			-- assuming bodygroups
			if (istable(model)) then
				self.factionModel:SetModel(model[1])
				--self.descriptionModel:SetModel(model[1], model[2] or 0, model[3])
				self.attributesModel:SetModel(model[1])
			else
				self.factionModel:SetModel(model)
				--self.descriptionModel:SetModel(model)
				self.attributesModel:SetModel(model)
			end
		end
	end)

	-- setup character creation hooks
	net.Receive("ixCharacterAuthed", function()
		timer.Remove("ixCharacterCreateTimeout")
		self.awaitingResponse = false

		local id = net.ReadUInt(32)
		local indices = net.ReadUInt(6)
		local charList = {}

		for _ = 1, indices do
			charList[#charList + 1] = net.ReadUInt(32)
		end

		ix.characters = charList

		self:SlideDown()

		if (!IsValid(self) or !IsValid(parent)) then
			return
		end

		if (LocalPlayer():GetCharacter()) then
			parent.mainPanel:Undim()
			parent:ShowNotice(2, L("charCreated"))
		elseif (id) then
			self.bMenuShouldClose = true

			net.Start("ixCharacterChoose")
				net.WriteUInt(id, 32)
			net.SendToServer()
		else
			self:SlideDown()
		end
	end)

	net.Receive("ixCharacterAuthFailed", function()
		timer.Remove("ixCharacterCreateTimeout")
		self.awaitingResponse = false

		local fault = net.ReadString()
		local args = net.ReadTable()

		self:SlideDown()

		parent.mainPanel:Undim()
		parent:ShowNotice(3, L(fault, unpack(args)))
	end)
end

function PANEL:SendPayload()
	if (self.awaitingResponse or !self:VerifyProgression()) then
		return
	end

	self.awaitingResponse = true

	timer.Create("ixCharacterCreateTimeout", 10, 1, function()
		if (IsValid(self) and self.awaitingResponse) then
			local parent = self:GetParent()

			self.awaitingResponse = false
			self:SlideDown()

			parent.mainPanel:Undim()
			parent:ShowNotice(3, L("unknownError"))
		end
	end)

	self.payload:Prepare()

	net.Start("ixCharacterCreate")
		net.WriteTable(self.payload)
	net.SendToServer()
end

function PANEL:OnSlideUp()
	self:ResetPayload()
	self:Populate()
	self.progress:SetProgress(1)

	-- the faction subpanel will skip to next subpanel if there is only one faction to choose from,
	-- so we don't have to worry about it here
	self:SetActiveSubpanel("faction", 0)
end

function PANEL:OnSlideDown()
end

function PANEL:ResetPayload(bWithHooks)
	if (bWithHooks) then
		self.hooks = {}
	end

	self.payload = {}

	-- TODO: eh..
	function self.payload.Set(payload, key, value)
		self:SetPayload(key, value)
	end

	function self.payload.AddHook(payload, key, callback)
		self:AddPayloadHook(key, callback)
	end

	function self.payload.Prepare(payload)
		self.payload.Set = nil
		self.payload.AddHook = nil
		self.payload.Prepare = nil
	end
end

function PANEL:SetPayload(key, value)
	self.payload[key] = value
	self:RunPayloadHook(key, value)
end

function PANEL:AddPayloadHook(key, callback)
	if (!self.hooks[key]) then
		self.hooks[key] = {}
	end

	self.hooks[key][#self.hooks[key] + 1] = callback
end

function PANEL:RunPayloadHook(key, value)
	local hooks = self.hooks[key] or {}

	for _, v in ipairs(hooks) do
		v(value)
	end
end

function PANEL:GetContainerPanel(name)
	-- TODO: yuck
	if (name == "description") then
		return self.descriptionPanel
	elseif (name == "attributes") then
		return self.attributesPanel
	end

	return self.descriptionPanel
end

function PANEL:AttachCleanup(panel)
	self.repopulatePanels[#self.repopulatePanels + 1] = panel
end
function Scaling(x1,y1,typeOfScale)
  if typeOfScale == 0 then
    x,y=ScrW(),ScrH()
    elseif typeOfScale == 1 then  x,y = ScrW(),ScrW()
    else  x,y = ScrH(),ScrH()
    end
 	x,y = x*0.01,y*0.01
 	x = x1* x
 	y = y1* y
 	return x,y
 	
end
function PANEL:SetupModelButtons()
	self.itemPanel:Clear()
	for k, v in pairs(ix.item.list) do
		if (v.isClothing and !v.skin) then
			local lastSelected
			local faction
			for _, v in pairs(self.factionButtons) do
				if (v:GetSelected()) then
					lastSelected = v.faction
					faction = ix.faction.indices[lastSelected]
				end
			end
			if (faction) then
				local model = faction.models
				if table.HasValue(model, v.playermodel) then
					local button = self.itemPanel:Add("ixMenuButton")
					button:SetFont("zeusFontOne")
					button:Dock(TOP)
					button:SetText(v.name)
					button.DoClick = function()
						self.descriptionModel:GetEntity():SetModel(v.playermodel)
						self.payload:Set("outfitname", v.uniqueID)
						self.descriptionModel:SetAnimated(true)
						local idleanim = self.descriptionModel:GetEntity():LookupSequence("idle_all_01")
						self.descriptionModel:GetEntity():SetSequence( idleanim )
						self.currentSelection = v.name
						self:RefreshModelSkins()
					end	
				end
			end
		end
	end
end
function PANEL:RefreshModelSkins()
	local HeadTable = 
	{
    "models/tnb/techcom/male_02.mdl", -- male heads
    "models/tnb/techcom/male_01.mdl",
    "models/tnb/techcom/male_03.mdl",
    "models/tnb/techcom/male_04.mdl",
    "models/tnb/techcom/male_05.mdl",
    "models/tnb/techcom/male_06.mdl",
    "models/tnb/techcom/male_07.mdl",
    "models/tnb/techcom/male_08.mdl",
    "models/tnb/techcom/male_09.mdl",
	"models/tnb/techcom/male_10.mdl",
	"models/outerrimrp/playermodels/heads/female_twilek_01.mdl", -- alien heads
    "models/hcn/starwars/bf/abednedo/abednedo.mdl",
    "models/hcn/starwars/bf/aqualish/aqualish.mdl",
    "models/hcn/starwars/bf/bossk/bossk.mdl",
    "models/hcn/starwars/bf/ishitib/ishitib.mdl",
    "models/hcn/starwars/bf/quarren/quarren.mdl",
    "models/hcn/starwars/bf/rodian/rodian.mdl",
    "models/hcn/starwars/bf/sullustan/sullustan.mdl",
    "models/hcn/starwars/bf/zabrak/zabrak.mdl",
    "models/nate159/swbf/hero/player/hero_gunslinger_greedo_player.mdl",
    "models/tnb/techcom/female_01.mdl",    -- Female heads
    "models/tnb/techcom/female_02.mdl",
    "models/tnb/techcom/female_03.mdl",
    "models/tnb/techcom/female_04.mdl",
    "models/tnb/techcom/female_05.mdl",
    "models/tnb/techcom/female_06.mdl",
    "models/tnb/techcom/female_08.mdl",
    "models/tnb/techcom/female_09.mdl",
    "models/tnb/techcom/female_10.mdl",
    "models/tnb/techcom/male_11.mdl",       -- More Male Heads
    "models/tnb/techcom/male_12.mdl",
    "models/tnb/techcom/male_14.mdl",
    "models/tnb/techcom/male_15.mdl",
    "models/tnb/techcom/male_16.mdl",
    "models/tnb/techcom/male_17.mdl",
    "models/tnb/techcom/male_18.mdl",
    "models/tnb/techcom/male_19.mdl",
    "models/tnb/techcom/male_21.mdl",
    "models/tnb/techcom/male_22.mdl",
    "models/tnb/techcom/male_23.mdl",
    "models/tnb/techcom/male_24.mdl",
    "models/tnb/techcom/male_25.mdl",
    "models/tnb/techcom/male_26.mdl",
    "models/tnb/techcom/male_27.mdl",
    "models/tnb/techcom/male_28.mdl",
    "models/tnb/techcom/male_29.mdl",
    "models/tnb/techcom/male_30.mdl",
    "models/tnb/techcom/male_31.mdl",
    "models/tnb/techcom/male_32.mdl",
    "models/tnb/techcom/male_33.mdl",
    "models/tnb/techcom/male_34.mdl",
    "models/tnb/techcom/male_35.mdl",
    "models/tnb/techcom/male_36.mdl",
    "models/tnb/techcom/male_37.mdl",
    "models/tnb/techcom/male_38.mdl",
    "models/tnb/techcom/male_39.mdl",
    "models/tnb/techcom/male_40.mdl",
    "models/tnb/techcom/male_41.mdl",
    "models/tnb/techcom/male_42.mdl",
    "models/tnb/techcom/male_43.mdl",
    "models/tnb/techcom/male_44.mdl",
    "models/tnb/techcom/male_45.mdl",
    "models/tnb/techcom/male_46.mdl",
    "models/tnb/techcom/male_47.mdl",
    "models/tnb/techcom/male_48.mdl",
    "models/tnb/techcom/male_49.mdl",
    "models/tnb/techcom/male_50.mdl",
    "models/tnb/techcom/male_51.mdl",
    "models/tnb/techcom/male_52.mdl",
    "models/tnb/techcom/male_53.mdl",
    "models/tnb/techcom/male_54.mdl",
    "models/tnb/techcom/male_55.mdl",
    "models/tnb/techcom/male_56.mdl",
    "models/tnb/techcom/male_57.mdl",
    "models/tnb/techcom/male_58.mdl",
    "models/tnb/techcom/male_59.mdl",
    "models/tnb/techcom/male_60.mdl",
    "models/tnb/techcom/male_61.mdl",
    "models/tnb/techcom/male_62.mdl",
    "models/tnb/techcom/male_63.mdl",
    "models/tnb/techcom/male_64.mdl",
    "models/tnb/techcom/female_11.mdl",     -- More Female Heads
    "models/tnb/techcom/female_12.mdl",
    "models/tnb/techcom/female_13.mdl",
    "models/tnb/techcom/female_14.mdl",
    "models/tnb/techcom/female_15.mdl",
    "models/tnb/techcom/female_17.mdl",
    "models/tnb/techcom/female_18.mdl",
    "models/tnb/techcom/female_19.mdl",
    "models/tnb/techcom/female_20.mdl",
    "models/tnb/techcom/female_21.mdl",
    "models/tnb/techcom/female_24.mdl",
    "models/tnb/techcom/female_25.mdl",
    "models/tnb/techcom/female_27.mdl",
    "models/tnb/techcom/female_28.mdl",
    "models/tnb/techcom/female_29.mdl",
    "models/tnb/techcom/female_30.mdl",
    "models/tnb/techcom/female_31.mdl",
    "models/tnb/techcom/female_32.mdl",
    "models/tnb/techcom/female_33.mdl",
    "models/tnb/techcom/female_34.mdl",
    "models/tnb/techcom/female_35.mdl",
    "models/tnb/techcom/female_36.mdl",
    "models/tnb/techcom/female_37.mdl",
    "models/tnb/techcom/female_38.mdl",
    "models/tnb/techcom/female_39.mdl",
    "models/tnb/techcom/female_41.mdl",
    "models/tnb/techcom/female_42.mdl",
    "models/tnb/techcom/female_43.mdl",
    "models/tnb/techcom/female_44.mdl",
    "models/tnb/techcom/female_45.mdl",
    "models/tnb/techcom/female_46.mdl",
    "models/tnb/techcom/female_47.mdl",
    "models/tnb/techcom/female_48.mdl",
	}
	self.skinPanel:Clear()
	self.headPanel:Clear()
	self.descriptionModelButtons:Clear()
	local sliders = {}
	local dermaSliders = {}
	local bg = self.descriptionModel:GetEntity():GetBodyGroups()

	local i = 1
	print(self.payload.faction)
	local faction = ix.faction.indices[self.payload.faction]
	if faction.uniqueID != "wookie" then 
		for _k, _v in pairs(HeadTable) do
			local button = self.headPanel:Add("ixMenuButton")
			button:Dock(TOP)
			button:SetText("Head " .. tostring(i))
			i = i + 1
			button.DoClick = function()

				self.descriptionModel2:SetModel(_v)
	            local head = self.descriptionModel2:GetEntity()
	            local scale = Vector(1,1,1)*0.001
	            local count = head:GetBoneCount()
				head:SetParent(self.descriptionModel:GetEntity(),1)
				
	            for i = 0, count - 1 do
	                if (i ~= head:LookupBone("ValveBiped.Bip01_Head1")) then
	                	if(i == head:LookupBone("ValveBiped.Bip01_Neck1")) then
	                		head:ManipulateBoneScale(i, head:GetManipulateBoneScale(i) * Vector(1,1,1)*0.5)
	                	else
	                		head:ManipulateBoneScale(i, head:GetManipulateBoneScale(i) * scale)
	                	end
	                end
	            end
	            head:AddEffects(EF_BONEMERGE)
			end
		end
	else
		print("fucking furry")
	end
	local left = Material("materials/charmenu/buttons/left.png")
	local right = Material("materials/charmenu/buttons/right.png")
	local buttons = {}
	local _loopIndex = 0
	for a,b in pairs(bg) do
		if b.num >=2 then
			buttons[b.name]={["x"]=ScrW() * 750/1920,["y"]=_loopIndex*35,["bodygroupIndex"]=b.id,["display"]=b.name,["bgNum"]=b.num}
			_loopIndex=_loopIndex+1
		end
	end
	self.descriptionModel:SetZPos(0)
	for _,_v in pairs(buttons) do
		if _v.bgNum >= 2 then

			local rightbutton = self.descriptionModelButtons:Add("DImageButton")
			rightbutton:SetPos( _v.x,_v.y )
			rightbutton:SetZPos(1000)
			rightbutton:SetSize( 30, 30 )
			rightbutton:SetMaterial(right)
			local _bgIndex = 0
			rightbutton.DoClick = function()
				if _bgIndex < _v.bgNum then
					_bgIndex = _bgIndex + 1
					self.descriptionModel:GetEntity():SetBodygroup(_v.bodygroupIndex,_bgIndex)
				end
			end	
			
			local leftbutton = self.descriptionModelButtons:Add("DImageButton")
			leftbutton:SetPos(_v.x - (ScrW()*(575/1920)),_v.y)
			leftbutton:SetZPos(1000)
			leftbutton:SetSize( 30, 30 )
			leftbutton:SetMaterial(left)
			leftbutton.DoClick = function()
				if _bgIndex > 0 then
					_bgIndex = _bgIndex - 1
					self.descriptionModel:GetEntity():SetBodygroup(_v.bodygroupIndex,_bgIndex)
				end
			end
		end
	end
	local _loopIndex = 0 
	local items = ix.item.list
	local button = self.skinPanel:Add("ixMenuButton")
	button:Dock(TOP)		// Set the size
	button:SetText("Skin 0")	// Set the text above the slider
	
	for k,v in pairs(ix.item.list) do
		if v.skin == nil and v.name == self.currentSelection then
			self.payload:Set("itemname",v.uniqueID)
		end
	end
	
	button.DoClick = function()
		self.descriptionModel:GetEntity():SetSkin(0)
			
		for k,v in pairs(ix.item.list) do
			if v.skin == nil and v.name == self.currentSelection then
				self.payload:Set("itemname",v.uniqueID)
			end
		end
	end
	
	for k, v in pairs(ix.item.list) do
		_loopIndex=_loopIndex+1
		if v.skin then
			
			if v.name == (self.currentSelection .. ", Skin " .. tostring(v.skin)) then
					
				local button = self.skinPanel:Add("ixMenuButton")
				--button:SetPos( 0,_loopIndex * 75 )
								// Set the position
				button:Dock(TOP)		// Set the size
				button:SetText("Skin " .. tostring(v.skin))	// Set the text above the slider
					--DermaNumSlider:SetMin( 0 )				// Set the minimum number you can slide to
					--DermaNumSlider:SetMax( self.descriptionModel:GetEntity():GetBodyGroups()[_].num )
					--DermaNumSlider:SetDecimals( 0 )
				button.DoClick = function()
					self.descriptionModel:GetEntity():SetSkin(v.skin)
					self.payload:Set("itemname",v.uniqueID)
				end
			end
		end
	end
	self.descriptionModelButtons:MoveToFront()
end
function PANEL:Populate()
	self.payload:Set("model", "models/player/zelpa/male_01.mdl" )
	self.payload:Set("faction",ix.faction.teams["citizen"])
	
	for _, v in pairs(self.factionButtons) do
		if (v:GetSelected()) then
			lastSelected = v.faction
		end

		if (IsValid(v)) then
			v:Remove()
		end
	end

	self.factionButtons = {}

		
	local payload = self.payload
	local usernameEntry = vgui.Create( "ixTextEntry", self.descriptionPanel ) -- create the form as a child of frame
	usernameEntry:SetPos(0,250)
	usernameEntry:SetSize(300,25)
	usernameEntry:SetContentAlignment(7)
	
	usernameEntry:SetPlaceholderText( "Name" )
	usernameEntry.OnChange = function( self)
		payload:Set("name",self:GetValue())	-- print the form's text as server text
	end
	
	local descriptionEntry = vgui.Create( "ixTextEntry", self.descriptionPanel ) -- create the form as a child of frame
	descriptionEntry:SetPos(0,280)
	descriptionEntry:SetPlaceholderText( "Description" )
	descriptionEntry:SetSize(300,125)
	descriptionEntry:SetContentAlignment(7)
	descriptionEntry.OnChange = function( self)
		payload:Set("description",self:GetValue())
	end
		
	for _, v in SortedPairs(ix.faction.teams) do
		if (ix.faction.HasWhitelist(v.index)) then
			local button = self.factionButtonsPanel:Add("ixMenuSelectionButton")
			button:SetBackgroundColor(v.color or color_white)
			button:SetText(L(v.name):upper())
			button:Dock(BOTTOM)
			button:SetButtonList(self.factionButtons)
			button.faction = v.index
			button.OnSelected = function(panel)
				local faction = ix.faction.indices[panel.faction]
				local models = faction:GetModels(LocalPlayer())

				self.payload:Set("faction", panel.faction)
				self.payload:Set("model", math.random(1, #models))
			end

			if ((lastSelected and lastSelected == v.index) or (!lastSelected and v.isDefault)) then
				button:SetSelected(true)
			end
				
		end
	end
		self:SetupModelButtons()
	--end-
	--[[

	-- remove panels created for character vars
	for i = 1, #self.repopulatePanels do
		self.repopulatePanels[i]:Remove()
	end

	self.repopulatePanels = {}

	-- payload is empty because we attempted to send it - for whatever reason we're back here again so we need to repopulate
	if (!self.payload.faction) then
		for _, v in pairs(self.factionButtons) do
			if (v:GetSelected()) then
				v:SetSelected(true)
				break
			end
		end
	end

	local zPos = 1

	-- set up character vars
	for k, v in SortedPairsByMemberValue(ix.char.vars, "index") do
		if (!v.bNoDisplay and k != "__SortedIndex") then
			local container = self:GetContainerPanel(v.category or "description")

			if (v.ShouldDisplay and v:ShouldDisplay(container, self.payload) == false) then
				continue
			end

			local panel

			-- if the var has a custom way of displaying, we'll use that instead
			if (v.OnDisplay) then
				panel = v:OnDisplay(container, self.payload)
			--[[elseif (isstring(v.default)) then
				panel = container:Add("ixTextEntry")
				panel:Dock(TOP)
				panel:SetFont("ixMenuButtonHugeFont")
				panel:SetUpdateOnType(true)
				panel.OnValueChange = function(this, text)
					self.payload:Set(k, text)
				end
			end

			if (IsValid(panel)) then
				-- add label for entry
				--[[
				local label = container:Add("DLabel")
				label:SetFont("ixMenuButtonLabelFont")
				label:SetText(L(k):upper())
				label:SizeToContents()
				label:DockMargin(0, 16, 0, 2)
				label:Dock(TOP)

				-- we need to set the docking order so the label is above the panel
				label:SetZPos(zPos - 1)
				panel:SetZPos(zPos)

				self:AttachCleanup(label)
				self:AttachCleanup(panel)

				if (v.OnPostSetup) then
					v:OnPostSetup(panel, self.payload)
				end

				zPos = zPos + 2
				
			end
		end
	end

	if (!self.bInitialPopulate) then
		-- setup progress bar segments
		if (#self.factionButtons > 1) then
			self.progress:AddSegment("@faction")
		end

		self.progress:AddSegment("@description")

		if (#self.attributesPanel:GetChildren() > 1) then
			self.progress:AddSegment("@skills")
		end

		-- we don't need to show the progress bar if there's only one segment
		if (#self.progress:GetSegments() == 1) then
			self.progress:SetVisible(false)
		end
	end

	self.bInitialPopulate = true]]

end

function PANEL:VerifyProgression(name)
	for k, v in SortedPairsByMemberValue(ix.char.vars, "index") do
		if (name ~= nil and (v.category or "description") != name) then
			continue
		end

		local value = self.payload[k]

		if (!v.bNoDisplay or v.OnValidate) then
			if (v.OnValidate) then
				local result = {v:OnValidate(value, self.payload, LocalPlayer())}

				if (result[1] == false) then
					self:GetParent():ShowNotice(3, L(unpack(result, 2)))
					return false
				end
			end

			self.payload[k] = value
		end
	end

	return true
end

function PANEL:Paint(width, height)
	derma.SkinFunc("PaintCharacterCreateBackground", self, width, height)
	BaseClass.Paint(self, width, height)
	--[[if chestClicked then
		chestClicked = false
		startTime = CurTime()
		startPos = self.descriptionModel:GetCamPos()
	end
	if endPos != nil then
		setPos = LerpVector(0.2,startPos,endPos)
		self.descriptionModel:SetCamPos(setPos)
		--print(setPos,self.descriptionModel:GetCamPos())
	end]]
end

vgui.Register("ixCharMenuNew", PANEL, "ixCharMenuPanel")