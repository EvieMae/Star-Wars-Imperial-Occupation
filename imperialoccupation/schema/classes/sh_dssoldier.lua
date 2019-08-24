
-- You can define additional "sub-factions" called classes. These provide a way to differentate different types of characters
-- that still belong to the same class. Much of the same concepts from factions apply to classes.

CLASS.name = "Darvanos Syndicate Soldier"
CLASS.faction = FACTION_DS
CLASS.isDefault = true
CLASS.flag = "H"

CLASS_DSSOLDIER = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		if not string.match(character:GetModel(),"merc2") then
			if string.match(character:GetModel(),"female") then
				character:SetModel("models/outerrimrp/playermodels/female_merc2.mdl")
			else
				character:SetModel("models/outerrimrp/playermodels/male_merc2.mdl")
			end
		end
		if(character:GetData("GivendssoldierItems") ~= true) then
				local data = {}
				data["SpawnItem"] = true
				character:GetInventory():Add("merc2",1,data)
				character:GetInventory():Add("westar",1,data)
				character:SetData("GivendssoldierItems",true)
		end
		
	end
end