PLUGIN.name = "Flashlight"
PLUGIN.author = "Chessnut"
PLUGIN.desc = "Provides a flashlight item to regular flashlight usage."

function PLUGIN:PlayerSwitchFlashlight(client, state)
	if (state and !client:GetChar():GetInv():HasItem("flashlight")) then
	    client:AllowFlashlight(true)
		return false
	end
    client:AllowFlashlight(false)
	return true
end