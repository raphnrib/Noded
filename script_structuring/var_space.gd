extends Space
class_name VarSpace

## Var Info
@export var v_type : int = 1
@export var use_default : bool = false
@export var use_export	: bool = false
@export var is_const	: bool = false
@export var str_value	: String = "" ## Value as string needed to save Resource

var v_value

signal on_info_updated()
