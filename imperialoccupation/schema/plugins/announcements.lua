PLUGIN.name = "Announcements"
PLUGIN.desc = "Chat Announcements"
PLUGIN.author = "Zeus0x00, Clayworks"
--if (CLIENT) then
	local announcements = {"Don't forget you can view our rules by typing !rules in chat", "Missing textures? Type !content in chat to subscribe to our content pack", "Need assistance from staff? Type !help 'Your Message Goes Here' in chat to send a message to available staff"}
	local n = 1
	timer.Create( "announce", 45, 0, function()
	    if CLIENT then
    		if announcements[n] == nil then
    			n = 1
    		end
    		chat.AddText(Color(255,255,255),"[Annoucements] " .. tostring(announcements[n]))
    		n = n + 1
    	end
    	if SERVER then
    	    if announcements[n] == nil then
    			n = 1
    		end
    		print("[Annoucements] " .. tostring(announcements[n]))
    		n = n + 1
	    end
	end)
--end