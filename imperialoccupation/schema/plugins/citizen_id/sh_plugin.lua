PLUGIN.name = "CitizenIDs"
PLUGIN.author = "Kaptan647"
PLUGIN.description = "Creates IDs when a character is created"


if(SERVER) then
	util.AddNetworkString("WriteID")
	util.AddNetworkString("SaveIDData")
	util.AddNetworkString("ReadID")


	hook.Add("CharacterLoaded","GiveIDToChar",function(char) 
	local ply = char:GetPlayer()
	print("Hook Called")
	if(char:GetData("IDGiven") ~= true) then
		local name = string.Split(ply:GetName()," ")
		local data = {}
		if(#name > 1) then
			data["lastname"] = name[#name]
			table.remove(name)
		end
		data["firstname"] = table.concat( name, " " )
		local steamid = string.Split(char:GetPlayer():SteamID(),":")
		local Citizen_ID = steamid[#steamid] .. char:GetID()
		data["ID"] = Citizen_ID
		char:SetData("Citizen_ID",Citizen_ID)
		data["photo"] = char:GetData("headmodel")
		data["Full"] = true 
		data["SpawnItem"] = true
		char:GetInv():Add("citizenid" , 1 ,data)
		char:SetData("IDGiven",true)
	end
end)
end