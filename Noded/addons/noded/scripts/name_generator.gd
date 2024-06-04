class_name NodedNameGenerator


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
