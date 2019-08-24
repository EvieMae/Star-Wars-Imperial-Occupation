local PANEL = {}

local list = {
		["citizen"] = Material("vgui/ids/citizenidv2.png", "noclamp smooth")
	}
local background = list["citizen"]
local ID = 0
function PANEL:Paint(w, h)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(background)
	surface.DrawTexturedRect(0, 0, 400, 200)
end

function PANEL:Init()
	self:SetSize(400, 200)
	self:SetTitle( "" )
	self:SetVisible( true )
	self:SetDraggable( true )
	self:ShowCloseButton( true )
	self:Center()
	self:MakePopup()
	
	self.firstname = self:InfoString()
	self.firstname:SetPos(210, 63)
	self.firstname:SetSize(250, 20)
	self.firstname.onTabPressed = function()
		self.lastname:RequestFocus()
	end
	self.firstname:SetContentAlignment(5)
	
	self.lastname = self:InfoString()
	self.lastname:SetPos(210, 100)
	self.lastname:SetSize(178, 20)
	self.lastname.onTabPressed = function()
		self.num:RequestFocus()
	end
	self.lastname:SetContentAlignment(5)
	
	self.num = self:InfoString()
	self.num:SetPos(210, 150)
	self.num:SetSize(262, 20)
	self.num.onTabPressed = function()
		self.firstname:RequestFocus()
	end
	self.num:SetContentAlignment(5)
	
	self.savebutton = self:Add( "DButton")
	self.savebutton:SetText( "Save" )					
	self.savebutton:SetPos(40, 10)				
	self.savebutton:SetSize(130, 130)					
	self.savebutton.DoClick = function()
		net.Start("SaveIDData")
		net.WriteUInt(ID,32)
		net.WriteString(self.firstname:GetValue())
		net.WriteString(self.lastname:GetValue())
		net.WriteString(self.num:GetValue())
		net.SendToServer()
		surface.PlaySound("garrysmod/ui_click.wav")
		self:Close()
	end
	
end
vgui.Register("IDWrite", PANEL, "DFrame")
net.Receive("WriteID",function()
	local IDType = net.ReadString()
	ID = net.ReadUInt(32) 
	if(IDType == "") then faction = "citizen" end
	background = list[IDType]
	vgui.Create( "IDWrite" )
end)

function PANEL:InfoString()
	local noteEditor = self:Add("DTextEntry")
	noteEditor:SetFont("Trebuchet24")
	noteEditor:SetMultiline(true)
	noteEditor:SetAllowNonAsciiCharacters(true)
	noteEditor.OnValueChange = function(_, value)
		chat.PlaySound()
	end
	noteEditor.OnKeyCodeTyped = function(name, keyCode)
		if (keyCode == KEY_TAB or keyCode == KEY_ENTER) then
			noteEditor:onTabPressed()
			return true
		end
	end
	noteEditor.Paint = self.paintTextEntry
	noteEditor:SetUpdateOnType(true)
	return noteEditor
end

function PANEL:paintTextEntry(w, h)
	surface.SetDrawColor(0, 0, 0, 0)
	surface.DrawRect(0, 0, w, h)
	self:DrawTextEntryText(color_white, color_white, color_white)
end
