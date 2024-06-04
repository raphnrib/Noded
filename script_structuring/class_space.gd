extends Space
class_name ClassSpace

#class_name Space
#@export var name : String = "clean_space"
#@export var node_name : String = "Node"
#@export var code : int

## Class Info
@export var inheritance : String = "Node"
@export var space_owner : int = 0
@export var locked : bool = false

func check_initialize_class():
	if enum_section == null:
		enum_section = SpaceSection.new()
		enum_section.type = SpaceSection.tp.ENUMS


## ------ Enumerations Info
@export var enum_section : SpaceSection
func add_enum() -> EnumSpace:
	var n_enum = enum_section.add_new_item() as EnumSpace
	return n_enum


## ------ Variables Info
@export var next_var_index : int = 0
@export var vars : Array[VarSpace]

var vars_names: Array[String]:
	get: return SS.get_list_of_names(vars)

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


## ------ Methods Info
@export var next_method_index : int = 0
@export var methods : Array[MethodSpace]

var methods_names: Array[String]:
	get: return SS.get_list_of_names(methods)

func add_method() -> MethodSpace:
	var general_name = str('method_', next_method_index)
	var n_method = MethodSpace.new()
	
	n_method.name = general_name
	n_method.node_name = str(general_name, "MethodLink")
	n_method.code = next_method_index
	next_method_index += 1
	
	n_method.owner_code = code
	n_method.owner_type = SS.Ownership.CLASS
	methods.append(n_method)
	return n_method


signal on_info_updated(info:ClassSpace)


