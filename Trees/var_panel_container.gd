## Should be DEPRECATED
## New class VarContainer

extends PanelContainer
class_name VarPanelContainer

@onready var var_name_edit = $MarginContainer/VBoxContainer/Header/VarNameEdit
@onready var var_type_edit : MenuButton = $MarginContainer/VBoxContainer/Header/VarTypeEdit

var controller	: ClassDeclarationNode
var var_type	: int
var func_start_node	: FuncStart

var fun_start_tree = preload("res://Trees/func_implement_start.tscn")

# Translate to internal index
const types = [
		'bool', 'int', 'int_v2', 'int_v3', 'int_v4', 'float', 'float_v2', 'float_v3', 'float_v4', 'string', 'class_ref', 'function'
	]
const v_types = [
	Info.BOOL_VAR_TYPE, Info.INT_VAR_TYPE, Info.INT_VEC2_VAR_TYPE, Info.INT_VEC3_VAR_TYPE, Info.INT_VEC4_VAR_TYPE, Info.FLOAT_VAR_TYPE, Info.FLOAT_VEC2_VAR_TYPE, Info.FLOAT_VEC3_VAR_TYPE, Info.FLOAT_VEC4_VAR_TYPE, Info.STRING_VAR_TYPE, Info.REFERENCE_VAR_TYPE, Info.FUNCTION_IN_OUT
]


## Initialization
func _ready():
	var popup : PopupMenu = var_type_edit.get_popup()
	for t in types:
		popup.add_item(t)
	
	popup.index_pressed.connect(var_type_selected)
	var_type_selected(9)
	
	var values = Info.VarType.keys()
	for v in values:
		%FuncReturnVarType.add_item(v)


## When var type changed
func var_type_selected(index:int):
	var id : int = v_types[index]
	set_var_type_by_id(id)

func set_var_type_by_id(id:int):
	# BOOL
	%BoolValueEdit.visible = id == Info.BOOL_VAR_TYPE
	
	# INTEGERS
	%IntValueEdit.visible = id == Info.INT_VAR_TYPE or id == Info.INT_VEC2_VAR_TYPE or id == Info.INT_VEC3_VAR_TYPE or id == Info.INT_VEC4_VAR_TYPE
	%IntYValueEdit.visible = id == Info.INT_VEC2_VAR_TYPE or id == Info.INT_VEC3_VAR_TYPE or id == Info.INT_VEC4_VAR_TYPE
	%IntZValueEdit.visible = id == Info.INT_VEC3_VAR_TYPE or id == Info.INT_VEC4_VAR_TYPE
	%IntWValueEdit.visible = id == Info.INT_VEC4_VAR_TYPE
	
	# FLOATS
	%FloatValueEdit.visible = id == Info.FLOAT_VAR_TYPE or id == Info.FLOAT_VEC2_VAR_TYPE or id == Info.FLOAT_VEC3_VAR_TYPE or id == Info.FLOAT_VEC4_VAR_TYPE
	%FloatYValueEdit.visible = id == Info.FLOAT_VEC2_VAR_TYPE or id == Info.FLOAT_VEC3_VAR_TYPE or id == Info.FLOAT_VEC4_VAR_TYPE
	%FloatZValueEdit.visible = id == Info.FLOAT_VEC3_VAR_TYPE or id == Info.FLOAT_VEC4_VAR_TYPE
	%FloatWValueEdit.visible = id == Info.FLOAT_VEC4_VAR_TYPE
	
	# STRING
	%StrValueEdit.visible = id == Info.STRING_VAR_TYPE or id == Info.REFERENCE_VAR_TYPE
	
	# FUNCTION
	if id == Info.FUNCTION_IN_OUT or id == Info.FUNC_CALL_NODE:
		%FunctionSetupSpace.visible = true
		add_to_group("functions")
	else:
		%FunctionSetupSpace.visible = false
		remove_from_group("functions")
	
	var_type = id
	self_modulate = Info.get_color(id)
	%VarTypeEdit.text = Info.get_name_of_type(id)

func get_var_name() -> String:
	return var_name_edit.text

func force_set_var_name(new_name:String):
	var_name_edit.text = new_name


func ensure_function_start_node():
	if func_start_node == null:
		var graph = get_node('/root/Main/GraphEdit') as GraphEdit
		func_start_node = fun_start_tree.instantiate() as FuncStart
		graph.add_child(func_start_node)
		
		var center = get_viewport().get_visible_rect().size * 0.5
		func_start_node.position_offset = center + graph.scroll_offset
		
		# TODO Setup buttons with the correct data



func get_data() -> Dictionary:
	var data : Dictionary
	
	data["label"] = var_name_edit.text
	data["type"] = var_type
	
	data["b_val"] = %BoolValueEdit.button_pressed
	
	data["i_val"] = %IntValueEdit.value
	data["i2_val"] = %IntYValueEdit.value
	data["i3_val"] = %IntZValueEdit.value
	data["i4_val"] = %IntWValueEdit.value
	
	data["fl_val"] = %FloatValueEdit.value
	data["fl2_val"] = %FloatYValueEdit.value
	data["fl3_val"] = %FloatZValueEdit.value
	data["fl4_val"] = %FloatWValueEdit.value
	
	data["str_val"] = %StrValueEdit.text
	data["func_ret"] = %FuncReturnVarType.selected
	
	if func_start_node:
		var func_args = func_start_node.get_arguments_array()
		if !func_args.is_empty():
			data["func_args"] = func_args
	return data

func set_data(data:Dictionary):
	var_name_edit.text = data["label"]
	
	%BoolValueEdit.button_pressed = data["b_val"]
	
	%IntValueEdit.value = data["i_val"]
	%IntYValueEdit.value = data["i2_val"]
	%IntZValueEdit.value = data["i3_val"]
	%IntWValueEdit.value = data["i4_val"]
	
	%FloatValueEdit.value = data["fl_val"]
	%FloatYValueEdit.value = data["fl2_val"]
	%FloatZValueEdit.value = data["fl3_val"]
	%FloatWValueEdit.value = data["fl4_val"]
	
	%StrValueEdit.text = data["str_val"]
	
	for n in %ArgsRoot.get_children():
		if n is Button:
			continue
		else:
			n.queue_free()
	
	if data.has('func_ret'):
		%FuncReturnVarType.selected = data["func_ret"]
	if data.has('func_args'):
		ensure_function_start_node()
		func_start_node.setup_from_data(data["func_args"])
	
	set_var_type_by_id(data["type"])

func _on_var_name_edited(new_text):
	if controller:
		controller.check_unique_name(self)


func _on_start_implementation_pressed():
	%ConfirmStartImplement.visible = true
	%ConfirmStartImplement.position = get_global_mouse_position()

func confirmation_start_implementatio():
	ensure_function_start_node()
	
	# Ensure option 'VAR TYPE' not visible so can't delete the created nodes
	%VarTypeEdit.visible = false
	%StartImplementationBtn.visible = false
	%FuncNodeOptions.visible = true
