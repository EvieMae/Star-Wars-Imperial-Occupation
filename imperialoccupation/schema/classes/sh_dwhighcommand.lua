-- You can define additional "sub-factions" called classes. These provide a way to differentate different types of characters
-- that still belong to the same class. Much of the same concepts from factions apply to classes.

CLASS.name = "Deathwatch High Command"
CLASS.faction = FACTION_DW
CLASS.isDefault = false
CLASS.flag = "J"

CLASS_DWHC = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		if not string.match(character:GetModel(),"mancom_01") then
			character:SetModel("models/clayworks/supercommando/male_mancom_01.mdl")
		end
		if(character:GetData("GivedwhighcommandItems") ~= true) then
				local data = {}
				data["SpawnItem"] = true
				character:GetInventory():Add("ee3",1,data)
				character:GetInventory():Add("deathwatchhc",1,data)
				character:SetData("GivedwhighcommandItems",true)
		end
		
	end
end