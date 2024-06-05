class_name NodedNameGenerator


#region Culture names

## Generates any culture name
func generate_culture_name() -> String:
	var chosen := [0, 1, 2, 3].pick_random()
	
	match chosen:
		0: return generate_culture_name_coastal()
		1: return generate_culture_name_earth_based()
		2: return generate_culture_name_mystics()
		3: return generate_culture_name_warriors()
		_: return 'Oops...'

func generate_culture_name_warriors() -> String:
	var prefixes = [
		"Drae", "Vark", "Thul", "Gar", "Grim", "Krag", "Zor", "Bran",
		"Thar", "Drak", "Rav", "Vor", "Khor", "Bald", "Ur"
	]
	
	var suffixes = [
		"gan", "koran", "vath", "dar", "gorn", "thor", "mir", "rak",
		"dus", "nard", "loth", "mund", "gar", "zun", "dar"
	]
	
	var prefix := prefixes.pick_random()
	var suffix := suffixes.pick_random()
	
	return prefix + suffix

func generate_culture_name_mystics() -> String:
	var prefixes = [
		"Eldo", "Lumi", "Aethe", "Mysto", "Arcana", "Ordo", "Celesti", 
		"Sage", "Viri", "Seren", "Wis", "Thal", "Astra", "Philo", "Nex"
	]
	
	var suffixes = [
		"ria", "nara", "ryn", "phia", "thys", "dara", "lia", "theon", 
		"mir", "dria", "lon", "vela", "mara", "lith", "dil"
	]
	
	var prefix := prefixes.pick_random()
	var suffix := suffixes.pick_random()
	
	return prefix + suffix

func generate_culture_name_coastal() -> String:
	var prefixes = [
		"Mer", "Nauti", "Cors", "Pelag", "Mar", "Harb", "Seaf", 
		"Nav", "Ocean", "Aqu", "Port", "Tide", "Wave", "Bay", "Isl"
	]
	
	var suffixes = [
		"doria", "alis", "aria", "onia", "thor", "har", "port", 
		"mere", "strand", "breeze", "shore", "haven", "fleet", "coast", "wharf"
	]
	
	var prefix := prefixes.pick_random()
	var suffix := suffixes.pick_random()
	
	return prefix + suffix

func generate_culture_name_earth_based() -> String:
	var prefixes = [
		"Terra", "Sylva", "Agri", "Arbo", "Flor", "Gaia", "Horto", 
	"Fruc", "Herba", "Lush", "Vine", "Fert", "Botan", "Culti", "Past"
	]
	
	var suffixes = [
		"vine", "field", "bloom", "grove", "flora", "land", "vale", 
	"wood", "mead", "sprout", "croft", "terra", "root", "garden", "tide"
	]
	
	var prefix := prefixes.pick_random()
	var suffix := suffixes.pick_random()
	
	return prefix + suffix

#endregion


#region Character Names

func generate_warriors_name() -> String:
	return generate_full_name_from(
		["Drae", "Vark", "Thul", "Gar", "Grim", "Krag", "Zor", "Bran",
		"Thar", "Drak", "Rav", "Vor", "Khor", "Bald", "Ur"
	], 
	["gar", "tor", "grim", "vald", "rak", "vorn", "dorn", "kar",
		"zar", "thor", "gorn", "zorn", "mund", "vard", "zor"
	],
	["ian", "ar", "gath", "orn", "ok", "ak", "us", "on",
		"ir", "an", "in", "or", "ur", "ard", "ian"
	])

func generate_mystic_name() -> String:
	return generate_full_name_from(
		["Eldo", "Lumi", "Aethe", "Mysto", "Arcana", "Ordo", "Celesti", 
		"Sage", "Viri", "Seren", "Wis", "Thal", "Astra", "Philo", "Nex"
	],
	["ther", "lyn", "ara", "phi", "dara", "mir", "theon", "dria",
		"vala", "thys", "lith", "mar", "nia", "sor", "tera"
	],
	["ria", "nara", "ryn", "phia", "thys", "dara", "lia", "theon", 
		"mir", "dria", "lon", "vela", "mara", "lith", "dil"
	])

