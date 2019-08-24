AddCSLuaFile()

ENT.Type 		= "anim"
ENT.PrintName 	= "Gunsmithing Table"
ENT.Author	 	= "Lt. Taylor"
ENT.Spawnable 	= true
ENT.AdminOnly 	= true
ENT.RenderGroup	= RENDERGROUP_BOTH
ENT.Category 	= "Helix"

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/props/starwars/tech/machine.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self.loopsound = CreateSound(self, "plats/elevator_move_loop1.wav")
		self.receivers = {}
		local physicsObject = self:GetPhysicsObject()

		if (IsValid(physicsObject)) then
			physicsObject:Wake()
		end
	end
	
	local delay = 5
	local usertable = {}
	
	function ENT:Think()
		if CurTime() < delay then return end
		delay = CurTime() + 5
			
		local vec = self:GetPos()
		local enttable = ents.FindInSphere(vec, 50)
		local playertable = player.GetAll()
		for k,player in pairs(playertable) do
			for i,cachedplayer in pairs(usertable) do
				if player == cachedplayer then
					player:SetNetVar("table","")
					table.remove(usertable,i)
				end
			end
		end
		for k,v in pairs(enttable) do
			if v:IsPlayer() then
				if !table.HasValue(usertable,v) then
					table.insert(usertable,v)
				end
				v:SetNetVar("table","gunsmithing")
			end
		end
	end
else
	function ENT:Draw()
		self:DrawModel()
	end

	function ENT:onShouldDrawEntityInfo()
		return true
	end

	function ENT:onDrawEntityInfo(alpha)
		local position = (self:LocalToWorld(self:OBBCenter()) + self:GetUp()*16):ToScreen()
		local x, y = position.x, position.y

		ix.util.drawText("Weapons Fabrication Bench", x, y, ColorAlpha(ix.config.get("color"), 255), 1, 1, nil, 255 * 0.65)
		ix.util.drawText("A table with all the appropriate tools for weapons fabrication.", x, y + 16, ColorAlpha(color_white, 255), 1, 1, "ixSmallFont", 255 * 0.65)
	end
end