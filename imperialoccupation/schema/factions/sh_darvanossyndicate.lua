-- Since this faction is not a default, any player that wants to become part of this faction will need to be manually
-- whitelisted by an administrator.

FACTION.name = "Darvanos Syndicate"
FACTION.description = "The Darvanos Syndicate"
FACTION.color = Color(186, 186, 186)
FACTION.weapons = {"tfa_752_westar34"}
FACTION.isGloballyRecognized = false 	-- Makes it so that everyone knows the name of the characters in this faction.

-- Note that FACTION.models is optional. If it is not defined, it will use all the standard HL2 citizen models.
FACTION.models = {
	"models/outerrimrp/playermodels/male_merc3.mdl",
	"models/outerrimrp/playermodels/female_merc3.mdl",
}

FACTION_DS = FACTION.index