PLUGIN.name = "Armor"
PLUGIN.author = "Lt. Taylor"
PLUGIN.desc = "Adds some simple armor system"

ix.util.Include("sv_hooks.lua")

DMG_IGNORE = DMG_IGNORE or {}
DMG_IGNORE[DMG_BULLET] = true
DMG_IGNORE[DMG_SNIPER] = true
DMG_IGNORE[DMG_BUCKSHOT] = true

function PLUGIN:EntityTakeDamage(entity, damage)
    if entity.armor and not DMG_IGNORE[damage:GetDamageType()] then
		local armor = (entity.armor.ap*0.01) or 1
        local scale = math.log(armor + 1)
		
		if hitGroup == 4 or hitGroup == 5 or hitGroup == 6 or hitGroup == 7 then
			scale = (scale * 0.5)
		elseif hitGroup == 3 then
			scale = (scale * 0.75)
		elseif hitGroup == 1 then
			scale = (scale * 2)
		end
		print(scale)
		damage:ScaleDamage(1 - (scale*2))
    end
end