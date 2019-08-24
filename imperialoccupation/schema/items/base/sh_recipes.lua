ITEM.name = "Nice name"
ITEM.description = "Nice desc"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 1
ITEM.model = "models/props_c17/BriefCase001a.mdl"
ITEM.basequantity = 1
ITEM.quantity = 1
ITEM.maxQuantity = 1
ITEM.blueprint = ""

ITEM.functions.learn = { -- sorry, for name order.
	name = "Learn",
	tip = "Learn the Recipe",
	icon = "icon16/add.png",
	OnRun = function(item)
		local data = item.player:GetCharacter():GetData("blueprints",{})
		
		if not table.HasValue(data,item.blueprint) then
			table.insert(data,item.blueprint)
			item.player:GetCharacter():SetData("blueprints", data)
		else
			item.player:Notify("Blueprint Already Known")
			return false
		end
	end,
}