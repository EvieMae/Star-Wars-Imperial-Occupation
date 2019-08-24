-- model models/lt_c/sci_fi/am_container.mdl
ITEM.name = "Tier One Battery Upgrade"
ITEM.model = ("models/props_lab/harddrive02.mdl")
ITEM.description = "A battery upgrade to increase the battery capacity on a CCM"
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
        local entity = ents.Create("ix_batteryupone")
        local eyeTrace = item.player:GetEyeTraceNoCursor()

        if (!IsValid(entity)) then
            item.player:Notify("Could not spawn entity!")
        end

        entity:SetPos(eyeTrace.HitPos)
        entity:SetNetVar("owner", item.player:GetName())
        entity:Spawn()
    end
}