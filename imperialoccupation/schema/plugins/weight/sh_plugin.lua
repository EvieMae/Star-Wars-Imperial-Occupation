PLUGIN.name = "Weight"
PLUGIN.author = "Lt. Taylor"
PLUGIN.desc = "Adds a Weight system for items"

if (SERVER) then
    function PLUGIN:CharacterLoaded(char)
        if char == nil then return end
        local character = char
        local inventory = character:GetInv()
        local weight = 0.001
        local quantity = 1
        local totweight = 0
        local maxweight = 50
        for x, y in pairs(inventory:GetItems()) do
            if y.quantity then
                quantity = y.quantity
            end
            if y:GetData("weight") ~= nil then
                weight = y:GetData("weight",0.001)
            elseif y.weight ~= nil then
                weight = y.weight
            else
                weight = 0.001
            end
            
            if y.isCW then
                if weight ~= (y.weight + y:GetData("weight",0)) then
            	    weight = y.weight + y:GetData("weight",0)
            	end
            end
            
            totweight = ((quantity * weight) + totweight)
                    
            if y.name == "Small Backpack" and maxweight < 55 then
                maxweight = 55
            end
                    
            if y.name == "Large Backpack" and maxweight < 60 then
                maxweight = 60
            end
        end
        character:SetData("Weight", totweight)
        character:SetData("MaxWeight", maxweight)
    end
elseif (CLIENT) then
    function PLUGIN:PostDrawInventory(panel)
        if LocalPlayer():GetChar() == nil then return end
        local character = LocalPlayer():GetChar()
        local weight = 0.000
        weight = character:GetData("Weight",0)
        local maxweight = 0.000 
        maxweight = character:GetData("MaxWeight",50)
        if IsValid(panel) then
            panel:SetTitle(L"inv" .. " | " .. weight .. "kg of " .. maxweight .. "kg" )
        end
    end
end

function PLUGIN:PlayerInteractItem(client, action, item)
    local character = client:GetChar()
    local inventory = character:GetInv()
    local weight = 0.001
    local quantity = 1
    local totweight = 0
    local maxweight = character:GetData("MaxWeight",50)
    
    if action == "drop" then
        if (item.name == "Large Backpack" or item.name == "Small Backpack") and maxweight > 50 then
            maxweight = 50
        end
    end
    
    for x, y in pairs(inventory:GetItems()) do
        if y.quantity ~= nil then
            quantity = y.quantity
        end
                
        if y:GetData("weight") ~= nil then
            weight = y:GetData("weight",0.001)
        elseif y.weight ~= nil then
            weight = y.weight
        else
            weight = 0.001
        end
        
        if y.isCW then
            if weight ~= (y.weight + y:GetData("weight",0)) then
            	weight = y.weight + y:GetData("weight",0)
            end
        end
                
        totweight = ((quantity * weight) + totweight)
                
        if y.name == "Small Backpack" and maxweight < 55 then
            maxweight = 55
        end
                    
        if y.name == "Large Backpack" and maxweight < 60 then
            maxweight = 60
        end
    end
    character:SetData("MaxWeight", maxweight)
    character:SetData("Weight", totweight)
end