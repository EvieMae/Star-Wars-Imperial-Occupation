LIMB_GROUPS = LIMB_GROUPS or {}
LIMB_GROUPS[HITGROUP_LEFTARM] = true
LIMB_GROUPS[HITGROUP_RIGHTARM] = true
LIMB_GROUPS[HITGROUP_LEFTLEG] = true
LIMB_GROUPS[HITGROUP_RIGHTLEG] = true
LIMB_GROUPS[HITGROUP_GEAR] = true

DMG_ACCEPT = DMG_ACCEPT or {}
DMG_ACCEPT[DMG_BULLET] = true
DMG_ACCEPT[DMG_SNIPER] = true
DMG_ACCEPT[DMG_BUCKSHOT] = true

function PLUGIN:ScalePlayerDamage(entity, hitGroup, damage)
	if entity.armor ~= nil then
		if DMG_ACCEPT[damage:GetDamageType()] then
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
			damage:ScaleDamage(1 - scale)
		end
	end
end