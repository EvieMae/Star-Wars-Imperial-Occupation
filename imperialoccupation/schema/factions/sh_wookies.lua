-- Since this faction is not a default, any player that wants to become part of this faction will need to be manually
-- whitelisted by an administrator.

FACTION.name = "Wookie"
FACTION.description = "Wookiees are fictional hirsute humanoids in the Star Wars universe. They come from the planet Kashyyyk and are taller and stronger than most humans."
FACTION.color = Color(186, 186, 186)
FACTION.weapons = {"tfa_bowcaster"}
FACTION.isGloballyRecognized = false 	-- Makes it so that everyone knows the name of the characters in this faction.

-- Note that FACTION.models is optional. If it is not defined, it will use all the standard HL2 citizen models.
FACTION.models = {
	"models/player/strasser/wookie_warrior/wookie_warrior.mdl",
}

FACTION_WK = FACTION.index