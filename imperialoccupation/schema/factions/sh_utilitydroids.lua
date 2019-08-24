-- Since this faction is not a default, any player that wants to become part of this faction will need to be manually
-- whitelisted by an administrator.

FACTION.name = "Utility Droids"
FACTION.description = "Utility Droids for various purposes."
FACTION.color = Color(186, 186, 186)
FACTION.weapons = {"sswep_gonk","sswep_mouse","sswep_probe","sswep_bb8"}
FACTION.isGloballyRecognized = false 	-- Makes it so that everyone knows the name of the characters in this faction.

-- Note that FACTION.models is optional. If it is not defined, it will use all the standard HL2 citizen models.
FACTION.models = {
	"models/kingpommes/starwars/playermodels/astromech.mdl",
	"models/kingpommes/starwars/playermodels/gnk.mdl",
	"models/kingpommes/starwars/playermodels/lin.mdl",
	"models/kingpommes/starwars/playermodels/mouse.mdl",
	"models/kingpommes/starwars/playermodels/wed.mdl",
}

FACTION_UD = FACTION.index