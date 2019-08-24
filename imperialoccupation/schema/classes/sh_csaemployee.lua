
-- You can define additional "sub-factions" called classes. These provide a way to differentate different types of characters
-- that still belong to the same class. Much of the same concepts from factions apply to classes.

CLASS.name = "Employee"
CLASS.faction = FACTION_CSA
CLASS.isDefault = false
CLASS.flag = "B"

CLASS_CSAEMPLOYEE = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		if not string.match(character:GetModel(),"merc4") then
			if string.match(character:GetModel(),"female") then
				character:SetModel("models/clayworks/outfits/female_merc3.mdl")
			else
				character:SetModel("models/clayworks/outfits/male_merc3.mdl")
			end
			if(character:GetData("GivencsaemployeeItems") ~= true) then
				local data = {}
				data["SpawnItem"] = true
				character:GetInventory():Add("merc2",1,data)
				character:SetData("GivencsaemployeeItems",true)
			end
		end
	end
end