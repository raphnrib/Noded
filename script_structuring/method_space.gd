extends Space
class_name MethodSpace

enum NodeRelate { MAIN, LINK, EXECUTE }

## Method Info
@export var is_static : bool  = false

## Node Info
@export var has_start_node : bool
@export var execute_nodes : Array[Dictionary]
#@export var node_relation : NodeRelate

## Variables
@export var next_var_index : int = 0
@export var vars : Array[VarSpace]
var vars_names: Array[String]:
	get:
		return SS.get_list_of_names(vars)

## Returns a VarSpace configured to GlobalSpace
func add_var() -> VarSpace:
	var general_name = str('var_', next_var_index)
	var n_var = VarSpace.new()
	
	n_var.name = general_name
	n_var.node_name = str(general_name, "Container")
	n_var.code = next_var_index
	next_var_index += 1
	
	n_var.owner_code = code
	n_var.owner_type = SS.Ownership.CLASS
	vars.append(n_var)
	return n_var

signal on_info_updated()
