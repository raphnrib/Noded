extends Space
class_name GlobalSpace

## Project Info
@export var proj_name	: String = "DevProj"
@export var proj_save_path : String = "user://user_save.tres"
@export var proj_folder : String = "C:/MyGodotProj/"

@export var scroll_offset : Vector2

signal on_info_updated


##*## ---- Action Sequences
@export var act_sequences : Array[ActionSequence]

## ------ State Machines
@export var state_machines : SMSpaceSection

func add_state_machine() -> StateMachine:
	if state_machines == null:
		state_machines = SMSpaceSection.new()
	return state_machines.add_new_item()


## ------ Classes Info
@export var next_class_index : int = 0
@export var classes : Array[ClassSpace]
var classes_names: Array[String]:
	get:
		return SS.get_list_of_names(classes)

## Return a configured ClassSpace
func add_class() -> ClassSpace:
	var n_class = ClassSpace.new()
	n_class.name = str('MyClass', next_class_index)
	n_class.code = next_class_index
	next_class_index += 1
	
	n_class.node_name = str('Class', n_class.code)
	n_class.space_owner = code
	
	classes.append(n_class)
	MSN.msn(str(classes.size(), " classes listed"))
	return n_class


## ------ Vars info
@export var next_var_index : int = 0
@export var vars : Array[VarSpace]
var vars_names: Array[String]:
	get:
		return SS.get_list_of_names(vars)

## Returns a VarSpace configured to GlobalSpace
func add_var() -> VarSpace:
	var general_name = str('GlobalVar', next_var_index)
	var n_var = VarSpace.new()
	
	n_var.name = general_name
	n_var.node_name = str(general_name, "Node")
	n_var.code = next_var_index
	next_var_index += 1
	
	n_var.owner_type = SS.Ownership.GLOBAL
	vars.append(n_var)
	return n_var
