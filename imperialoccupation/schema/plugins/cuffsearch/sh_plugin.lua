PLUGIN.name = "Cuff Search"
PLUGIN.author = "Kaptan647"
PLUGIN.description = "Allows you to search cuffed people"

ix.command.Add("search", {
	description = "Search cuffed persons inventory",
	OnRun = function(self, client, arguments)
		local target = client:GetEyeTraceNoCursor().Entity
		if( IsValid(target) && target:IsPlayer() && IsValid(target:GetActiveWeapon()) && target:GetActiveWeapon():GetClass()=="weapon_handcuffed" ) then
			ix.storage.Open(client, target:GetCharacter():GetInventory(),{
			name = "Searching",
			entity = target,
			bMultipleUsers = false,
			searchText = "Searching...",
			searchTime = 0.1
			})
		end
	end
})

hook.Add("CanTransferItem","Block_Equiped_Transfer",function(item, curInv, inventory)
	if(item:GetData("equip") == true) then
		return false
	end
end)