ITEM.name = "Nice name"
ITEM.description = "Nice desc"
ITEM.width = 2
ITEM.height = 2
ITEM.isClothing = true
ITEM.price = 1
ITEM.model = "models/props_c17/BriefCase001a.mdl"
ITEM.playermodel = nil
ITEM.ap = 1
ITEM.quantity = 1

ITEM:Hook("drop", function(item)
	if (item:GetData("equip")) then
		item:SetData("equip", nil)
		item.player:SetModel(item.player:GetChar():GetModel())
	end
end)

ITEM.functions.RemoveUpgrade = {
	name = "Remove",
	tip = "Remove",
	icon = "icon16/wrench.png",
    isMulti = true,
    multiOptions = function(item, client)
	
	local targets = {}

	for k, v in pairs(item:GetData("mod", {})) do
    local attTable = ix.item.list[v[1]]
    local niceName = attTable:GetName()
    table.insert(targets, {
		name = niceName,
		data = k,
    })
    end
    return targets
end,
	OnCanRun = function(item)
		if (table.Count(item:GetData("mod", {})) <= 0) then
			return false
		end
				
		return (!IsValid(item.entity))
	end,
	OnRun = function(item, data)
		local client = item.player
		local target = data
		
		for k,v in pairs(data) do
			data = v
		end
		
		if (data) then
			local char = client:GetChar()

			if (char) then
				local inv = char:GetInv()

				if (inv) then
					local mods = item:GetData("mod", {})
					local attData = mods[data]
					local bodygs = item:GetData("Bodygroups",{})
					if (attData) then
						
                        curPrice = item:GetData("RealPrice")
                	    if !curPrice then
                		    curPrice = item.price
                		end
                		
                        item:SetData("RealPrice", (curPrice - ix.item.list[attData[1]].price))
                        
						
						local nomodel = true
						
						for k,v in pairs(ix.item.list[attData[1]].models) do
							if client:GetModel() == v then
								for x,y in pairs(ix.item.list[attData[1]].bgnames) do
									local x = client:FindBodygroupByName(y)
									if x >= 0 then 
										client:SetBodygroup(x,0)
										bodygs[x] = nil
									end
								end 
								nomodel = false
							end
						end
						
						if nomodel == true then 
							client:NotifyLocalized("Equip Outfit")
							return false 
						end
						
						item:SetData("Bodygroups",bodygs)
						
						local itemweight = item:GetData("weight",0)
						local itemap = item:GetData("addap",0)
                        local targetweight = ix.item.list[attData[1]].weight
                        local totweight = itemweight - targetweight
						local totap = itemap - ix.item.list[attData[1]].ap
                        item:SetData("weight",totweight)
						item:SetData("addap",totap)
						client.armor.ap = (totap + item.ap)
                        item.weight = totweight
						
						client:EmitSound("cw/holster4.wav")
						inv:Add(attData[1])
						
						mods[data] = nil
						if (table.Count(mods) == 0) then
							item:SetData("mod", nil)
						else
							item:SetData("mod", mods)
						end
						
					else
						client:NotifyLocalized("Not an Upgrade")
					end
				end
			end
		else
			client:NotifyLocalized("detTarget")
		end
	return false
end,
}

ITEM.functions.UnEquip =
{
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/cross.png",
	OnRun = function(item)
		local client = item.player
		client.armor = client.armor or {}
		
		for k,v in pairs(item:GetData("Bodygroups",{})) do
			client:SetBodygroup(k,0)
		end
		
		item.player:SetSkin(0)
		client.armor["ap"] = 0
		client:GetCharacter():SetData("ap",client.armor["ap"])
		item.player:SetModel(item.player:GetChar():GetModel())
		item:SetData("equip", false)
		return false
	end,

	OnCanRun = function(item)
		return (!IsValid(item.entity) and item:GetData("equip") == true)
	end
}

ITEM.functions.Equip =
{
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/tick.png",
		OnRun = function(item)
		local client = item.player
		local items = client:GetChar():GetInv():GetItems()
		for k, v in pairs(items) do
			if (v.id != item.id) then
				if (v.isClothing == true and v:GetData("equip")) then
					item.player:NotifyLocalized("You've already equipped another Outfit.")
					return false
				end
			end
		end
		client.armor = client.armor or {}
		client:SetModel(item.playermodel)
		client:SetSkin(item.skin or 0)
		
		for k,v in pairs(item:GetData("Bodygroups",{})) do
			client:SetBodygroup(k,v[2])
		end 
		
		client.armor["ap"] = (item:GetData("addap",0) + item.ap)
		item:SetData("equip", true)
		client:GetCharacter():SetData("ap",client.armor["ap"])
        client:SetupHands()
		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity) and item:GetData("equip") ~= true)
	end
}

function ITEM:onCanBeTransfered(oldInventory, newInventory) return true end
function ITEM:onTransfered()
	if self:GetData("equip") then self:SetData("equip", false) end
end

function ITEM:onInstanced()
	return
end

function ITEM:OnLoadout()
	if (self:GetData("equip")) then
		local client = self.player
		
		for k,v in pairs(self:GetData("Bodygroups",{})) do
			client:SetBodygroup(k,0)
		end
		
		self.player:SetModel(self.player:GetChar():GetModel())
		self:SetData("equip", false)
	end
end

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		local durability = math.Round(item:GetData("durability", 10000)/100)
		surface.SetDrawColor(item:GetData("equip") and Color(110, 255, 110, 100) or Color(255, 110, 110, 100))
		surface.DrawRect(w - 14, 14, 8, 8)
	end
end

function ITEM:GetDescription()
	local description = self.description
	local weight = self:GetData("weight",0)
	local starting = self:GetData("SpawnItem",false)
	
	if starting then
		description = "[STARTING ITEM - NO VALUE]\n" .. description
	end
	
	weight = weight + self.weight
	description = description.."\nWeight: "..weight.."kg"
	description = description.."\n[*] AP: "..(self:GetData("addap",0) + self.ap)

    local attachnames = ""

    for k, v in pairs(self:GetData("mod", {})) do
        local attTable = ix.item.list[v[1]]
        local niceName = attTable:GetName()
        attachnames = attachnames .. "\n" .. niceName
    end
    
    description = description .. attachnames

	return description
end