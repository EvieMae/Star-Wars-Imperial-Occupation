
-- You can define additional "sub-factions" called classes. These provide a way to differentate different types of characters
-- that still belong to the same class. Much of the same concepts from factions apply to classes.

CLASS.name = "Security Police Trooper"
CLASS.faction = FACTION_CSA
CLASS.isDefault = true
CLASS.flag = "c"

CLASS_CSATROOPER = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		if not string.match(character:GetModel(),"merc4") then
			if string.match(character:GetModel(),"female") then
				character:SetModel("models/clayworks/outfits/female_merc4.mdl")
			else
				character:SetModel("models/clayworks/outfits/male_merc4.mdl")
			end
		end
		if(character:GetData("GivencsapoliceItems") ~= true) then
				local data = {}
				data["SpawnItem"] = true
				character:GetInventory():Add("merc4",1,data)
				--character:GetInventory():Add(tfa_kotor_repeaten_1?,1,data)
				character:SetData("GivencsapoliceItems",true)
		end
		
	end
end