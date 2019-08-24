-- You can define additional "sub-factions" called classes. These provide a way to differentate different types of characters
-- that still belong to the same class. Much of the same concepts from factions apply to classes.

CLASS.name = "Stormtrooper"
CLASS.faction = FACTION_IMP
CLASS.isDefault = false
CLASS.flag = "F"

CLASS_IMPSTORMTROOPER = CLASS.index


function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		if not string.match(character:GetModel(),"stormtrooper") then
			character:SetModel("models/player/fatal/troopers/trooper.mdl")
		end
		if(character:GetData("GivenStormTrooperItems") ~= true) then
			local data = {}
			data["SpawnItem"] = true
			character:GetInventory():Add("e11",1,data)
			character:GetInventory():Add("elasticcuff",1,data)
			character:GetInventory():Add("stormtrooper",1,data)
			character:SetData("GivenStormTrooperItems",true)
		end
	end
end