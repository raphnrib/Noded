extends Node

#region Var indexes
enum VarType { BOOL, INT, FLOAT, STR, DICT, ARRAY, VEC2, VEC2i, VEC3, VEC3i, VEC4, VEC4i, QUAT, RCT2, RCT2i, TRNSF_2D, TRNSF_3D, BASIS, COLOR, PLANE, AABB_VAL, PROJCTN, STR_NAME, ND_PATH, PKBYTE, PKINT32, PKINT64, PKFL32, PKFL64, PKSTR, PKV2, PKV3, PKCOL }

# Variable types listings
const STRING_VAR_TYPE	= 0
const NOT_DEFINED = 1

const INT_VAR_TYPE		= 10
const INT_VEC2_VAR_TYPE		= 11
const INT_VEC3_VAR_TYPE		= 12
const INT_VEC4_VAR_TYPE		= 13

const FLOAT_VAR_TYPE	= 20
const FLOAT_VEC2_VAR_TYPE	= 21
const FLOAT_VEC3_VAR_TYPE	= 22
const FLOAT_VEC4_VAR_TYPE	= 23

const BOOL_VAR_TYPE		= 30

const REFERENCE_VAR_TYPE	= 40
const ENUM_VAR_TYPE = 41

# Functions types listings
const FUNCTION_IN_OUT	= 50
const FUNC_START_NODE	= 51
const FUNC_RETURN_NODE	= 52
const FUNC_CALL_NODE	= 53
#endregion

#region Default Colors
const COL_LIGHT_GREEN= Color('55efc4')
const COL_GREEN = Color('00b894')
const COL_YELLOW = Color('ffeaa7')
const COL_ORANGE = Color('fdcb6e')
const COL_CYAN = Color('81ecec')
const COL_DARK_CYAN = Color('00cec9')
const COL_LIGHT_PINK = Color('fab1a0')
const COL_GUAVA = Color('e17055')
const COL_LIGH_BLUE = Color('74b9ff')
const COL_BLUE = Color('0984e3')
const COL_LIGHT_RED = Color('ff7675')
const COL_RED = Color('d63031')
const COL_LIGHT_PURPLE = Color('a29bfe')
const COL_PURPLE = Color('6c5ce7')
const COL_PINK = Color('fd79a8')
const COL_SHOCK_PINK = Color('e84393')

const COL_CLEAN_GRAY = Color('dfe6e9')
const COL_LIGHT_GRAY = Color('b2bec3')
const COL_GRAY = Color('636e72')
const COL_DARK_GRAY = Color('2d3436')

#endregion


func get_unique_name(curr_name:String, compare_list, iteration:int=0) -> String:
	var name_to_look = curr_name if iteration == 0 else curr_name + str(iteration)
	if !compare_list.is_empty():
		for v in compare_list:
			if v == name_to_look:
				name_to_look = get_unique_name(curr_name, compare_list, iteration+1)
				break
	
	return name_to_look


func get_name_of_type(tp:int) -> String:
	match tp:
		STRING_VAR_TYPE:
			return "string"
		BOOL_VAR_TYPE:
			return "bool"
		INT_VAR_TYPE:
			return "int"
		INT_VEC2_VAR_TYPE:
			return "Vector2i"
		INT_VEC3_VAR_TYPE:
			return "Vector3i"
		INT_VEC4_VAR_TYPE:
			return "Vector4i"
		
		FLOAT_VAR_TYPE:
			return "float"
		FLOAT_VEC2_VAR_TYPE:
			return "Vector2"
		FLOAT_VEC3_VAR_TYPE:
			return "Vector3"
		FLOAT_VEC4_VAR_TYPE:
			return "Vector4"
		
		FUNCTION_IN_OUT:
			return "Func"
		FUNC_CALL_NODE:
			return "Func Call"
		FUNC_RETURN_NODE:
			return "Func return"
		FUNC_START_NODE:
			return "func"
		
		ENUM_VAR_TYPE:
			return 'enum'
		
		NOT_DEFINED:
			return "undef"
	
	return "unknown type"