func generate_coastal_name() -> String:
	return generate_full_name_from(
		["Mer", "Nauti", "Cors", "Pelag", "Mar", "Harb", "Seaf", 
		"Nav", "Ocean", "Aqu", "Port", "Tide", "Wave", "Bay", "Isl"
	],
	["mar", "tide", "wave", "naut", "pel", "sea", "harb", "port", 
		"aqua", "ocean", "shore", "breeze", "isla", "reef", "bay"
	],
	["doria", "alis", "aria", "onia", "thor", "har", "port", 
		"mere", "strand", "breeze", "shore", "haven", "fleet", "coast", "wharf"
	])

func generate_traders_name() -> String:
	return generate_full_name_from(
		["Merc", "Barg", "Vend", "Trade", "Mark", "Deal", "Carg", 
		"Ship", "Stock", "Fair", "Exch", "Brok", "Supply", "Vend", "Trans"
	],
	["chant", "barg", "deal", "trade", "merch", "mark", "sell", "stock", 
		"vend", "broker", "ship", "cargo", "market", "fair", "trans"
	],
	["ant", "er", "or", "man", "ion", "ist", "or", "eer", 
		"ator", "ing", "age", "ment", "y", "ant", "or"
	])

func generate_planters_name():
	return generate_full_name_from(
		["Terra", "Sylva", "Agri", "Arbo", "Flor", "Gaia", "Horto", 
		"Fruc", "Herba", "Lush", "Vine", "Fert", "Botan", "Culti", "Past"
	],
	["cult", "flora", "herb", "grow", "seed", "plant", "harv", 
		"vine", "root", "crop", "field", "farm", "soil", "earth", "lush"
	],
	["vine", "field", "bloom", "grove", "flora", "land", "vale", 
		"wood", "mead", "sprout", "croft", "terra", "root", "garden", "tide"
	])


func generate_full_name_from(prefixes:Array[String], roots:Array[String], sufixes:Array[String]) -> String:
	var char_name := get_first_name()
	var sur_name := combine_name_from(prefixes, roots, sufixes)
	return char_name + " " + sur_name

func get_first_name() -> String:
	return [
	"Aiden", "Blaze", "Cora", "Dex", "Evelyn", "Finn", "Gideon", "Hara",
	"Isaac", "Juno", "Kai", "Lara", "Milo", "Nova", "Orion", "Piper",
	"Quinn", "Raven", "Sage", "Talon", "Uri", "Vera", "Wren", "Xander",
	"Yara", "Zane", "Lyra", "Max", "Nina", "Odin", "Pax", "Rhea",
	"Skye", "Theo", "Una", "Vaughn", "Wyatt", "Xara", "Zara", "Ari",
	"Bran", "Cleo", "Dax", "Elara", "Flynn", "Galen", "Hale", "Ivy",
	"Jasper", "Kira", "Luna", "Miles", "Nyx", "Oona", "Phoenix", "Quill",
	"Ryder", "Selene", "Thorne", "Uriah", "Vixen", "Wes", "Xen", "Zephyr",
	"Aspen", "Brynn", "Cael", "Dara", "Ember", "Finnian", "Gage", "Hollis",
	"Indigo", "Jett", "Koda", "Liora", "Mira", "Nico", "Oberon", "Petra",
	"Reeve", "Soren", "Thalia", "Ula", "Vega", "Willa", "Xanthe", "Zen",
	"Alaric", "Blaise", "Calista", "Dorian", "Evander", "Faye", "Griffin", "Helix",
	"Isolde", "Jax", "Keira", "Lennox", "Mara", "Nash", "Ophelia", "Paxton",
	"Ronan", "Seraphina", "Thane", "Ulric", "Valen", "West", "Xena", "Zion"
	].pick_random()

func combine_name_from(prefixes:Array[String], roots:Array[String], sufixes:Array[String]) -> String:
	var prefix := prefixes.pick_random()
	var sufix := sufixes.pick_random()
	
	if randf() > 0.5:
		var root := roots.pick_random()
		return str(prefix, root, sufix).to_pascal_case()
	else:
		return str(prefix, sufix).to_pascal_case()

#endregion

