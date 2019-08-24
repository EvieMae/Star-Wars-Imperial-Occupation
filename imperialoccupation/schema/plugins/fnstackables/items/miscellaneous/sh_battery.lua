ITEM.name = "Battery"
ITEM.model = ("models/starwars/syphadias/props/sw_tor/bioware_ea/items/harvesting/scavenge/broken_vehicle_element.mdl")
ITEM.description = "A battery, it can probably be used to charge a CCM."
ITEM.price = 70
ITEM.flag = "a"
ITEM.category = "Misc"
ITEM.basequantity = 1
ITEM.quantity = 1
ITEM.maxQuantity = 1
ITEM.isStackable = false
ITEM.canSplit = true
ITEM.weight = 0.1

ITEM.functions.Spawn = {
    OnRun = function(item)
        local entity = ents.Create("ix_battery")
        local eyeTrace = item.player:GetEyeTraceNoCursor()

        if (!IsValid(entity)) then
            item.player:Notify("Could not spawn entity!")
        end

        entity:SetPos(eyeTrace.HitPos)
        entity:SetNetVar("owner", item.player:GetName())
        entity:Spawn()
    end
}