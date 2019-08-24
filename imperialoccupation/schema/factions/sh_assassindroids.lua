-- Since this faction is not a default, any player that wants to become part of this faction will need to be manually
-- whitelisted by an administrator.

FACTION.name = "Assassin Droids"
FACTION.description = "Droids built for the explicit purpose of assassination."
FACTION.color = Color(186, 186, 186)
FACTION.weapons = {"tfa_mercenarypistol","sswep_probe"}
FACTION.isGloballyRecognized = false 	-- Makes it so that everyone knows the name of the characters in this faction.

-- Note that FACTION.models is optional. If it is not defined, it will use all the standard HL2 citizen models.
FACTION.models = {
	"models/gonzo/ig88/ig88.mdl",
}

FACTION_AD = FACTION.index