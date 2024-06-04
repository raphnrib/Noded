extends Resource
class_name SpaceSection

enum tp { NONE, ENUMS, VARS, METHODS, PARAMS, TRANSITIONS }

@export var type : tp
@export var next_index : int = 0
@export var items_array : Array[Space]
@export var owner_code : int = 0

var names_list: Array[String]:
	get: return SS.get_list_of_names(items_array)

var has_items : bool:
	get: return !items_array.is_empty()

signal section_info_changed


func get_section_type() -> tp:
	return tp.NONE


## Add item override blueprint
#func add_new_item() -> Space:
	#var n_space = Space.new()
	#initialize_append_space('Space', next_index, n_space)
	#return s_space


## add_new_item method blueprint
#func add_new_item() -> Space:
	#var n_space = Space.new()
	#initialize_append_space('Space', next_index, n_space)
	#return n_space


# func add_new_item() -> Space:
#	var n_space = Space.new()
#	initialize_append_space('Name', next_index, n_space)
#	section_info_changed.emit()
#	return n_space

func add_new_item() -> Space:
	if type == tp.NONE:
		MSN.msn("Ops... My bad! Class Section is 'NONE'!")
		printerr("Method 'get_section_type' not overriten in 'ClassSection instance script")
		return
	
	if type == tp.ENUMS: ## ADD ENUM
		var n_enum = EnumSpace.new()
		initialize_append_space('Enum', next_index, n_enum)
		section_info_changed.emit()
		return n_enum
		
	if type == tp.VARS: ## ADD VAR
		var v_space = VarSpace.new()
		initialize_append_space('Enum', next_index, v_space)
		section_info_changed.emit()
		return v_space
	
	return null

#region Getting Info
func get_item_by_name(named:String) -> Space:
	for i in items_array:
		if i.name == named:
			return i
	return null

func get_item_code(named:String) -> int:
	for i in items_array:
		if i.name == named:
			return i.code
	return -1

func get_item_by_code(code:int) -> Space:
	for i in items_array:
		if i.code == code:
			return i
	return null

func get_item_name(code:int) -> String:
	for i in items_array:
		if i.code == code:
			return i.name
	return "-none-"
#endregion

func remove_item(item:Space):
	items_array.erase(item)


func initialize_append_space(gen_name:String, index:int, space:Space):
	space.name = str(gen_name, next_index)
	space.node_name = str(gen_name, "Container")
	space.code = index
	space.owner_code = owner_code
	
	next_index += 1
	items_array.append(space)

func check_unique_name(new_name:String) -> String:
	return SS.get_unique_name_from_strings(new_name, names_list)
