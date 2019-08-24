ITEM.name = "ID Base"
ITEM.model = "models/Combine_Helicopter/helicopter_bomb01.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.desc = "ID Base"
ITEM.isStackable = false
ITEM.category = "IDs"
ITEM.type = ""
ITEM.noBusiness = true
ITEM.functions.Fill = {
	name = "Fill",
	icon = "icon16/book_edit.png",
	OnRun = function(item)
		net.Start("WriteID")
		net.WriteString(item.type)
		net.WriteUInt(item.id,32)
		net.Send(item.player)
		return false
	end,
	OnCanRun = function(item)
		
		return item:GetData("Full") != true
	end
}
ITEM.functions.Read = {
	name = "Read",
	icon = "icon16/book_open.png",
	OnRun = function(item)
		net.Start("ReadID")
		net.WriteString(item.type)
		net.WriteString(item:GetData("firstname"))
		net.WriteString(item:GetData("lastname") or "N/A")
		net.WriteString(item:GetData("ID"))
		if(item:GetData("photo") == nil) then
			item:SetData("photo",item.player:GetCharacter():GetData("headmodel"))
		end
		net.WriteString(item:GetData("photo"))
		net.Send(item.player)
		return false
	end,
		OnCanRun = function(item)
		return item:GetData("Full") == true
	end
}
ITEM.functions.Show = {
	name = "Show",
	icon = "icon16/book_open.png",
	OnRun = function(item)
		local target = item.player:GetEyeTraceNoCursor().Entity
		if(IsValid(target) and target:IsPlayer()) then
			net.Start("ReadID")
			net.WriteString(item.type)
			net.WriteString(item:GetData("firstname"))
			net.WriteString(item:GetData("lastname") or "N/A")
			net.WriteString(item:GetData("ID"))
			if(item:GetData("photo") == nil) then
				item:SetData("photo",item.player:GetCharacter():GetData("headmodel"))
			end
			net.WriteString(item:GetData("photo"))
			net.Send(target)
		end
		return false
	end,
		OnCanRun = function(item)
		return item:GetData("Full") == true
	end
}
net.Receive("SaveIDData",function(len,ply)
	local item = net.ReadUInt(32)
	ix.item.instances[item]:setData("firstname", net.ReadString())
	ix.item.instances[item]:setData("lastname",net.ReadString())
	ix.item.instances[item]:setData("ID",net.ReadString())
	ix.item.instances[item]:setData("Full",true)
end)