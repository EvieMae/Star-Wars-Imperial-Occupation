
-- You can define additional "sub-factions" called classes. These provide a way to differentate different types of characters
-- that still belong to the same class. Much of the same concepts from factions apply to classes.

CLASS.name = "Deathtrooper"
CLASS.faction = FACTION_IMP
CLASS.isDefault = false
CLASS.flag = "C"

CLASS_IMPDEATHTROOPER = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		if not string.match(character:GetModel(),"stormtrooper") then
			character:SetModel("models/player/hydro/swbf_deathtrooper/swbf_deathtrooper2.mdl")
		end
		if(character:GetData("GivendeathtrooperItems") ~= true) then
				local data = {}
				data["SpawnItem"] = true
				character:GetInventory():Add("e11d",1,data)
				character:GetInventory():Add("dlt19extended",1,data)
				character:GetInventory():Add("elasticcuff",1,data)
				character:SetData("GivendeathtrooperItems",true)
		end

	end
end

function CLASS:OnCanBe(client)
	return client:GetCharacter():HasFlags("C")
end