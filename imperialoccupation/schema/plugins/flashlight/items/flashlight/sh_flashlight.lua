ITEM.name = "Flashlight"
ITEM.uniqueID = "flashlight"
ITEM.model = ("models/kingpommes/emperors_tower/ph_props/imp_code_cylinder/imp_code_cylinder.mdl")
ITEM.description = "A flashlight"
ITEM.price = 500
ITEM.flag = "a"
ITEM.category = "Misc"
ITEM.weight = 0.35

if (SERVER) then
	ITEM:Hook("Drop", function(itemTable, client)
		if (client:FlashlightIsOn()) then
			client:Flashlight(false)
		end
	end)
end