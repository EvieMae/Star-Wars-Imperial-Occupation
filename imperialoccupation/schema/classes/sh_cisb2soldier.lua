
-- You can define additional "sub-factions" called classes. These provide a way to differentate different types of characters
-- that still belong to the same class. Much of the same concepts from factions apply to classes.

CLASS.name = "C.I.S B2 Soldier"
CLASS.faction = FACTION_CIS
CLASS.isDefault = false
CLASS.flag = "K"

CLASS_CISB2 = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		if not string.match(character:GetModel(),"b2_battledroid") then
			character:SetModel("models/player/hydro/b2_battledroid/b2_battledroid.mdl")
		end
		if(character:GetData("Givecisb2Items") ~= true) then
				local data = {}
				data["SpawnItem"] = true
				character:GetInventory():Add("b2battledroid",1,data)
				character:GetInventory():Add("b2wristblaster",1,data)
				character:SetData("Givecisb2Items",true)
		end
		
	end
end