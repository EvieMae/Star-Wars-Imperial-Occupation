-- Since this faction is not a default, any player that wants to become part of this faction will need to be manually
-- whitelisted by an administrator.

FACTION.name = "Imperial Security Droid"
FACTION.description = "Droids built for imperial security purposes."
FACTION.color = Color(186, 186, 186)
FACTION.weapons = {"tfa_swch_e5"}
FACTION.isGloballyRecognized = false 	-- Makes it so that everyone knows the name of the characters in this faction.

-- Note that FACTION.models is optional. If it is not defined, it will use all the standard HL2 citizen models.
FACTION.models = {
	"models/player/valley/k2so.mdl",
}

FACTION_ISD = FACTION.index