func get_default_value_for(tp:int) -> Variant:
	if tp == STRING_VAR_TYPE:
		return ""
	if tp == BOOL_VAR_TYPE:
		return false
	if tp == INT_VAR_TYPE:
		return 0
	if tp == INT_VEC2_VAR_TYPE:
		return Vector2i(0,0)
	if tp == INT_VEC3_VAR_TYPE:
		return Vector3i(0,0,0)
	if tp == INT_VEC4_VAR_TYPE:
		return Vector4i(0,0,0,0)
	if tp == FLOAT_VAR_TYPE:
		return 0.0
	if tp == FLOAT_VEC2_VAR_TYPE:
		return Vector2(0.0, 0.0)
	if tp == FLOAT_VEC3_VAR_TYPE:
		return Vector3(0.0, 0.0, 0.0)
	if tp == FLOAT_VEC4_VAR_TYPE:
		return Vector4(0.0, 0.0, 0.0, 0.0)
	return null

func get_type_int_from_name(tp_name:String) -> int:
	match tp_name:
		"string":
			return STRING_VAR_TYPE
		"bool":
			return BOOL_VAR_TYPE
		"int":
			return INT_VAR_TYPE
		"Vector2i":
			return INT_VEC2_VAR_TYPE
		"Vector3i":
			return INT_VEC3_VAR_TYPE
		"Vector4i":
			return INT_VEC4_VAR_TYPE
		
		"float":
			return FLOAT_VAR_TYPE
		"Vector2":
			return FLOAT_VEC2_VAR_TYPE
		"Vector3":
			return FLOAT_VEC3_VAR_TYPE
		"Vector4":
			return FLOAT_VEC4_VAR_TYPE
		
		"Func":
			return FUNCTION_IN_OUT
		"Func Call":
			return FUNC_CALL_NODE
		"Func return":
			return FUNC_RETURN_NODE
		"func":
			return FUNCTION_IN_OUT
	
	return NOT_DEFINED


func print_error_accessing_type(accessing:int, v_type:int):
	printerr("Tried to get varible as '", get_name_of_type(accessing), "' but variable is '", get_name_of_type(v_type), "'!")

func get_color(type:int) -> Color:
	if type == BOOL_VAR_TYPE:
		return COL_PINK
	elif type == INT_VAR_TYPE:
		return COL_LIGH_BLUE
	elif type == FLOAT_VAR_TYPE:
		return COL_BLUE
	elif type == STRING_VAR_TYPE:
		return COL_LIGHT_PINK
	elif type == REFERENCE_VAR_TYPE:
		return Color(225.0/255.0, 112.0/255.0, 85.0/255.0)
	elif type == FUNCTION_IN_OUT:
		return Color.AZURE
	elif type == FUNC_CALL_NODE:
		return Color(253.0/255.0, 203.0/255.0, 110.0/255.0)
	else:
		return Color(99.0/255.0, 110.0/255.0, 114.0/255.0)


func get_center_screen_coord() -> Vector2:
	var screen = get_viewport().get_visible_rect().size
	return screen / 2.0


func save_project(path:String="user://savegame.save"):
	var save_game = FileAccess.open(path, FileAccess.WRITE)
	var save_nodes = get_node("/root/Main/GraphEdit").get_children()
	
	for n in save_nodes:
		if n is ClassDeclarationNode:
			var class_data = n.get_data()
			var json_string = JSON.stringify(class_data)
			save_game.store_line(json_string)

func load_game(path:String="user://savegame.save") -> bool:
	if not FileAccess.file_exists(path):
		printerr("No file in path: ", path)
		return false
	
	var save_nodes = get_node("/root/Main/GraphEdit").get_children()
	for i in save_nodes:
		i.queue_free()
	
	var main : Main = get_node("/root/Main")
	
	var save_game = FileAccess.open(path, FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		
		var node_data : Dictionary = json.get_data()
		var n_class = main.create_class_declaration()
		n_class.set_data(node_data)
	return true
