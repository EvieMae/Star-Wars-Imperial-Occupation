ITEM.name = "Dengar Backpack"
ITEM.description = "A backpack fitted for the Dengar outfit."
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/starwars/syphadias/props/sw_tor/bioware_ea/items/harvesting/slicing/slicing_safeboxes_screen.mdl"
ITEM.category = "Clothing"
-- Trade
ITEM.price = 350
ITEM.flag = "a"
-- Bodygroups, used for bodygroup items. Set to nil, 0, and {} if not using
ITEM.bgnames = {"Backpack"}
ITEM.bgy = 1
-- Models, used to determine whether we need to bonemerge or if we can use bodygroups
ITEM.models = {
	"models/outerrimrp/playermodels/male_dengar.mdl"
	}
ITEM.weight = -5
ITEM.ap = 1

ITEM.isUpgrade = true
ITEM.slot = 1

-- 1: Backpack
-- 2: Breastplate
-- 3: Buttplate
-- 4: Codpiece
-- 5: Leggings
-- 6: Shoulderpads
-- 7: Wrists