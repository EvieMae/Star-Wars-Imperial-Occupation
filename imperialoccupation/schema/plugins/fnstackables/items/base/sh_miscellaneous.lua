ITEM.name = "misc item"
ITEM.description = "An item"
ITEM.category = "Misc"
ITEM.model = ("models/rgd.mdl")
ITEM.width = 1
ITEM.height = 1
ITEM.basequantity = 1
ITEM.maxQuantity = 5

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