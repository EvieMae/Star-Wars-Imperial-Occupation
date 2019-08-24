-- model  models/lt_c/sci_fi/lamp.mdl models/lt_c/sci_fi/lantern.mdl  models/lt_c/sci_fi/light_spotlight.mdl
ITEM.name = "Tier Three Storage Upgrade"
ITEM.model = ("models/lt_c/sci_fi/light_spotlight.mdl")
ITEM.description = "A storage upgrade to increase the storage capacity on a CCM"
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
        local entity = ents.Create("ix_storageupthree")
        local eyeTrace = item.player:GetEyeTraceNoCursor()

        if (!IsValid(entity)) then
            item.player:Notify("Could not spawn entity!")
        end

        entity:SetPos(eyeTrace.HitPos)
        entity:SetNetVar("owner", item.player:GetName())
        entity:Spawn()
    end
}