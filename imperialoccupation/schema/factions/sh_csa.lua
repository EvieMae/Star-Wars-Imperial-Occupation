
-- Since this faction is not a default, any player that wants to become part of this faction will need to be manually
-- whitelisted by an administrator.

FACTION.name = "Corporate Sector Authority"
FACTION.description = "Corporate Sector Authority Employees and Managerial Staff."
FACTION.color = Color(20, 120, 185)
FACTION.pay = 75				 			-- How much money every member of the faction gets paid at regular intervals.
FACTION.payTime = 3600
FACTION.isGloballyRecognized = false 	-- Makes it so that everyone knows the name of the characters in this faction.

-- Note that FACTION.models is optional. If it is not defined, it will use all the standard HL2 citizen models.
FACTION.models = {
	"models/clayworks/outfits/male_merc4.mdl",
	"models/clayworks/outfits/female_merc4.mdl",
}

FACTION_CSA = FACTION.index
