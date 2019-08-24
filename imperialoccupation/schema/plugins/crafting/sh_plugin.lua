--TODO: POPULATE CRAFTING ITEMS AND RECIPES
PLUGIN.name = "Crafting"
PLUGIN.author = "Lt. Taylor"
PLUGIN.desc = "Crafting with Tables!"
STORED_RECIPES = {}

function PLUGIN:AddRecipe(name, model, desc, requirements, results, id, skill, blueprint, guns, entity, category, crafttable)
	if type(name) ~= "table" then
		local RECIPE = {}
		RECIPE["id"] = id --Unique ID of the recipe.
		RECIPE["name"] = name -- Name of the recipe.
		RECIPE["model"] = model -- Model it uses in the menu.
		RECIPE["desc"] = desc -- Description of what it is.
		RECIPE["req"] = requirements --Requirements to craft it(use item id's)
		RECIPE["results"] = results --Results of the craft (use item id's)
		RECIPE["blueprint"] = blueprint or false
		RECIPE["guns"] = guns or false
		RECIPE["entity"] = entity or false
		RECIPE["category"] = category or "Miscellaneous"
		RECIPE["crafttable"] = crafttable or ""

		if skill then
			RECIPE["skill"] = skill
		end

		STORED_RECIPES[id] = RECIPE
	else
		for k, v in pairs(name) do
		RECIPE["id"] = k --Unique ID of the recipe.
		RECIPE["name"] = v.name -- Name of the recipe.
		RECIPE["model"] = v.model -- Model it uses in the menu.
		RECIPE["desc"] = v.desc -- Description of what it is.
		RECIPE["req"] = v.requirements --Requirements to craft it(use item id's)
		RECIPE["results"] = v.results --Results of the craft (use item id's)
		RECIPE["blueprint"] = v.blueprint or false --Whether or not it uses a blueprint
		RECIPE["guns"] = v.guns or false --Whether or not it will level up your gunsmithing skill.
		RECIPE["entity"] = v.entity or false --FUTURE: Whether or not it will use an entity.
		RECIPE["category"] = v.category or "Miscellaneous" --FUTURE: The Category
		RECIPE["crafttable"] = v.crafttable or ""

		end
	end
end
--[[-------------------------------------------------------------------------
TODO: For release, demonstrate full capacity of plugin.
---------------------------------------------------------------------------]]
local NEW_RECIPES = {
	["food_needlegaps_stew"] = {
		["name"] = "Food: Needlegaps Stew",
		["model"] = "models/neeewpackofprops/food9.mdl",
		["desc"] = "Stew some Gren Root, Ground, and Whole Meat for some Needlegaps Stew.",
		["requirements"] = {["rawmeat"] = 5, ["groundmeat"] = 2, ["grenroot"] = 2},
		["results"] = {["needlestew"] = 1},
		["category"] = "Cooking",
		["blueprint"] = "needlegapstew",
		["crafttable"] = "cooking"
	},
	["food_bigfuckingham"] = {
		["name"] = "Food: Big Fucking Ham",
		["model"] = "models/neeewpackofprops/food35.mdl",
		["desc"] = "Cook up a big Stack O' Meat (trademarked) for what will then become a Big Fucking Ham.",
		["requirements"] = {["stackomeat"] = 1},
		["results"] = {["ham"] = 1},
		["category"] = "Cooking",
		["blueprint"] = "bigfuckingham",
		["crafttable"] = "cooking"
	},
	["food_slicehoundpotatos"] = {
		["name"] = "Food: Slice Hound and Potatos",
		["model"] = "models/neeewpackofprops/food5.mdl",
		["desc"] = "Take some Slice Hound meat and potatos, cook them up with seasonings of your choice, and the meal is made.",
		["requirements"] = {["rawmeat"] = 1, ["charboteroot"] = 1},
		["results"] = {["slicehoundpotatos"] = 1},
		["category"] = "Cooking",
		["blueprint"] = "slicehoundpotatos",
		["crafttable"] = "cooking"
	},
	["food_direcatjerky"] = {
		["name"] = "Food: Dire Cat Jerky",
		["model"] = "models/neeewpackofprops/food20.mdl",
		["desc"] = "Food for someone on the go, made from Dire Cat meat.",
		["requirements"] = {["rawmeat"] = 1},
		["results"] = {["direcatjerky"] = 1},
		["category"] = "Cooking",
		["blueprint"] = "direcatjerky",
		["crafttable"] = "cooking"
	},
	["food_aircake"] = {
		["name"] = "Food: Air Cake",
		["model"] = "models/neeewpackofprops/food22.mdl",
		["desc"] = "A delicious dessert, with a fruity center.",
		["requirements"] = {["dough"] = 2, ["sunfruit"] = 1},
		["results"] = {["aircake"] = 1},
		["category"] = "Cooking",
		["blueprint"] = "aircake",
		["crafttable"] = "cooking"
	},
	["food_moondrank"] = {
		["name"] = "Food: Moon Drank",
		["model"] = "models/neeewpackofprops/food8.mdl",
		["desc"] = "Moon Drank tastes like Moon Drank.",
		["requirements"] = {["yakoroot"] = 1, ["grenroot"] = 1},
		["results"] = {["moondrank"] = 1},
		["category"] = "Cooking",
		["blueprint"] = "moondrank",
		["crafttable"] = "cooking"
	},
	["food_cheesewheel"] = {
		["name"] = "Food: Cheese Wheel",
		["model"] = "models/neeewpackofprops/food23.mdl",
		["desc"] = "A big cheese wheel for a big cheese lover.",
		["requirements"] = {["bluemilk"] = 4},
		["results"] = {["cheesewheel"] = 1},
		["category"] = "Cooking",
		["blueprint"] = "cheesewheel",
		["crafttable"] = "cooking"
	},
	["food_stackomeat"] = {
		["name"] = "Food: Stack O' Meat",
		["model"] = "models/neeewpackofprops/food10.mdl",
		["desc"] = "An assortment of meats, who knows what you're really eating.",
		["requirements"] = {["rawmeat"] = 4, ["groundmeat"] = 1},
		["results"] = {["stackomeat"] = 1},
		["category"] = "Cooking",
		["blueprint"] = "stackomeat",
		["crafttable"] = "cooking"
	},
	["food_sausage"] = {
		["name"] = "Food: Sausage",
		["model"] = "models/neeewpackofprops/food29.mdl",
		["desc"] = "Made mostly of pork in a lamb casing.",
		["requirements"] = {["groundmeat"] = 2},
		["results"] = {["sausage"] = 1},
		["category"] = "Cooking",
		["blueprint"] = "sausage",
		["crafttable"] = "cooking"
	},
	["food_cookedmeat"] = {
		["name"] = "Food: Cooked Meat",
		["model"] = "models/neeewpackofprops/food28.mdl",
		["desc"] = "Cooked meat that brings a smile to most.",
		["requirements"] = {["rawmeat"] = 1},
		["results"] = {["cookedmeat"] = 1},
		["category"] = "Cooking",
		["blueprint"] = "cookedmeat",
		["crafttable"] = "cooking"
	},
	["food_bagelsandwich"] = {
		["name"] = "Food: Bagel Sandwich",
		["model"] = "models/neeewpackofprops/food31.mdl",
		["desc"] = "A bagel sandwich made with cheese and a sausage patty.",
		["requirements"] = {["cookedmeat"] = 1, ["dough"] = 1, ["charboteroot"] = 1},
		["results"] = {["bagelsandwich"] = 1},
		["category"] = "Cooking",
		["blueprint"] = "bagelsandwich",
		["crafttable"] = "cooking"
	},
	["food_hotcakes"] = {
		["name"] = "Food: Hot Cakes",
		["model"] = "models/neeewpackofprops/food1.mdl",
		["desc"] = "Dessert that is rather good right out of the oven, typically with a cherry on top.",
		["requirements"] = {["dough"] = 1, ["yakoroot"] = 1},
		["results"] = {["hotcakes"] = 1},
		["category"] = "Cooking",
		["blueprint"] = "hotcakes",
		["crafttable"] = "cooking"
	},
	["food_stewfruit"] = {
		["name"] = "Food: Stew Fruit",
		["model"] = "models/neeewpackofprops/food2.mdl",
		["desc"] = "Bungle of fruits wtih a broth of delicacy, sweet and salty, a perfect mix.",
		["requirements"] = {["sunfruit"] = 1, ["gwambafruit"] = 1, ["grenroot"] = 1},
		["results"] = {["stewfruit"] = 1},
		["category"] = "Cooking",
		["blueprint"] = "stewfruit",
		["crafttable"] = "cooking"
	},
	["food_spicejellyrolls"] = {
		["name"] = "Food: Spice Jelly Rolls",
		["model"] = "models/neeewpackofprops/food18.mdl",
		["desc"] = "Spice-Jelly Rolls are a dough rolled and baked with Spice-Jelly.",
		["requirements"] = {["dough"] = 2},
		["results"] = {["spicejellyrolls"] = 1},
		["category"] = "Cooking",
		["blueprint"] = "spicejellyrolls",
		["crafttable"] = "cooking"
	},
	["food_endwa"] = {
		["name"] = "Food: Endwa",
		["model"] = "models/neeewpackofprops/food11.mdl",
		["desc"] = "Meat chunks on a stick! Perfect for a meal on the go.",
		["requirements"] = {["cookedmeat"] = 2},
		["results"] = {["endwa"] = 1},
		["category"] = "Cooking",
		["blueprint"] = "endwa",
		["crafttable"] = "cooking"
	},
	["food_creampuff"] = {
		["name"] = "Food: Cream Puff",
		["model"] = "models/neeewpackofprops/food11.mdl",
		["desc"] = "A great dessert best eaten with sweet crackers.",
		["requirements"] = {["dough"] = 1},
		["results"] = {["creampuff"] = 1},
		["category"] = "Cooking",
		["blueprint"] = "creampuff",
		["crafttable"] = "cooking"
	},
	["food_spiceloaf"] = {
		["name"] = "Food: Spice Loaf",
		["model"] = "models/neeewpackofprops/food27.mdl",
		["desc"] = "A loaf of dense, ground, and spiced meat that is heated to the consumer's preference.",
		["requirements"] = {["rawmeat"] = 3},
		["results"] = {["spiceloaf"] = 1},
		["category"] = "Cooking",
		["blueprint"] = "spiceloaf",
		["crafttable"] = "cooking"
	},
	["food_smokednerf"] = {
		["name"] = "Food: Smoked Nerf",
		["model"] = "models/neeewpackofprops/food36.mdl",
		["desc"] = "A loaf of dense, ground, and spiced meat that is heated to the consumer's preference.",
		["requirements"] = {["rawmeat"] = 5, ["charboteroot"] = 1},
		["results"] = {["smokednerf"] = 1},
		["category"] = "Cooking",
		["blueprint"] = "smokednerf",
		["crafttable"] = "cooking"
	},
	["food_murraslices"] = {
		["name"] = "Food: Murra Slices",
		["model"] = "models/neeewpackofprops/food8.mdl",
		["desc"] = "Slices of meat, usually from the Murra, hence its name. Drissled in a nice sauce",
		["requirements"] = {["cookedmeat"] = 3, ["charboteroot"] = 1},
		["results"] = {["murraslices"] = 1},
		["category"] = "Cooking",
		["blueprint"] = "murraslices",
		["crafttable"] = "cooking"
	},
	["food_dough"] = {
		["name"] = "Food: Dough",
		["model"] = "models/neeewpackofprops/food21.mdl",
		["desc"] = "Dough is a fluffy mixture of what will make bread in the end after baked.",
		["requirements"] = {["rice"] = 2},
		["results"] = {["dough"] = 1},
		["category"] = "Cooking",
		["blueprint"] = "dough",
		["crafttable"] = "cooking"
	},
	["food_groundmeat"] = {
		["name"] = "Food: Ground Meat",
		["model"] = "models/neeewpackofprops/food26.mdl",
		["desc"] = "Ground meat is ground up meat ready to be cooked.",
		["requirements"] = {["rawmeat"] = 1},
		["results"] = {["groundmeat"] = 1},
		["category"] = "Cooking",
		["blueprint"] = "groundmeat",
		["crafttable"] = "cooking"
	},
		["guns_a280"] = {
		["name"] = "Guns: A280",
		["model"] = "models/weapons/synbf3/w_a280.mdl",
		["desc"] = "The classic rifle used by resistance forces for its all around good stats. Very highly praised by organized and militia forces.",
		["requirements"] = {["scrap"] = 50, ["durasteelbox"] = 100, ["tools"] = 60, ["electricalcomponents"] = 30},
		["results"] = {["a280"] = 1},
		["category"] = "Gunsmithing",
		["blueprint"] = "a280",
		["crafttable"] = "gunsmithing"
	},
		["guns_a280c"] = {
		["name"] = "Guns: A280c",
		["model"] = "models/weapons/synbf3/w_a280.mdl",
		["desc"] = "The classic rifle used by resistance forces for its all around good stats. Very highly praised by organized and militia forces.",
		["requirements"] = {["scrap"] = 130, ["durasteelbox"] = 100, ["tools"] = 85, ["electricalcomponents"] = 45},
		["results"] = {["a280c"] = 1},
		["category"] = "Gunsmithing",
		["blueprint"] = "a280c",
		["crafttable"] = "gunsmithing"
	},
		["guns_dc15s"] = {
		["name"] = "Guns: DC-15S",
		["model"] = "models/bf2017/w_e11.mdl",
		["desc"] = "The smaller, faster firing variant of the DC-15a. While the rounds might do less damage, its overall more effective if you can hit accurately.",
		["requirements"] = {["scrap"] = 55, ["durasteelbox"] = 40, ["tools"] = 45, ["electricalcomponents"] = 10},
		["results"] = {["dc15s"] = 1},
		["category"] = "Gunsmithing",
		["blueprint"] = "dc15s",
		["crafttable"] = "gunsmithing"
	},
		["guns_defender"] = {
		["name"] = "Guns: Defender Sporting Pistol",
		["model"] = "models/sw_battlefront/weapons/defender_sporting_pistol.mdl",
		["desc"] = "A cheap defensive weapon, yet despite its price, rarely used due to its poor stats.",
		["requirements"] = {["scrap"] = 5, ["durasteelbox"] = 5, ["tools"] = 4, ["electricalcomponents"] = 2},
		["results"] = {["defender"] = 1},
		["category"] = "Gunsmithing",
		["blueprint"] = "defender",
		["crafttable"] = "gunsmithing"
	},
		["guns_dh17"] = {
		["name"] = "Guns: DH-17",
		["model"] = "models/sw_battlefront/weapons/2019/dh17_handgun.mdl",
		["desc"] = "A classic rebel weapon. Functions like a pistol and an assault rifle. Picked for its reliability and ease of use.",
		["requirements"] = {["scrap"] = 25, ["durasteelbox"] = 45, ["tools"] = 10, ["electricalcomponents"] = 6},
		["results"] = {["dh17"] = 1},
		["category"] = "Gunsmithing",
		["blueprint"] = "dh17",
		["crafttable"] = "gunsmithing"
	},
		["guns_dl44"] = {
		["name"] = "Guns: DL-44",
		["model"] = "models/weapons/synbf3/w_dl44.mdl",
		["desc"] = "A classic pistol, wielded by the infamous Han Solo. Packing more power than most other pistols, and it comes with a scope.",
		["requirements"] = {["scrap"] = 10, ["durasteelbox"] = 8, ["tools"] = 5, ["electricalcomponents"] = 2},
		["results"] = {["dl44"] = 1},
		["category"] = "Gunsmithing",
		["blueprint"] = "dl44",
		["crafttable"] = "gunsmithing"
	},
		["guns_dlt19"] = {
		["name"] = "Guns: DLT-19",
		["model"] = "models/bf2017/w_dlt19.mdl",
		["desc"] = "A strange version of the DLT-19, which focuses the magazine down into 5 very powerful shots. Can pierce through almost anything.",
		["requirements"] = {["scrap"] = 155, ["durasteelbox"] = 125, ["tools"] = 75, ["electricalcomponents"] = 35},
		["results"] = {["dlt19"] = 1},
		["category"] = "Gunsmithing",
		["blueprint"] = "dlt19",
		["crafttable"] = "gunsmithing"
	},
		["guns_dlt20x"] = {
		["name"] = "Guns: DLT-20X",
		["model"] = "models/weapons/synbf3/w_dlt20a.mdl",
		["desc"] = "An older rifle thats been in production since before the war. Commonly sold, although typically only available to organized forces such as the police or military forces.",
		["requirements"] = {["scrap"] = 165, ["durasteelbox"] = 217, ["tools"] = 70, ["electricalcomponents"] = 18},
		["results"] = {["dlt20x"] = 1},
		["category"] = "Gunsmithing",
		["blueprint"] = "dlt20x",
		["crafttable"] = "gunsmithing"
	},
		["guns_dp23"] = {
		["name"] = "Guns: DP-23",
		["model"] = "models/sw_battlefront/weapons/2019/dp23_base.mdl",
		["desc"] = "A shotgun blaster. Packs quite a punch for something so old.",
		["requirements"] = {["scrap"] = 75, ["durasteelbox"] = 85, ["tools"] = 60, ["electricalcomponents"] = 20},
		["results"] = {["dp23"] = 1},
		["category"] = "Gunsmithing",
		["blueprint"] = "dp23",
		["crafttable"] = "gunsmithing"
	},
		["guns_e11"] = {
		["name"] = "Guns: E-11",
		["model"] = "models/bf2017/w_e11.mdl",
		["desc"] = "A Suppressed variant of the E-11, used by Imperial elite. packs a bit more of a punch.",
		["requirements"] = {["scrap"] = 60, ["durasteelbox"] = 50, ["tools"] = 11, ["electricalcomponents"] = 6},
		["results"] = {["e11"] = 1},
		["category"] = "Gunsmithing",
		["blueprint"] = "e11",
		["crafttable"] = "gunsmithing"
	},
		["guns_ee3"] = {
		["name"] = "Guns: EE-3",
		["model"] = "models/weapons/synbf3/w_ee3.mdl",
		["desc"] = "Bounty hunter classic. Comes with a nice scope, and can fire in single or a three shot burst.",
		["requirements"] = {["scrap"] = 185, ["durasteelbox"] = 195, ["tools"] = 70, ["electricalcomponents"] = 18},
		["results"] = {["ee3"] = 1},
		["category"] = "Gunsmithing",
		["blueprint"] = "ee3",
		["crafttable"] = "gunsmithing"
	},
		["guns_rk3"] = {
		["name"] = "Guns: RK-3",
		["model"] = "models/sw_battlefront/weapons/rk3_pistol.mdl",
		["desc"] = "A standard Semi Blaster Pistol.",
		["requirements"] = {["scrap"] = 8, ["durasteelbox"] = 5, ["tools"] = 4, ["electricalcomponents"] = 2},
		["results"] = {["rk3"] = 1},
		["category"] = "Gunsmithing",
		["blueprint"] = "rk3",
		["crafttable"] = "gunsmithing"
	},
		["guns_rt97"] = {
		["name"] = "Guns: RT-97",
		["model"] = "models/weapons/synbf3/w_rt97c.mdl",
		["desc"] = "A popular weapon amongst resistance heavies. Capable of easily standing up against anything that it might come against.",
		["requirements"] = {["scrap"] = 250, ["durasteelbox"] = 200, ["tools"] = 100, ["electricalcomponents"] = 75},
		["results"] = {["rt97"] = 1},
		["category"] = "Gunsmithing",
		["blueprint"] = "rt97",
		["crafttable"] = "gunsmithing"
	},
		["guns_t21"] = {
		["name"] = "Guns: T-21",
		["model"] = "models/weapons/synbf3/w_t21.mdl",
		["desc"] = "A fast firing light machine gun, typically used by imperial forces.",
		["requirements"] = {["scrap"] = 130, ["durasteelbox"] = 125, ["tools"] = 75, ["electricalcomponents"] = 35},
		["results"] = {["t21"] = 1},
		["category"] = "Gunsmithing",
		["blueprint"] = "t21",
		["crafttable"] = "gunsmithing"
	},
		["guns_valken38a"] = {
		["name"] = "Guns: Valken-38A",
		["model"] = "models/bf2017/w_dlt19.mdl",
		["desc"] = "The smaller, faster firing variant of the Valken. While the rounds might do less damage, it's overall more effective if you can hit accurately.",
		["requirements"] = {["scrap"] = 100, ["durasteelbox"] = 100, ["tools"] = 60, ["electricalcomponents"] = 20},
		["results"] = {["valken38a"] = 1},
		["category"] = "Gunsmithing",
		["blueprint"] = "valken38a",
		["crafttable"] = "gunsmithing"
	}
}

for k, v in pairs(NEW_RECIPES) do
	PLUGIN:AddRecipe(v.name, v.model, v.desc, v.requirements, v.results, k, v.skill or nil, v.blueprint or nil, v.guns or nil, v.entity or nil, v.category or "Miscellaneous", v.crafttable or nil)
end

--[[-------------------------------------------------------------------------
Tying in with the 'Citizen Production Plugin', adding schematics for study.
---------------------------------------------------------------------------]]
for k, v in pairs(ix.item.list) do
	if v.category == "Schematics" then
		local tbl = v.requirements
		local tbl2 = v.result
		local req_table_empty = {}
		local res_table_empty = {}
		for k2, v2 in pairs(tbl) do
			req_table_empty[v2[1]] = v2[2]
		end
		for k3,v3 in pairs(tbl2) do
			if v3[1] != "manufacturing_ticket" then
				res_table_empty[v3[1]] = v3[2]
			end
		end
		PLUGIN:AddRecipe(v.name, v.model, v.description .. "\nYou studied this blueprint from the factories.", req_table_empty, res_table_empty, v.uniqueID, false, v.uniqueID)
	end
end

ix.util.Include("cl_plugin.lua")
ix.util.Include("sv_plugin.lua")
ix.util.Include("sh_items.lua")

ix.command.Add("BlueprintGive", {
	description = "Give a blueprint to a player.",
	adminOnly = true,
	arguments = {ix.type.character, ix.type.string},
	OnRun = function(self, client, target, blueprint)
		local data = target:GetData("blueprints", {})

		if not table.HasValue(data, blueprint) then
			table.insert(data, blueprint)
		else
			client:Notify(target:GetName() .. " already has this blueprint.")

			return
		end

		target:SetData("blueprints", data)
		client:Notify("You have given " .. target:GetName() .. " the blueprint " .. blueprint .. ".")
		target.player:Notify("You have been given the blueprint " .. blueprint .. " by " .. client:Name())
	end
})

ix.command.Add("BlueprintRemove", {
	description = "Give a blueprint to a player.",
	adminOnly = true,
	arguments = {ix.type.character, ix.type.string},
	OnRun = function(self, client, target, blueprint)
		local data = target:GetData("blueprints", {})

		if table.HasValue(data, blueprint) then
			table.RemoveByValue(data, blueprint)
		else
			client:Notify(target:GetName() .. " does not have this blueprint.")
		end

		target:SetData("blueprints", data)
		client:Notify("You have taken " .. target:GetName() .. " the blueprint " .. blueprint .. ".")
		target.player:Notify("You have had the blueprint " .. blueprint .. " taken from you by " .. client:Name())
	end
})

local charMeta = ix.meta.character

function charMeta:GiveBlueprint(blueprint)
	local data = self:GetData("blueprints", {})

	if not table.HasValue(data, blueprint) then
		table.insert(data, blueprint)
	end

	self:SetData("blueprints", data)
end

function charMeta:RemoveBlueprint(blueprint)
	local data = target:GetData("blueprints", {})

	if table.HasValue(data, blueprint) then
		table.RemoveByValue(data, blueprint)
	end

	target:SetData("blueprints", data)
end