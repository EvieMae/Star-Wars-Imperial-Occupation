ITEM.name = "flashlight"
ITEM.model = "models/jerry/headtorch.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "A flashlight"
ITEM.category = "Misc"
ITEM.quantity = 1

function ITEM:GetDescription()
	local description = self.description
	description = description.."\nWeight: "..self.weight.."kg"
	return description
end

ITEM.functions.Sell =
{
    
    name = "Sell",
    tip = "Sells Item",
    icon = "icon16/money.png",
    
    OnRun = function(item)
        local player = item.player;
        local character = player:GetChar();
        local modifier = 3.00
        
        if (item.flag == "a" or item.flag == "C" or item.flag == "g" or item.flag == "I") then
            modifier = ix.config.Get("Tier 1 Export")
        elseif (item.flag == "A" or item.flag == "d" or item.flag == "G" or item.flag == "j") then
            modifier = ix.config.Get("Tier 2 Export")
        elseif (item.flag == "b" or item.flag == "D" or item.flag == "h" or item.flag == "J") then
            modifier = ix.config.Get("Tier 3 Export")
        else
            modifier = ix.config.Get("Tier 4 Export")
        end
        
        modifier = 1.00 - (modifier * 0.01)
        
        local saleprice = math.Round((item.price*modifier))
		character:GiveMoney(saleprice);
		item:Remove()
		player:NotifyLocalized("Item sold for " .. (saleprice))
        return false
    end;
	
    OnCanRun = function(item)
        local char = item.player:GetChar()
        if(
    		char:HasFlags("a") or 
    		char:HasFlags("A") or 
    		char:HasFlags("b") or
    		char:HasFlags("B") or
    		char:HasFlags("c") or
    		char:HasFlags("C") or
    		char:HasFlags("d") or
    		char:HasFlags("D") or
    		char:HasFlags("f") or
    		char:HasFlags("F") or
    		char:HasFlags("g") or
    		char:HasFlags("G") or
    		char:HasFlags("h") or
    		char:HasFlags("H") or
    		char:HasFlags("i") or
    		char:HasFlags("I") or
    		char:HasFlags("j") or
    		char:HasFlags("J") or
    		char:HasFlags("k") or
    		char:HasFlags("K") or
    		char:HasFlags("n") or
    		char:HasFlags("l") or
    		char:HasFlags("L") or
    		char:HasFlags("m") or
    		char:HasFlags("M")
    	    )
    	then
    		return (!IsValid(item.entity))
    	else
    	    return false
	    end
	end;
}

ITEM.functions.SellPriceCheck =
{
    
    name = "Check Value",
    tip = "Checks the value of the item you will receive",
    icon = "icon16/money_dollar.png",
    
    OnRun = function(item)
        local player = item.player;
        local character = player:GetChar();
        local modifier = 3.00
        
        if (item.flag == "a" or item.flag == "C" or item.flag == "g" or item.flag == "I") then
            modifier = ix.config.Get("Tier 1 Export")
        elseif (item.flag == "A" or item.flag == "d" or item.flag == "G" or item.flag == "j") then
            modifier = ix.config.Get("Tier 2 Export")
        elseif (item.flag == "b" or item.flag == "D" or item.flag == "h" or item.flag == "J") then
            modifier = ix.config.Get("Tier 3 Export")
        else
            modifier = ix.config.Get("Tier 4 Export")
        end
        
        modifier = 1.00 - (modifier * 0.01)

        local saleprice = math.Round((item.price*modifier))
		player:NotifyLocalized("Item is worth " .. saleprice .. " if sold")
        return false
    end;
	
    OnCanRun = function(item)
        local char = item.player:GetChar()
        if(
    		char:HasFlags("a") or
    		char:HasFlags("A") or
    		char:HasFlags("b") or
    		char:HasFlags("B") or
    		char:HasFlags("c") or
    		char:HasFlags("C") or
    		char:HasFlags("d") or
    		char:HasFlags("D") or
    		char:HasFlags("f") or
    		char:HasFlags("F") or
    		char:HasFlags("g") or
    		char:HasFlags("G") or
    		char:HasFlags("h") or
    		char:HasFlags("H") or
    		char:HasFlags("i") or
    		char:HasFlags("I") or
    		char:HasFlags("j") or
    		char:HasFlags("J") or
    		char:HasFlags("k") or
    		char:HasFlags("K") or
    		char:HasFlags("n") or
    		char:HasFlags("l") or
    		char:HasFlags("L") or
    		char:HasFlags("m") or
    		char:HasFlags("M")
    	    )
    	then
    		return (!IsValid(item.entity))
    	else
    	    return false
	    end
	end;
}