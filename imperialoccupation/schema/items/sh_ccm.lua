ITEM.name = "CCM"
ITEM.model = Model("models/neeewpackofprops/jar.mdl")
ITEM.description = "A machine to create credits."
ITEM.category = "Consumables"
ITEM.width = 2 -- Width and height refer to how many grid spaces this item takes up.
ITEM.height = 3

-- Items will be purchasable through the business menu. To disable the purchasing of this item, we specify ITEM.noBusiness.
ITEM.noBusiness = true

-- If you'd rather have the item only purchasable by a specific criteria, then you can specify it as such.
-- Make sure you haven't defined ITEM.noBusiness if you are going to be doing this.
--[[
ITEM.factions = {FACTION_POLICE} -- Only a certain faction can buy this.
ITEM.classes = {FACTION_POLICE_CHIEF} -- Only a certain class can buy this.
ITEM.flag = "z" -- Only a character having a certain flag can buy this.
]]

-- If the item is purchasable, then you'll probably want to set a price for it:
--[[
ITEM.price = 5
]]

-- You can define additional actions for this item as such:
ITEM.functions.Spawn = {
    OnRun = function(item)
        local entity = ents.Create("ix_ccm")
        local eyeTrace = item.player:GetEyeTraceNoCursor()

        if (!IsValid(entity)) then
            item.player:Notify("Could not spawn entity!")
        end

        entity:SetPos(eyeTrace.HitPos)
        entity:SetNetVar("owner", item.player:GetName())
        if item:GetData("speedtier") == nil then
            
            entity:Setspeedtier(0)
            entity:Setbattery(0)
            entity:Setmaxbattery(100)
        else
            entity:Setspeedtier(item:GetData("speedtier"))
            entity:Setbattery(item:GetData("battery"))
            entity:Setmaxbattery(item:GetData("maxbattery"))
        end
        entity:Spawn()
    end
}
function ITEM:GetDescription()
    local description = Format(self.description)
    local charge = self:GetData("battery",0)
    local storage = self:GetData("storage",0)
    local speedtier = self:GetData("speedtier",0)
    local maxCharge = self:GetData("maxbattery")
    if charge && speedtier && storage then
        description = description .."\nBattery: ".. charge .."/"..maxCharge .."%\nSpeed Tier: " .. speedtier .. "\nStorage Tier: " .. storage
    end
    return description
end