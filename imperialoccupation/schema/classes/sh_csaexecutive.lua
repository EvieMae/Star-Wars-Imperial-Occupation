
-- You can define additional "sub-factions" called classes. These provide a way to differentate different types of characters
-- that still belong to the same class. Much of the same concepts from factions apply to classes.

CLASS.name = "Executive"
CLASS.faction = FACTION_CSA
CLASS.isDefault = false
CLASS.flag = "b"

CLASS_CSAEXEC = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		if not string.match(character:GetModel(),"upperclass") then
			if string.match(character:GetModel(),"female") then
				character:SetModel("models/clayworks/outfits/female_upperclass1.mdl")
			else
				character:SetModel("models/clayworks/outfits/male_upperclass1.mdl")
			end
		end
		if(character:GetData("GivencsaexecutiveItems") ~= true) then
			local data = {}
			data["SpawnItem"] = true
			character:GetInventory():Add("upperclass",1,data)
			--character:GetInventory():Add(tfa_swch_ll30?,1,data)
			character:SetData("GivencsaexecutiveItems",true)
		end
		
	end
end