
-- You can define additional "sub-factions" called classes. These provide a way to differentate different types of characters
-- that still belong to the same class. Much of the same concepts from factions apply to classes.

CLASS.name = "I.O.C.I."
CLASS.faction = FACTION_IMP
CLASS.isDefault = false
CLASS.flag = "f"


CLASS_IMPIOCI = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		if not string.match(character:GetModel(),"rgofficer") then
			character:SetModel("models/outerrimrp/playermodels/male_rgofficer.mdl")
		end
					if(character:GetData("GiveniociItems") ~= true) then
						local data = {}
						data["SpawnItem"] = true
						character:GetInventory():Add("e11",1,data)
						--character:GetInventory():Add("tfa_se14c_extended?",1,data)
						character:GetInventory():Add("elasticcuff",1,data)
						character:SetData("GiveniociItems",true)
					end
	end
end

function CLASS:OnCanBe(client)
	return client:GetCharacter():HasFlags("f")
end