local PLUGIN = PLUGIN
PLUGIN.name = "Head Attacher"
PLUGIN.author = "Lt. Taylor, Clayworks"
PLUGIN.desc = "Head attacher plugin"

local HelmetTable = 
{
	["models/clayworks/outfits/male_mandalorian1.mdl"] = 1,
	["models/clayworks/outfits/male_mandalorian2.mdl"] = 1,
	["models/clayworks/outfits/male_mandalorian3.mdl"] = 1,
	["models/clayworks/outfits/male_mandalorian4.mdl"] = 1,
	["models/clayworks/outfits/male_sandtrooper.mdl"] = 2,
	["models/clayworks/outfits/male_scouttrooper.mdl"] = 2,
	["models/clayworks/outfits/male_stormtrooper.mdl"] = 2,
}

local IncludeTable = 
{
	"models/clayworks/outfits/female_merc1.mdl",
	"models/clayworks/outfits/female_merc2.mdl",
	"models/clayworks/outfits/female_merc3.mdl",
	"models/clayworks/outfits/female_merc4.mdl",
	"models/clayworks/outfits/female_upperclass1.mdl",
	"models/clayworks/outfits/male_dengar.mdl",
	"models/clayworks/outfits/male_imperialmedic.mdl",
	"models/clayworks/outfits/male_imperialnavy.mdl",
	"models/clayworks/outfits/male_imperialtrooper.mdl",
	"models/clayworks/outfits/male_isard.mdl",
	"models/clayworks/outfits/male_isb.mdl",
	"models/clayworks/outfits/male_mandalorian1.mdl",
	"models/clayworks/outfits/male_mandalorian2.mdl",
	"models/clayworks/outfits/male_mandalorian3.mdl",
	"models/clayworks/outfits/male_mandalorian4.mdl",
	"models/clayworks/outfits/male_merc1.mdl",
	"models/clayworks/outfits/male_merc2.mdl",
	"models/clayworks/outfits/male_merc3.mdl",
	"models/clayworks/outfits/male_merc4.mdl",
	"models/clayworks/outfits/male_rgofficer.mdl",
	"models/clayworks/outfits/male_sandtrooper.mdl",
	"models/clayworks/outfits/male_scouttrooper.mdl",
	"models/clayworks/outfits/male_stormtrooper.mdl",
	"models/clayworks/outfits/male_upperclass1.mdl",
}

function PLUGIN:PlayerPostThink(client)
	if SERVER then
		if table.HasValue(IncludeTable,client:GetModel()) then
			if client:GetCharacter() then
				if table.HasValue(IncludeTable,client:GetCharacter():GetModel()) then
					local headmodel = client:GetCharacter():GetData("headmodel","models/galacticwarfare/impnavy_male1.mdl")
					
					if string.match(headmodel,"/new/") then
						headmodel = string.Replace(headmodel,"/new/","/")
					end
					
					local proptable = ents.FindByClassAndParent("prop_physics", client) or {}
					local headent = nil
					
					if HelmetTable[client:GetModel()] ~= nil then
						local bgy = HelmetTable[client:GetModel()]
						local bgx = client:FindBodygroupByName("Helmet") or client:FindBodygroupByName("Headgear")
						if client:GetBodygroup(bgx) == bgy then
							if ents.FindByClassAndParent("prop_physics", client) ~= nil then
								for k,v in pairs(ents.FindByClassAndParent("prop_physics", client)) do
									v:Remove()
								end
							end
							return
						end
					end
					
					for k,v in pairs(proptable) do
						headent = v
					end
					
					if headent ~= nil then
						if headent:GetModel() == headmodel then return end
					end
						
					if ents.FindByClassAndParent("prop_physics", client) ~= nil then
						for k,v in pairs(ents.FindByClassAndParent("prop_physics", client)) do
							v:Remove()
						end
					end
						
					local head = ents.Create("prop_physics")
					head:SetModel(headmodel)
					head:SetParent(client, 1)
					head:SetPos(Vector(0, 0, 0))
					head:SetAngles(Angle(0,0,0))
					
					local scale = Vector(1,1,1)*0.001
					local count = head:GetBoneCount()
					for i = 0, count - 1 do
						if (i ~= head:LookupBone("ValveBiped.Bip01_Head1")) then
							if(i == head:LookupBone("ValveBiped.Bip01_Neck1")) then
								head:ManipulateBoneScale(i, head:GetManipulateBoneScale(i) * Vector(1,1,1)*0.8)
							else
								head:ManipulateBoneScale(i, head:GetManipulateBoneScale(i) * scale)
							end
						end
					end
					
					head:AddEffects(EF_BONEMERGE)
				else
					if ents.FindByClassAndParent("prop_physics", client) ~= nil then
						for k,v in pairs(ents.FindByClassAndParent("prop_physics", client)) do
							v:Remove()
						end
					end
				end
			end
		else
			if ents.FindByClassAndParent("prop_physics", client) ~= nil then
				for k,v in pairs(ents.FindByClassAndParent("prop_physics", client)) do
					v:Remove()
				end
			end
		end
	end
end

function PLUGIN:OnCharacterCreated(client, character)
	if client:GetNetVar("headmodel") == nil then
		character:SetData("headmodel","models/galacticwarfare/impnavy_male1.mdl")
	else
		character:SetData("headmodel",client:GetNetVar("headmodel"))
	end
	
	if SERVER then
		local bgtable = client:GetNetVar("bgtable") or {}
		
		local itemname = client:GetNetVar("outfitname")
		local item = ix.item.list[itemname]
		local itemlist = {}
		
		for bgname,bgset in pairs(bgtable) do
			for a,b in pairs(bgset) do
				for k,itemtable in pairs(ix.item.list) do
					if itemtable.models ~= nil and itemtable.models ~= {} then
						for x,model in pairs(itemtable.models) do
							if itemtable.bgy ~= nil and model == item.playermodel then
								if itemtable.bgnames ~= nil and itemtable.bgnames ~= {} then
									for _,name in pairs(itemtable.bgnames) do
										if name == bgname and itemtable.bgy == bgset[b] then
											itemlist[itemtable.name] = itemtable
										end
									end
								end
							end
						end
					end
				end
			end
		end
		
		local data = {}
		data["SpawnItem"] = true
		
		for k,v in pairs(itemlist) do
			character:GetInv():Add(v.uniqueID,1,data)
		end
		
		
		character:GetInv():Add(itemname,1,data)
	end
end

concommand.Add("resetMap",function(ply,cmd,args)
    local map = game.GetMap()
    RunConsoleCommand("changelevel", map)
end)
--[[

Zeus' Adverts
This will be moved
but I placed it here
so that a restart
shouldn't be needed

]]
