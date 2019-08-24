
-- You can define additional "sub-factions" called classes. These provide a way to differentate different types of characters
-- that still belong to the same class. Much of the same concepts from factions apply to classes.

CLASS.name = "Darvanos Syndicate High Command"
CLASS.faction = FACTION_DS
CLASS.isDefault = false
CLASS.flag = "i"

CLASS_DSHIGHCOMMAND = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		if not string.match(character:GetModel(),"mandalorian4") then
			character:SetModel("models/outerrimrp/playermodels/male_mandalorian4.mdl")
		end
		if(character:GetData("GivendssoldierItems") ~= true) then
				local data = {}
				data["SpawnItem"] = true
				character:GetInventory():Add("imp_mand_dg",1,data)
				character:GetInventory():Add("a280c",1,data)
				character:SetData("GivendssoldierItems",true)
		end
		
	end
end