-- The shared init file. You'll want to fill out the info for your schema and include any other files that you need.

-- Schema info
Schema.name = "Imperial Occupation"
Schema.author = "Clayworks"
Schema.description = "A Star Wars Imperial Occupation Schema"

-- Additional files that aren't auto-included should be included here. Note that ix.util.Include will take care of properly
-- using AddCSLuaFile, given that your files have the proper naming scheme.

-- You could technically put most of your schema code into a couple of files, but that makes your code a lot harder to manage -
-- especially once your project grows in size. The standard convention is to have your miscellaneous functions that don't belong
-- in a library reside in your cl/sh/sv_schema.lua files. Your gamemode hooks should reside in cl/sh/sv_hooks.lua. Logical
-- groupings of functions should be put into their own libraries in the libs/ folder. Everything in the libs/ folder is loaded
-- automatically.

ix.flag.Add("a","Testing trade flag")
ix.flag.Add("A","CSA Officer Flag")
ix.flag.Add("b","CSA Executive Flag")
ix.flag.Add("B","CSA Employee")
ix.flag.Add("c","CSA Trooper")
ix.flag.Add("C","Imperial Deathtrooper")
ix.flag.Add("d","Imperial Government")
ix.flag.Add("D","Imperial Government Officer")
ix.flag.Add("f","Imperial IOCI")
ix.flag.Add("F","Imperial Stormtrooper")
ix.flag.Add("g","Imperial Stormtrooper Officer")
ix.flag.Add("G","Nilra-Mann Cartel Soldier")
ix.flag.Add("h","Nilra-Mann Cartel High Command")
ix.flag.Add("H","Darvanos Syndicate Soldier")
ix.flag.Add("I","C.I.S Soldier")
ix.flag.Add("i","Darvanos Syndicate High Command")
ix.flag.Add("J","Deathwatch High Command")
ix.flag.Add("j","Deathwatch Soldier")
ix.flag.Add("k","Heavy Stormtrooper")
ix.flag.Add("K","CIS B2 Soldier")
ix.flag.Add("l","CIS High Command")
ix.flag.Add("L","Storm Commando")
ix.flag.Add("Z","Cuff Flag")

ix.util.Include("cl_schema.lua")
ix.util.Include("sv_schema.lua")

ix.util.Include("cl_hooks.lua")
ix.util.Include("sh_hooks.lua")
ix.util.Include("sv_hooks.lua")

-- You'll need to manually include files in the meta/ folder, however.
ix.util.Include("meta/sh_character.lua")
ix.util.Include("meta/sh_player.lua")

ix.anim.SetModelClass("models/clayworks/supercommando/male_mancom_01.mdl","player")
ix.anim.SetModelClass("models/outerrimrp/playermodels/male_merc1.mdl","player")
ix.anim.SetModelClass("models/outerrimrp/playermodels/female_merc1.mdl","player")
ix.anim.SetModelClass("models/clayworks/supercommando/male_mancom_02.mdl","player")
ix.anim.SetModelClass("models/helios/talon2.mdl","player")
ix.anim.SetModelClass("models/ven/tk/rem/tkrem.mdl","player")
ix.anim.SetModelClass("models/sono/swbf3/shadow.mdl","player")

ix.anim.SetModelClass("models/outerrimrp/playermodels/female_merc2.mdl","player")
ix.anim.SetModelClass("models/outerrimrp/playermodels/male_merc2.mdl","player")

ix.anim.SetModelClass("models/epangelmatikes/mtu/mtultimate.mdl","player")

ix.anim.SetModelClass("models/outerrimrp/playermodels/female_merc3.mdl","player")
ix.anim.SetModelClass("models/outerrimrp/playermodels/male_merc3.mdl","player")

ix.anim.SetModelClass("models/outerrimrp/playermodels/female_merc4.mdl","player")
ix.anim.SetModelClass("models/outerrimrp/playermodels/male_merc4.mdl","player")

ix.anim.SetModelClass("models/outerrimrp/playermodels/female_upperclass1.mdl","player")
ix.anim.SetModelClass("models/outerrimrp/playermodels/male_upperclass1.mdl","player")

ix.anim.SetModelClass("models/outerrimrp/playermodels/male_dengar.mdl","player")

ix.anim.SetModelClass("models/outerrimrp/playermodels/male_imperialmedic.mdl","player")
ix.anim.SetModelClass("models/outerrimrp/playermodels/male_imperialnavy.mdl","player")
ix.anim.SetModelClass("models/outerrimrp/playermodels/male_imperialtrooper.mdl","player")
ix.anim.SetModelClass("models/outerrimrp/playermodels/male_isard.mdl","player")
ix.anim.SetModelClass("models/outerrimrp/playermodels/male_isb.mdl","player")
ix.anim.SetModelClass("models/outerrimrp/playermodels/male_rgofficer.mdl","player")

ix.anim.SetModelClass("models/outerrimrp/playermodels/male_mandalorian1.mdl","player")
ix.anim.SetModelClass("models/outerrimrp/playermodels/male_mandalorian2.mdl","player")
ix.anim.SetModelClass("models/outerrimrp/playermodels/male_mandalorian3.mdl","player")
ix.anim.SetModelClass("models/outerrimrp/playermodels/male_mandalorian4.mdl","player")

ix.anim.SetModelClass("models/outerrimrp/playermodels/male_sandtrooper.mdl","player")
ix.anim.SetModelClass("models/outerrimrp/playermodels/male_scouttrooper.mdl","player")
ix.anim.SetModelClass("models/outerrimrp/playermodels/male_stormtrooper.mdl","player")

ix.anim.SetModelClass("models/kingpommes/starwars/playermodels/astromech.mdl","player")
ix.anim.SetModelClass("models/kingpommes/starwars/playermodels/gnk.mdl","player")
ix.anim.SetModelClass("models/kingpommes/starwars/playermodels/lin.mdl","player")
ix.anim.SetModelClass("models/kingpommes/starwars/playermodels/mouse.mdl","player")
ix.anim.SetModelClass("models/kingpommes/starwars/playermodels/wed.mdl","player")

ix.anim.SetModelClass("models/gonzo/ig88/ig88.mdl","player")

ix.anim.SetModelClass("models/player/strasser/wookie_warrior/wookie_warrior.mdl","player")

ix.anim.SetModelClass("models/player/valley/k2so.mdl","player")