ITEM.name = "Medical Stuff"
ITEM.model = "models/healthvial.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.desc = "A Medical Stuff"
ITEM.healAmount = 50
ITEM.healSeconds = 10
ITEM.category = "Medical"
ITEM.basequantity = 1
ITEM.maxQuantity = 5
ITEM.stopsBleed = false

function ITEM:GetDescription()
	local description = Format(self.description)
	if self.weight then
	    description = description.."\nWeight: "..(self.weight * self:GetData("quantity",1)).."kg"
	end
	return description
end

local function healPlayer(client, target, amount, seconds)
	hook.Run("OnPlayerHeal", client, target, amount, seconds)

	if (client:Alive() and target:Alive()) then
		local id = "nutHeal_"..FrameTime()
		timer.Create(id, 1, seconds, function()
			if (!target:IsValid() or !target:Alive()) then
				timer.Destroy(id)	
			end

			target:SetHealth(math.Clamp(target:Health() + (amount/seconds), 0, target:GetMaxHealth()))
		end)
	end
end

local function increaseWeight(item, client)
	if(item.weightIncrease) then
		local char = client:GetCharacter()
		
		local maxWeight = char:GetData("maxWeight")
		
		char:SetData("maxWeight", maxWeight + item.weightIncrease)
	end
end

local function stopBleed(item, client)
	if(item.stopsBleed) then
		if(timer.Exists(client:Name().."res_bleed")) then
			timer.Remove(client:Name().."res_bleed")
			
			client:Notify("Your bleeding has stopped.")
		end
	end
end


if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
    	ix.util.DrawText(item:GetData("quantity",item.basequantity), 8, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, "ixChatFont")
    end
end



local function onUse(item)
	item.player:EmitSound("items/medshot4.wav", 80, 110)
	item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end

ITEM:Hook("use", onUse)
ITEM:Hook("usef", onUse)

// On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.use = { -- sorry, for name order.
	name = "Use",
	tip = "useTip",
	icon = "icon16/add.png",
	OnRun = function(item)
		if (item.player:Alive()) then
			healPlayer(item.player, item.player, item.healAmount, item.healSeconds)
			stopBleed(item, item.player)
		end
		
		if item:GetData("quantity",1) > 1 then
		    item:SetData("quantity",(item:GetData("quantity",1)-1))
		    return false
		end
	end,
}

// On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.usef = { -- sorry, for name order.
	name = "Use Forward",
	tip = "useTip",
	icon = "icon16/arrow_up.png",
	OnRun = function(item)
		local client = item.player
		local trace = client:GetEyeTraceNoCursor() -- We don't need cursors.
		local target = trace.Entity

		if (target and target:IsValid() and target:IsPlayer() and target:Alive()) then
			healPlayer(item.player, target, item.healAmount, item.healSeconds)
			stopBleed(item, target)
			increaseWeight(item, target)
			
            if item:GetData("quantity") > 1 then
    		   item:SetData("quantity",(item:GetData("quantity",1)-1))
    		    return false
		    end
			
			return true
		end

		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity))
	end
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