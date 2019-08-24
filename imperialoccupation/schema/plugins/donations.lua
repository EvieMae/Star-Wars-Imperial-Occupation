local PLUGIN = PLUGIN
PLUGIN.name = "Donations Plugin"
PLUGIN.author = "Lt. Taylor, Clayworks"
PLUGIN.desc = "Imperial Occupation Donations Plugin"
local surface = surface
    
function PLUGIN:GetMaxPlayerCharacter(client)
	local maxChars = ix.config.Get("maxCharacters", 5)
				
	local rank = serverguard.player:GetRank(client)
	if rank == "bronze" then
		maxChars = maxChars + 1
	end
			
	if rank == "silver" then
		maxChars = maxChars + 2
	end
			
	if rank == "gold" then
		maxChars = maxChars + 3
	end
			
	if rank == "diamond" then
		maxChars = maxChars + 4
	end
			
	if  
	    rank == "legendary" or 
	    rank == "admin" or
	    rank == "dev" or
	    rank == "founder" or
	    rank == "moderator" or
	    rank == "operator" or
	    rank == "senior moderator" or
	    rank == "superadmin" or
	    rank == "trusted moderator"
	then
		maxChars = maxChars + 5
	end
	
	return maxChars
end