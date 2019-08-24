ITEM.name = "Ammo Base"
ITEM.model = "models/Items/BoxSRounds.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.maxQuantity = 45
ITEM.ammo = "pistol" -- type of the ammo
ITEM.description = "A Box that contains %s of Pistol Ammo"
ITEM.basequantity = 1
ITEM.category = "Ammunition"

function ITEM:GetDescription()
	local description = Format(self.description)
	if self.weight then
	    description = description.."\nWeight: "..(self.weight * self:GetData("quantity",1)).."kg"
	end
	return description
end

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
    	ix.util.DrawText(item:GetData("quantity",item.basequantity), 8, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, "ixChatFont")
    end
end

local loadAmount = {
	5,
	10,
	30,
	50,
	70,
	100
}

ITEM.functions.use = {
	name = "Load",
	tip = "useTip",
	icon = "icon16/add.png",
    isMulti = true,
    multiOptions = function(item, client)
        local options = {}

		table.insert(options, {
            name = ("Load All"),
            data = 0,
        })
		for _, amount in pairs(loadAmount) do
			if (amount <= item:GetData("quantity",1)) then
				table.insert(options, {
					name = "Load "..amount,
					data = amount,
				})
			end
		end
        return options
	end,
	OnClick = function(item, data)
		if (data == -1) then

			return false
		end
	end,
	OnRun = function(item, data)
		if data then
			data = data.data or 0
		else
			data = 0
		end

		if (data > 0) then
			local num = tonumber(data)
			item:AddQuantity(-num)
			item:SetData("quantity", item:GetData("quantity",1) - num)

			item.player:GiveAmmo(num, item.ammo)
			item.player:EmitSound(item.useSound or "items/ammo_pickup.wav", 110)
		elseif (data == 0) then
			item.player:GiveAmmo(item:GetData("quantity",1), item.ammo)
			item.player:EmitSound(item.useSound or "items/ammo_pickup.wav", 110)
			return true
		end
		return item:GetData("quantity",1) <= 0
	end,
}

ITEM.functions.Split =
{
    name = "Split",
    tip = "Splits the item",
    icon = "icon16/arrow_divide.png",
    
    OnRun = function(item)
        netstream.Start(item.player, "StackSplit", item:GetData("quantity",1), item.id)
        if item:GetData("quantity",1) == 0 then
           item:Remove()
        end
        return false
    end;
    
    OnCanRun = function(item)
        if item:GetData("quantity",1) > 1 then
            return (!IsValid(item.entity))
        else
            return false
        end
    end;
}

ITEM.functions.Combine =
{
    name = "Combine",
    tip = "Combines with like items",
    icon = "icon16/arrow_join.png",
    
    OnRun = function(item, data)
        if data then
			if data.data == "All" then
				local inv = data.ply:GetCharacter():GetInventory()
				for k,v in pairs(inv:GetItems()) do
					if v.name == item.name and v.id ~= item.id and (v:GetData("quantity",1) + item:GetData("quantity",1)) <= item.maxQuantity then
						item:SetData("quantity",v:GetData("quantity",1) + item:GetData("quantity",1))
						v:Remove()
					end
				end
				return false
			end
            if data.data then
                local combitem = ix.item.instances[data.data.id]
                combitem:SetData("quantity",(item:GetData("quantity",1) + combitem:GetData("quantity",1)))
                return true
            end
        end
        return false
    end;
    
    OnCanRun = function(item)
        if item:GetData("quantity",1) < item.maxQuantity then
            return (!IsValid(item.entity))
        end
    end;
    
    isMulti = true,
    multiOptions = function(item,client)
        
        local targets = {}
        local inv = client:GetCharacter():GetInventory()
        local ItemID = 0
        for k, v in pairs(inv:GetItems()) do
            if v.name == item.name and v.id ~= item.id and (v:GetData("quantity",1) + item:GetData("quantity",1)) <= item.maxQuantity then
                table.insert(targets, {
                   name = v.name .. " (" .. v:GetData("quantity",1) .. ")",
                   data = v,
                })
            end
        end
		table.insert(targets, {name = "All", data = "All", ply = client})
        return targets
    end;
}

function ITEM:OnInstanced()
	timer.Simple(0.5,function()
		if self:GetData("quantity",0) == 0 then
			self:SetData("quantity",self.basequantity)
		end
	end)
end