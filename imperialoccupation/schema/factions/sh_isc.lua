-- Since this faction is not a default, any player that wants to become part of this faction will need to be manually
-- whitelisted by an administrator.

FACTION.name = "Imperial Supply Company"
FACTION.description = "Imperial Supply Company Employees and Managerial Staff."
FACTION.color = Color(186, 186, 186)
FACTION.isGloballyRecognized = false 	-- Makes it so that everyone knows the name of the characters in this faction.

-- Note that FACTION.models is optional. If it is not defined, it will use all the standard HL2 citizen models.
FACTION.models = {
	"models/outerrimrp/playermodels/female_merc1.mdl",
	"models/outerrimrp/playermodels/male_merc1.mdl"
}

FACTION_ISC = FACTION.index