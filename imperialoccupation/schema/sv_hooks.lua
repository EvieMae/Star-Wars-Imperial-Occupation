-- Here is where all of your serverside hooks should go.

-- Change death sounds of people in the police faction to the metropolice death sound.
function Schema:GetPlayerDeathSound(client)
	local character = client:GetCharacter()

	if (character and character:IsPolice()) then
		return "NPC_MetroPolice.Die"
	end
end

function Schema:PlayerSpray(ply)
    return true
end

local TrooperTable = {
    "models/outerrimrp/playermodels/male_stormtrooper.mdl",
    "models/outerrimrp/playermodels/male_scouttrooper.mdl",
    "models/outerrimrp/playermodels/male_sandtrooper.mdl",
    "models/player/hydro/swbf_deathtrooper/swbf_deathtrooper3.mdl",
    "models/player/tank_trooper/tank_trooper.mdl",
    "models/ven/tk/rem/tkrem.mdl",
    "models/player/ven/tk_sand_02/tk_sand.mdl",
    "models/sono/swbf3/shadow.mdl",
    "models/player/fatal/troopers/commander.mdl",
    "models/player/fatal/troopers/trooper.mdl",
    "models/player/fatal/troopers/officer.mdl",
    "models/player/fatal/troopers/sergeant.mdl",
    "models/exec/swbf2015/playermodels/exec_stormtrooper.mdl"
}

function Schema:PlayerFootstep(client, position, foot, soundName, volume)
	local factionTable = ix.faction.Get(client:Team())

	if (factionTable.runSounds and client:IsRunning()) then
	    if table.HasValue(TrooperTable, client:GetModel()) then
		    client:EmitSound(factionTable.runSounds[foot])
		    return true
		end
	end

	client:EmitSound(soundName)
	return true
end