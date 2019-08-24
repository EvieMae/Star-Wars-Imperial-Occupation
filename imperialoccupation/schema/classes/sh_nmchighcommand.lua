
-- You can define additional "sub-factions" called classes. These provide a way to differentate different types of characters
-- that still belong to the same class. Much of the same concepts from factions apply to classes.

CLASS.name = "Nilra-Mann Cartel High Command"
CLASS.faction = FACTION_NMC
CLASS.isDefault = false
CLASS.flag = "h"

CLASS_CSATROOPER = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		if not string.match(character:GetModel(),"merc3") then
			if string.match(character:GetModel(),"female") then
				character:SetModel("models/outerrimrp/playermodels/female_merc3.mdl")
			else
				character:SetModel("models/outerrimrp/playermodels/male_merc3.mdl")
			end
		end
		if(character:GetData("GivenmchcItems") ~= true) then
				local data = {}
				data["SpawnItem"] = true
				character:GetInventory():Add("merc3skin1",1,data)
				character:GetInventory():Add("a280",1,data)
				character:SetData("GivenmchcItems",true)
		end
		
	end
end