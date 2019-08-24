local PLUGIN = PLUGIN

AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Safebox"
ENT.Category = "ixScript"
ENT.Spawnable = true
ENT.AdminOnly = true

if (SERVER) then
	function ENT:Initialize()
		self:SetModel(ix.config.Get("safeModel"))
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self.receivers = {}

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(true)
			physObj:Wake()
		end
	end

	function ENT:CreateInv(activator)
		local character = activator:GetCharacter()
		ix.item.RegisterInv("safe."..character:GetID(), ix.config.Get("safeWidth"), ix.config.Get("safeHeight"))
		ix.item.NewInv(character:GetID(), "safe."..character:GetID(), function(inventory)
			character:SetData("safebox", inventory:GetID())
		end)
  	end

	function ENT:getInv(activator)
		local index = activator:GetChar():GetData("safebox")

		if (index) then
			return ix.item.inventories[index]
		end
	end

	function ENT:RestoreInv(activator)
		local character = activator:GetCharacter()
		local index = character:GetData("safebox")
		local inventory = ix.item.inventories[index]

		if (index) then
			if (inventory) then
				inventory:sync(activator)
			else
				ix.item.RestoreInv(index, ix.config.Get("safeWidth"), ix.config.Get("safeHeight"), function(inventory)
					inventory:SetOwner(character, true)
				end)
			end
		else
			self:CreateInv(activator)
		end
	end

	function ENT:OpenInv(activator)
		local index = activator:GetCharacter():GetData("safebox")


		if (index) then
			netstream.Start(activator, "safeOpen", index)
		else
			self:RestoreInv(activator)
		end
	end

	function ENT:Use(activator)
		self:OpenInv(activator)
	end

else
		netstream.Hook("safeOpen", function(index)
			local inventory = ix.item.inventories[index]

			ix.gui.inv1 = vgui.Create("ixInventory")
			ix.gui.inv1:ShowCloseButton(true)
			ix.gui.inv1:CenterVertical()

			local inventory2 = LocalPlayer():GetChar():GetInv()

			if (inventory2) then
				ix.gui.inv1:SetInventory(inventory2)
			end

			local panel = vgui.Create("ixInventory")
			panel:ShowCloseButton(true)
			panel:SetTitle("Safebox")
			panel:SetInventory(inventory)
			panel:MoveRightOf(ix.gui.inv1, 4)
			panel:MakePopup()

			panel.OnClose = function(this)
				if (IsValid(ix.gui.inv1) and !IsValid(ix.gui.menu)) then
					ix.gui.inv1:Remove()
				end
			end
			local oldClose = ix.gui.inv1.OnClose

			ix.gui.inv1.OnClose = function()
				if (IsValid(panel) and !IsValid(ix.gui.menu)) then
					panel:Remove()
				end
				ix.gui.inv1.OnClose = oldClose
			end

			ix.gui["inv"..index] = panel

		end)

		ENT.DrawEntityInfo = true
		local toScreen = FindMetaTable("Vector").ToScreen
		local colorAlpha = ColorAlpha
		local drawText = ix.util.drawText
		local configGet = ix.config.Get

		function ENT:onDrawEntityInfo(alpha)
			local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)))
			local x, y = position.x, position.y
			local tx, ty = drawText("Safebox", x, y, colorAlpha(configGet("color"), alpha), 1, 1, nil, alpha * 2)
		end
end
