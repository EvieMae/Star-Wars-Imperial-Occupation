
-- You can define additional "sub-factions" called classes. These provide a way to differentate different types of characters
-- that still belong to the same class. Much of the same concepts from factions apply to classes.

CLASS.name = "Security Police Officer"
CLASS.faction = FACTION_CSA
CLASS.isDefault = false
CLASS.flag = "A"

CLASS_CSAOFFICER = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		if not string.match(character:GetModel(),"merc3") then
			if string.match(character:GetModel(),"female") then
				character:SetModel("models/clayworks/outfits/female_merc3.mdl")
			else
				character:SetModel("models/clayworks/outfits/male_merc3.mdl")
			end
		end
		if(character:GetData("GivencsapoliceCOItems") ~= true) then
				local data = {}
				data["SpawnItem"] = true
				character:GetInventory():Add("merc3",1,data)
				--character:GetInventory():Add(tfa_kotor_repeaten_2?,1,data)
				character:SetData("GivencsapoliceCOItems",true)
		end
		
	end
end