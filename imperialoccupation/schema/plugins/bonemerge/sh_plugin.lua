local PLUGIN = PLUGIN
PLUGIN.name = "Head Attacher"
PLUGIN.author = "Lt. Taylor, Clayworks"
PLUGIN.desc = "Head attacher plugin"

function PLUGIN:OnCharacterCreated(client, character)
	if client:GetNetVar("headmodel") == nil then
		character:SetData("headmodel","models/tnb/techcom/male_02.mdl")
	else
		character:SetData("headmodel",client:GetNetVar("headmodel"))
	end
	
	if SERVER then
		local itemname = client:GetNetVar("outfitname")
		local item = ix.item.list[itemname]
		local itemlist = {}
		character:GetInv():Add(itemname)
	end
end

concommand.Add("resetMap",function(ply,cmd,args)
    local map = game.GetMap()
    RunConsoleCommand("changelevel", map)
end)