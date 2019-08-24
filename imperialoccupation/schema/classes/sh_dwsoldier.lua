-- You can define additional "sub-factions" called classes. These provide a way to differentate different types of characters
-- that still belong to the same class. Much of the same concepts from factions apply to classes.

CLASS.name = "Deathwatch Soldier"
CLASS.faction = FACTION_DW
CLASS.isDefault = true
CLASS.flag = "j"

CLASS_DWSOLDIER = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		if not string.match(character:GetModel(),"mandalorian3") then
			character:SetModel("models/outerrimrp/playermodels/male_mandalorian3.mdl")
		end
		if(character:GetData("GivedwsoldierItems") ~= true) then
				local data = {}
				data["SpawnItem"] = true
				character:GetInventory():Add("dualwestar",1,data)
				character:GetInventory():Add("deathwatch",1,data)
				character:SetData("GivedwsoldierItems",true)
		end
		
	end
end