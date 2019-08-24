-- You can define additional "sub-factions" called classes. These provide a way to differentate different types of characters
-- that still belong to the same class. Much of the same concepts from factions apply to classes.

CLASS.name = "Storm Commando"
CLASS.faction = FACTION_IMP
CLASS.isDefault = false
CLASS.flag = "L"

CLASS_IMPDEATHTROOPER = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		if not string.match(character:GetModel(),"shadow") then
			character:SetModel("models/sono/swbf3/shadow.mdl")
		end
		if(character:GetData("GivenstormcommandoItems") ~= true) then
				local data = {}
				data["SpawnItem"] = true
				character:GetInventory():Add("dlt20x",1,data)
				character:GetInventory():Add("scoutblaster",1,data)
				character:GetInventory():Add("elasticcuff",1,data)
				character:GetInventory():Add("stormcommando",1,data)
				character:SetData("GivenstormcommandoItems",true)
		end

	end
end

function CLASS:OnCanBe(client)
	return client:GetCharacter():HasFlags("L")
end