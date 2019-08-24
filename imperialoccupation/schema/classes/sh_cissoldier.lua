
-- You can define additional "sub-factions" called classes. These provide a way to differentate different types of characters
-- that still belong to the same class. Much of the same concepts from factions apply to classes.

CLASS.name = "C.I.S B1 Soldier"
CLASS.faction = FACTION_CIS
CLASS.isDefault = false
CLASS.flag = "I"

CLASS_CISSOLDIER = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		if not string.match(character:GetModel(),"b1_battledroid") then
			character:SetModel("models/player/hydro/b1_battledroids/assault/b1_battledroid_assault.mdl")
		end
		if(character:GetData("GivecissoldierItems") ~= true) then
				local data = {}
				data["SpawnItem"] = true
				character:GetInventory():Add("b1securitydroid",1,data)
				character:GetInventory():Add("e5blaster",1,data)
				character:SetData("GivecissoldierItems",true)
		end
		
	end
end

function CLASS:OnCanBe(client)
	return client:GetCharacter():HasFlags("I")
end