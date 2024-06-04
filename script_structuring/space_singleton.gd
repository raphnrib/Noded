## Manages the saved file
extends Node

## In a Singleton for general accessibility
@export var global : GlobalSpace

var proj_name : String:
	get:
		return global.proj_name if global != null else "..none.."

const default_save_path : String = "user://user_save.tres"

##---------------------- Current Space ---------------------------##

func check_global_space():
	if global == null:
		if try_load_default_project():
			return 'LOADED'
		else:
			global = GlobalSpace.new()
			global.name = 'Global Space'
			save_project()

## Creates a class in the Global Space
func create_class() -> ClassSpace:
	return global.add_class()

## Create a State Machine in Global Space
func create_state_machine() -> StateMachine:
	return global.add_state_machine()


##---------------------- Save/Load Projects -----------------------##
#region Save/Load
func try_load_default_project() -> bool:
	if FileAccess.file_exists(default_save_path):
		global = ResourceLoader.load(default_save_path) as GlobalSpace
		return true
	else:
		return false

func try_load_from_path(path:String) -> bool:
	if FileAccess.file_exists(path):
		global = ResourceLoader.load(path) as GlobalSpace
		return true
	else:
		return false

func save_project():
	ResourceSaver.save(global, global.proj_save_path)
#endregion

##---------------------- General Functionality --------------------##
#region General
enum Ownership { GLOBAL, CLASS, METHOD }

func check_unique_class_name(new_name:String) -> String:
	return get_unique_name_from_strings(new_name, global.classes_names)

func check_unique_var_name(new_name:String) -> String:
	return get_unique_name_from_strings(new_name, global.vars_names)


## space_array is type 'Array[Space]'
static func get_list_of_names(space_array) -> Array[String]:
	var names : Array[String]
	for s in space_array:
		names.append(s.name)
	
	return names

static func get_unique_name_from_strings(new_name:String, string_arrray:Array[String]) -> String:
	return Info.get_unique_name(new_name, string_arrray)

static func get_unique_name(new_name:String, space_array:Array[Space]) -> String:
	var names = get_list_of_names(space_array)
	return Info.get_unique_name(new_name, names)
#endregion
