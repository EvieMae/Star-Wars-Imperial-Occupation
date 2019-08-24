local PLUGIN = PLUGIN
PLUGIN.name = "BBH"
PLUGIN.author = "Zeus0x00, Clayworks"
PLUGIN.desc = "Basic Bitch Hud for Basic Bitches"
local template = Material("materials/hud/initialhud.png")
local top = Material("materials/hud/hudbarstop.png")
local surface = surface
    --[[
    1920 1080
    16:9
    ScrW() / 1920 * n
    ScrH() / 1080 * n
    ]]
function PLUGIN:HUDPaint()
	if (CLIENT) then
		local bottomWidth = ScrW() / 1920 * 256
		local bottomHeight = ScrH() / 1080 * 100
		local ply = LocalPlayer()
		local barWidth = ScrW() / 1920 * 426
		local hungWidth = ScrW() / 1920 * 190
		local thirstWidth = ScrW() / 1920 * 120
		local barHeight = ScrH() / 1080 * 24
		local barX = ScrW() / 1920 * 79
		local apX = ScrW() / 1920 * 579
		local hpY = ScrH() / 1080 * (25)
		local apY = ScrH() / 1080 * (25)
		local stamY = ScrH() / 1080 * (1030)
		local hungY = ScrH() / 1080 * (980)
		local maxAp = 100
		local maxStam = 100
		local maxHung = 1000
		local maxThirst = 1000
		local thirstX = ScrW() / 1920 * 317
		if ply ~= nil then
			if (ply:GetCharacter()) then

			end
		else
			print("Fuck off and don't come back") -- Keeping this because fuck anyone who breaks this shit
		end

    end
end
