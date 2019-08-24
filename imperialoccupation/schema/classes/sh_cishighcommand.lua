-- You can define additional "sub-factions" called classes. These provide a way to differentate different types of characters
-- that still belong to the same class. Much of the same concepts from factions apply to classes.

CLASS.name = "C.I.S High Command"
CLASS.faction = FACTION_CIS
CLASS.isDefault = false
CLASS.flag = "l"

CLASS_CISHC = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		if not string.match(character:GetModel(),"pm_droid_tactical_stuxnet") then
			character:SetModel("models/super_tactical_stuxnet/pm_droid_tactical_stuxnet.mdl")
		end
		if(character:GetData("GivecishighcommandItems") ~= true) then
				local data = {}
				data["SpawnItem"] = true
				character:GetInventory():Add("tacticaldroidwhite",1,data)
				character:GetInventory():Add("b2wristblaster",1,data)
				character:SetData("GivecishighcommandItems",true)
		end
		
	end
end

function CLASS:OnSpawn(client)
    client:Give("sswep_command")
end

function CLASS:OnCanBe(client)
	return client:GetCharacter():HasFlags("l")
end