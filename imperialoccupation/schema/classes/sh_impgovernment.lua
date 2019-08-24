
-- You can define additional "sub-factions" called classes. These provide a way to differentate different types of characters
-- that still belong to the same class. Much of the same concepts from factions apply to classes.

CLASS.name = "Imperial Government"
CLASS.faction = FACTION_IMP
CLASS.isDefault = false
CLASS.flag = "d"

CLASS_IMPGOVT = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		if not string.match(character:GetModel(),"upperclass1") then
			if string.match(character:GetModel(),"female") then
				character:SetModel("models/outerrimrp/playermodels/female_upperclass1.mdl")
			else
				character:SetModel("models/outerrimrp/playermodels/male_upperclass1.mdl")
			end
			if(character:GetData("GivenimpgovItems") ~= true) then
				local data = {}
				data["SpawnItem"] = true
				character:GetInventory():Add("upperclass",1,data)
				character:SetData("GivenimpgovItems",true)
			end
		end
	end
end