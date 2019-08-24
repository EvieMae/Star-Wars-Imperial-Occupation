-- Since this faction is not a default, any player that wants to become part of this faction will need to be manually
-- whitelisted by an administrator.

FACTION.name = "Corellian Imperial Garrison"
FACTION.description = "The Corellian Imperial Garrison"
FACTION.color = Color(186, 186, 186)
FACTION.weapons = {"weapon_cuff_elastic", "weapon_stunstick"}
FACTION.pay = 175			 			-- How much money every member of the faction gets paid at regular intervals.
FACTION.payTime = 3600
FACTION.isGloballyRecognized = false 	-- Makes it so that everyone knows the name of the characters in this faction.
FACTION.runSounds = {[0] = "NPC_MetroPolice.RunFootstepLeft", [1] = "NPC_MetroPolice.RunFootstepRight"}

-- Note that FACTION.models is optional. If it is not defined, it will use all the standard HL2 citizen models.
FACTION.models = {
	"models/outerrimrp/playermodels/male_merc1.mdl",
	"models/outerrimrp/playermodels/female_merc1.mdl",
}

FACTION_IMP = FACTION.index