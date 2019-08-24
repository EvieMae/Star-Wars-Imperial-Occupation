ITEM.name = "Elastic Cuff"
ITEM.model = Model("models/props_lab/box01a.mdl")
ITEM.description = "Elastic cuffs for arresting/capturing someone."
ITEM.category = "Cuffs"
ITEM.width = 1
ITEM.height = 1
ITEM.flag = "Z"
ITEM.weight = 1
ITEM.class = "weapon_cuff_elastic"
ITEM.IsAlwaysRaised = true

ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/tick.png",
	OnRun = function(item)
		item.player:Give("weapon_cuff_elastic")
		return true
	end,
}