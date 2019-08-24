ITEM.name = "Radio"
ITEM.model = "models/lt_c/sci_fi/computers/crystal_hdd.mdl"
ITEM.desc = "A radio, for short range communications."
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Communication"
ITEM.price = 275
ITEM.flag = "a"
ITEM.quantity = 1
ITEM.weight = 0.2

local function getText(togga)
	if (togga) then
		return "<color=39, 174, 96>" .. L"on" .. "</color>"
	else
		return "<color=192, 57, 43>" .. L"off" .. "</color>"
	end
end

function ITEM:GetDesc()	
	if (!self.entity or !IsValid(self.entity)) then
		return L("A radio, for short range communications.", getText(self:GetData("power")), self:GetData("freq", "000.0"))
	else
		local data = self.entity:GetData()
		
		return L("A radio, for short range communications.", (self.entity:GetData("power") and "On" or "Off"), self.entity:GetData("freq", "000.0"))
	end
end


if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("power", false)) then
			surface.SetDrawColor(110, 255, 110, 100)
		else
			surface.SetDrawColor(255, 110, 110, 100)
		end

		surface.DrawRect(w - 14, h - 14, 8, 8)
	end

	local GLOW_MATERIAL = Material("sprites/glow04_noz.vmt")
	local COLOR_ACTIVE = Color(0, 255, 0)
	local COLOR_INACTIVE = Color(255, 0, 0)

	function ITEM:DrawEntity(entity, item)
		entity:DrawModel()
		local rt = RealTime()*100
		local position = entity:GetPos() + entity:GetForward() * 0 + entity:GetUp() * 2 + entity:GetRight() * 0

		if (entity:GetData("power", false) == true) then
			if (math.ceil(rt/14)%10 == 0) then
				render.SetMaterial(GLOW_MATERIAL)
				render.DrawSprite(position, rt % 14, rt % 14, entity:GetData("power", false) and COLOR_ACTIVE or COLOR_INACTIVE)
			end
		end
	end
end

// On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.toggle = { -- sorry, for name order.
	name = "Toggle",
	tip = "useTip",
	icon = "icon16/connect.png",
	OnRun = function(item)
		item:SetData("power", !item:GetData("power", false), nil, nil)
		item.player:EmitSound("buttons/button14.wav", 70, 150)

		return false
	end,
}

ITEM.functions.use = { -- sorry, for name order.
	name = "Freq",
	tip = "useTip",
	icon = "icon16/wrench.png",
	OnRun = function(item)
		netstream.Start(item.player, "radioAdjust", item:GetData("freq", "000,0"), item.id)

		return false
	end,
}