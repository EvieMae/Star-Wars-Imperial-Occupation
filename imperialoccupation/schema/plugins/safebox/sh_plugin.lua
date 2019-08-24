PLUGIN.name = "Safebox"
PLUGIN.author = "La Corporativa"
PLUGIN.desc = "A plugin that allows players to have a safe place to store their items."

ix.config.Add("safeModel", "models/releasepackprops/crate4.mdl", "The model of the safe", nil, {
		category = "Safebox"
})
ix.config.Add("safeHeight", 8, "The height of the safe", nil, {
		category = "Safebox"
})
ix.config.Add("safeWidth", 8, "The width of the safe", nil, {
		category = "Safebox"
})

if (SERVER) then

	function PLUGIN:SaveData()
		local data = {}

		for k, v in ipairs(ents.FindByClass("ix_safebox")) do
			data[#data + 1] = {v:GetPos(), v:GetAngles(), v:GetModel()}
		end

		self:SetData(data)
	end

	function PLUGIN:LoadData()
		local data = self:GetData()

		if (data) then
			for k, v in ipairs(data) do
				local storage = ents.Create("ix_safebox")
				storage:SetPos(v[1])
				storage:SetAngles(v[2])
				storage:Spawn()
				storage:SetModel(v[3])
				storage:SetSolid(SOLID_VPHYSICS)
				storage:PhysicsInit(SOLID_VPHYSICS)

				local physObject = storage:GetPhysicsObject()

				if (physObject) then
					physObject:EnableMotion()
				end
			end
		end
	end
end
