AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Scavengable Trash"
ENT.Category = "Helix"
ENT.Spawnable = true
if (SERVER) then
	function ENT:Initialize()
		print("SERVER INIT")
		print(CLIENT)
		self:SetModel("models/starwars/syphadias/props/sw_tor/bioware_ea/items/harvesting/scavenge/scavenge_junkpile.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self.delay = 5
		self.lastUse = 0
		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(true)
			
			physObj:Wake()
		end

	end


else 
	print("ELSE CLIENT")
	function ENT:Initialize()
		self:SetModel("models/starwars/syphadias/props/sw_tor/bioware_ea/items/harvesting/scavenge/scavenge_junkpile.mdl")
		print("TEST")
	end
	 	surface.CreateFont( "Crazy", {
			font = "Comic Sans", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
			extended = false,
			size = 35,
			weight = 1000,
			blursize = 0,
			scanlines = 0,
			antialias = true,
			underline = false,
			italic = false,
			strikeout = false,
			symbol = false,
			rotary = false,
			shadow = false,
			additive = false,
			outline = true,
		} )

	function ENT:Draw()
			self:DrawModel()
		 	--FONT--
		 	--local pos = Vector(self:GetPos().x,self:GetPos().y,self:GetPos().z + 5)
			local ang = self:GetAngles()
			print("DRAW")
		 	--local owner = self:Getowning_ent()
		    --owner = (IsValid(owner) and owner:Nick()) or DarkRP.getPhrase("unknown")
			ang:RotateAroundAxis(ang:Right(),-90)
			ang:RotateAroundAxis(ang:Up(),90)
			ang:RotateAroundAxis(ang:Forward(), -35)
			local pos = self:GetPos()

			cam.Start3D2D( pos  , ang, 0.1 )
				draw.RoundedBoxEx(4,0,0,1500,1500,Color(255, 255, 237,255),false,false,true,true)
				draw.RoundedBoxEx(4,0,0,1500,500,Color(35, 60, 135, 255),true,true,false,false)
				draw.DrawText("CCM","CCMTitle",0,-320,Color(100,100,255),1)
				draw.DrawText(tostring(self:GetNetVar("name")),"Crazy",0,-290,Color(100,100,255),1)
				draw.DrawText("Credit Count: " .. tostring(self:GetAmount()),"Crazy",0,-265,Color(100,100,255),1)
				draw.RoundedBoxEx(4,-50,-220,self:GetBattery()/10,25,Color(14, 232, 94,255),false,false,true,true)
				
				
			cam.End3D2D()
	end	
end

