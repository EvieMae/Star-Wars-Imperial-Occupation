local PLUGIN = PLUGIN
PLUGIN.name = "World Item Spawner"
PLUGIN.author = "Black Tea (NS 1.0), Neon (NS 1.1)"
PLUGIN.desc = "World Item Spawner."
PLUGIN.itempoints = PLUGIN.itempoints or {}

PLUGIN.spawngroups = { -- Example is based on HL2RP items.
	["default"] = {
		{"cortosisbox"},
		{"durasteelbox"},
		{"electricalcomponents"},
		{"neutroniumbarrel"},
		{"scrapmetal"},
		{"tools"},
		{"wastepile"},
	},
}

PLUGIN.spawnrate = 90
PLUGIN.maxitems = 2
PLUGIN.itemsperspawn = 2
PLUGIN.spawneditems = PLUGIN.spawneditems or {}

if SERVER then
	local spawntime = 1

	function PLUGIN:ItemShouldSave(entity)
		return (!entity.generated)
	end

	function PLUGIN:Think()
		if spawntime > CurTime() then return end
		spawntime = CurTime() + self.spawnrate
		for k, v in ipairs(self.spawneditems) do
			if (!v:IsValid()) then
				table.remove(self.spawneditems, k)
			end
		end

		if #self.spawneditems >= self.maxitems then return end

		for i = 1, self.itemsperspawn do
			if #self.spawneditems >= self.maxitems then
					table.remove(self.spawneditems)
				return
			end

			local v = table.Random(self.itempoints)

			if (!v) then
				return
			end


			local data = {}
			data.start = v[1]
			data.endpos = data.start + Vector(0, 0, 1)
			data.filter = client
			data.mins = Vector(-16, -16, 0)
			data.maxs = Vector(16, 16, 16)
			local trace = util.TraceHull(data)

			if trace.Entity:IsValid() then
				continue
			end
			
			local idat
			
			if self.spawngroups[v[2]] then
				idat = table.Random(self.spawngroups[v[2]])
			else
				idat = self.spawngroups["default"]
			end

			local val = v[1]
			local randitem = idat[math.random(1,#idat)][1]
			local item = ix.item.Spawn(randitem, val + Vector( math.Rand(-15,15), math.Rand(-15,15), 10 ), AngleRand())
		end
	end

	function PLUGIN:LoadData()
		self.itempoints = self:GetData() or {}
	end

	function PLUGIN:SaveData()
		self:SetData(self.itempoints)
	end

else

	netstream.Hook("ix_DisplaySpawnPoints", function(data)
		for k, v in pairs(data) do
			local emitter = ParticleEmitter( v[1] )
			local smoke = emitter:Add( "sprites/glow04_noz", v[1] )
			smoke:SetVelocity( Vector( 0, 0, 1 ) )
			smoke:SetDieTime(10)
			smoke:SetStartAlpha(255)
			smoke:SetEndAlpha(255)
			smoke:SetStartSize(64)
			smoke:SetEndSize(64)
			smoke:SetColor(255,186,50)
			smoke:SetAirResistance(300)
		end
	end)

end

ix.command.Add("itemspawnadd", {
	adminOnly = true,
	arguments = ix.type.text,
	OnRun = function(self, client, arguments)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local spawngroup = arguments[1] or "default"
		table.insert( PLUGIN.itempoints, { hitpos, spawngroup } )
		client:Notify( "You added ".. spawngroup .. " item spawner." )
	end
})

ix.command.Add("itemspawnremove", {
	adminOnly = true,
	OnRun = function(self, client, arguments)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local range = arguments[1] or 128
		local mt = 0
		for k, v in pairs( PLUGIN.itempoints ) do
			local distance = v[1]:Distance( hitpos )
			if distance <= tonumber(range) then
				PLUGIN.itempoints[k] = nil
				mt = mt + 1
			end
		end
		client:Notify( mt .. " item spawners has been removed.")
	end
})
ix.command.Add("itemspawnremoveall", {
	adminOnly = true,
	OnRun = function(self, client, arguments)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local range = arguments[1] or 128
		local mt = 0
		for k, v in pairs( PLUGIN.itempoints ) do
				PLUGIN.itempoints[k] = nil
				mt = mt + 1
		
		end
		client:Notify( mt .. " item spawners has been removed.")
	end
})

ix.command.Add("itemspawndisplay", {
	adminOnly = true,
	OnRun = function(self, client, arguments)
		if SERVER then
			netstream.Start(client, "ix_DisplaySpawnPoints", PLUGIN.itempoints)
			client:Notify( "Displayed All Points for 10 secs." )
		end
	end
})