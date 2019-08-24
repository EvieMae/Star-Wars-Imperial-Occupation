-- You can define additional "sub-factions" called classes. These provide a way to differentate different types of characters
-- that still belong to the same class. Much of the same concepts from factions apply to classes.

CLASS.name = "Heavy Stormtrooper"
CLASS.faction = FACTION_IMP
CLASS.isDefault = false
CLASS.flag = "k"

CLASS_IMPSTORMTROOPERHEAVY = CLASS.index


function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		if not string.match(character:GetModel(),"tkrem") then
			character:SetModel("models/ven/tk/rem/tkrem.mdl")
		end
		if(character:GetData("GivenStormTrooperHeavyItems") ~= true) then
			local data = {}
			data["SpawnItem"] = true
			character:GetInventory():Add("t21",1,data)
			character:GetInventory():Add("elasticcuff",1,data)
			character:GetInventory():Add("heavytrooper",1,data)
			character:SetData("GivenStormTrooperHeavyItems",true)
		end
	end
end