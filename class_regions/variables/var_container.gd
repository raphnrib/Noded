extends PanelContainer
class_name VarContainer

@export var var_space : VarSpace

var v_name : String:
	get: return var_space.name
	set(val): var_space.name = val
var v_type : int:
	get: return var_space.v_type
	set(val): var_space.v_type = val
var use_default : bool:
	get: return var_space.use_default
	set(val): var_space.use_default = val
var use_export : bool:
	get: return var_space.use_export
	set(val): var_space.use_export = val
var is_const : bool:
	get: return var_space.is_const
	set(val): var_space.is_const = val

## If is type ClassSpace should call edit var full window
## If is type MethodSpace should call limited edit window
var parent_space
var is_arg : bool


func setup_from_var_space(v_space:VarSpace, parent):
	var_space = v_space
	parent_space = parent
	is_arg = parent_space is MethodSpace
	
	name = var_space.node_name
	%NameLabel.text = var_space.name
	set_description()

func set_description():
	if is_arg:
		var def_val = '' if var_space.v_value == null else str(" = '", var_space.v_value, "'") if v_type == 0 else str(" = ", var_space.v_value)
		var def_tp = ' : ' + %TypeLabel.text if %TypeLabel.text != "none" else ''
		%DescriptionLabel.text = str(%NameLabel.text , def_tp, def_val)
	else:
		var prefix = '@export var ' if use_export else 'const ' if is_const else 'var '
		var def_tp = ' : ' + %TypeLabel.text if %TypeLabel.text != "none" else ''
		var def_val = '' if var_space.v_value == null else str(" = '", var_space.v_value, "'") if v_type == 0 else str(" = ", var_space.v_value)
	
		%DescriptionLabel.text = str(prefix, %NameLabel.text , def_tp, def_val)
	modulate = Info.get_color(v_type)

## Sends the current var info to Interface to be modified
func request_edit():
	var data : Dictionary
	
	data['position'] = get_screen_position() + Vector2(size.x, 0.0)
	data['name'] = %NameLabel.text
	data['value'] = var_space.v_value
	data['type'] = v_type
	data['parent_space'] = parent_space
	
	data['use_def_val'] = use_default
	data['use_export'] = use_export
	data['is_const'] = is_const
	
	Interface.on_confirmed.connect(update_data_from_data)
	Interface.on_canceled.connect(clean_signals)
	Interface.call_var_edit_window(data, is_arg)

## Get modified data and refresh values
func update_data_from_data():
	var data = Interface.edited_data
	
	# Data name
	var n_v_name = SS.get_unique_name_from_strings(data['name'], parent_space.vars_names)
	v_name = n_v_name
	
	# Data values
	var_space.v_value = data['value']
	var_space.str_value = str(var_space.v_value)
	v_type = data['type']
	use_default = data['use_def_val']
	use_export = data['use_export']
	is_const = data['is_const']
	
	# Interface info
	%NameLabel.text = n_v_name
	%TypeLabel.text = Info.get_name_of_type(v_type)
	%DefValLabel.text = var_space.str_value
	set_description()
	
	clean_signals()

func clean_signals():
	Interface.on_confirmed.disconnect(update_data_from_data)
	Interface.on_canceled.disconnect(clean_signals)
