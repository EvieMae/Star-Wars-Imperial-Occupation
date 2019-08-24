-- Since this faction is not a default, any player that wants to become part of this faction will need to be manually
-- whitelisted by an administrator.

FACTION.name = "C.I.S Remnant"
FACTION.description = "The C.I.S Remnants"
FACTION.color = Color(186, 186, 186)
FACTION.isGloballyRecognized = false 	-- Makes it so that everyone knows the name of the characters in this faction.

-- Note that FACTION.models is optional. If it is not defined, it will use all the standard HL2 citizen models.
FACTION.models = {
	"models/player/hydro/b1_battledroids/assault/b1_battledroid_assault.mdl",
}

FACTION_CIS = FACTION.index