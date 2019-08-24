-- You can define additional "sub-factions" called classes. These provide a way to differentate different types of characters
-- that still belong to the same class. Much of the same concepts from factions apply to classes.

CLASS.name = "Security Police Trooper"
CLASS.faction = FACTION_ISC
CLASS.isDefault = true
CLASS.flag = "c"

CLASS_ISCTROOPER = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		if not string.match(character:GetModel(),"merc4") then
			if string.match(character:GetModel(),"female") then
				character:SetModel("models/outerrimrp/playermodels/female_merc4.mdl")
			else
				character:SetModel("models/outerrimrp/playermodels/male_merc4.mdl")
			end
		end
		if(character:GetData("GiveniscpoliceItems") ~= true) then
				local data = {}
				data["SpawnItem"] = true
				character:GetInventory():Add("merc4",1,data)
				character:GetInventory():Add("t1repeatingrifle",1,data)
				character:SetData("GiveniscpoliceItems",true)
		end
		
	end
end