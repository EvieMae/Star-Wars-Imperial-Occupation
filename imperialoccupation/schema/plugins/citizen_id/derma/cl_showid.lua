local PANEL = {}

local list = {
		["citizen"] = Material("vgui/ids/citizenidv2.png", "noclamp smooth")
	}
local background = list["citizen"]
local firstnametext = ""
local lastnametext = ""
local IDtext = ""
local model = ""
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
	
	self.firstname = self:Add("DLabel")
	self.firstname:SetPos(175, 63)
	self.firstname:SetSize(250, 20)
	self.firstname:SetFont("Trebuchet24")
	self.firstname:SetText(firstnametext)
	self.firstname:SetTextColor(color_white)
	self.firstname:SetContentAlignment(5)
	
	self.lastname = self:Add("DLabel")
	self.lastname:SetPos(210, 100)
	self.lastname:SetSize(178, 20)
	self.lastname:SetFont("Trebuchet24")
	self.lastname:SetText(lastnametext)
	self.lastname:SetTextColor(color_white)
	self.lastname:SetContentAlignment(5)
	
	self.ID = self:Add("DLabel")
	self.ID:SetPos(167, 150)
	self.ID:SetSize(262, 20)
	self.ID:SetFont("Trebuchet24")
	self.ID:SetText(IDtext)
	self.ID:SetTextColor(color_white)
	self.ID:SetContentAlignment(5)

	self.model = self:Add("DModelPanel")
	self.model:SetPos(40, 10)
	self.model:SetSize( 130 ,130 )
	self.model:SetModel(model)
	local temp = self.model
	function self.model:LayoutEntity( Entity ) 
		Entity:SetSequence( 0 )
		temp:RunAnimation()
		return 
	end
	local eyepos = self.model.Entity:GetBonePosition( self.model.Entity:LookupBone( "ValveBiped.Bip01_Head1" ) )
	eyepos:Add( Vector( 0, 0, 2 ) )
	self.model:SetLookAt( eyepos )
	self.model:SetCamPos( eyepos-Vector( -15, 0, 0 ) )
	
end


vgui.Register("IDShow", PANEL, "DFrame")
net.Receive("ReadID",function()
	local idtype = net.ReadString()
	firstnametext = net.ReadString()
	lastnametext = net.ReadString()
	IDtext = net.ReadString()
	model = net.ReadString()
	if(idtype == "") then idtype = "citizen" end
	background = list[idtype]
	vgui.Create( "IDShow" )
end)