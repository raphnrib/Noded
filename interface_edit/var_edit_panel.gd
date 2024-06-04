extends PanelContainer
class_name VarEditPanel

var var_type : int = 0
var defaults_visible : bool = false

# Translate to internal index
const types = [
	'undef', 'bool', 'int', 'int_v2', 'int_v3', 'int_v4', 'float', 'float_v2', 'float_v3', 'float_v4', 'string'
	]
const v_types = [
	Info.NOT_DEFINED, Info.BOOL_VAR_TYPE, Info.INT_VAR_TYPE, Info.INT_VEC2_VAR_TYPE, Info.INT_VEC3_VAR_TYPE, Info.INT_VEC4_VAR_TYPE, Info.FLOAT_VAR_TYPE, Info.FLOAT_VEC2_VAR_TYPE, Info.FLOAT_VEC3_VAR_TYPE, Info.FLOAT_VEC4_VAR_TYPE, Info.STRING_VAR_TYPE
]


func _ready():
	var popup : PopupMenu = %VarTypeEdit.get_popup()
	for t in types:
		popup.add_item(t)
	
	popup.index_pressed.connect(var_type_selected)


func set_data(data:Dictionary):
	%VarNameEdit.text = data["name"]
	var_type = data['type']
	
	%ExportButton.button_pressed = data['use_export']
	%IsConstButton.button_pressed = data['is_const']
	%DefValButton.button_pressed = data['use_def_val']
	
	if data['use_export']:
		toggle_export(true)
	elif data['is_const']:
		toggle_const(true)
	elif data['use_def_val']:
		toggle_def_value(true)
	
	if data['value'] == null:
		set_var_type_by_id()
		return
	
	# Match value to data type
	match  var_type:
		Info.BOOL_VAR_TYPE:
			%BoolValueEdit.button_pressed = data['value']
			
		Info.INT_VAR_TYPE:
			%IntValueEdit.value = data['value']
		Info.FLOAT_VEC2_VAR_TYPE:
			%IntValueEdit.value = data['value'].x
			%IntYValueEdit.value = data['value'].y
		Info.INT_VEC3_VAR_TYPE:
			%IntValueEdit.value = data['value'].x
			%IntYValueEdit.value = data['value'].y
			%IntZValueEdit.value = data['value'].z
		Info.INT_VEC4_VAR_TYPE:
			%IntValueEdit.value = data['value'].x
			%IntYValueEdit.value = data['value'].y
			%IntZValueEdit.value = data['value'].z
			%IntWValueEdit.value = data['value'].w
		
		Info.FLOAT_VAR_TYPE:
			%FloatValueEdit.value = data['value'].x
		Info.FLOAT_VEC2_VAR_TYPE:
			%FloatValueEdit.value = data['value'].x
			%FloatYValueEdit.value = data['value'].y
		Info.FLOAT_VEC3_VAR_TYPE:
			%FloatValueEdit.value = data['value'].x
			%FloatYValueEdit.value = data['value'].y
			%FloatZValueEdit.value = data['value'].z
		Info.FLOAT_VEC4_VAR_TYPE:
			%FloatValueEdit.value = data['value'].x
			%FloatYValueEdit.value = data['value'].y
			%FloatZValueEdit.value = data['value'].z
			%FloatWValueEdit.value = data['value'].w
		
		Info.STRING_VAR_TYPE:
			%StrValueEdit.text = data["value"]
	
	set_var_type_by_id()

func set_edit_mode(is_arg:bool):
	%IsConstButton.visible = !is_arg
	%ExportButton.visible = !is_arg

func confirm():
	Interface.edited_data = get_data()
	Interface.confirm_edit()

func get_data() -> Dictionary:
	var data : Dictionary
	
	data["name"] = %VarNameEdit.text
	data["type"] = var_type
	
	# Match value to data type
	match  var_type:
		Info.BOOL_VAR_TYPE:
			data['value'] = %BoolValueEdit.button_pressed
			
		Info.INT_VAR_TYPE:
			data['value'] = %IntValueEdit.value
		Info.FLOAT_VEC2_VAR_TYPE:
			var n_vec = Vector2i(
				%IntValueEdit.value,
				%IntYValueEdit.value
			)
			data['value'] = n_vec
		Info.INT_VEC3_VAR_TYPE:
			var n_vec = Vector3i(
				%IntValueEdit.value,
				%IntYValueEdit.value,
				%IntZValueEdit.value
			)
			data['value'] = n_vec
		Info.INT_VEC4_VAR_TYPE:
			var n_vec = Vector4i(
				%IntValueEdit.value,
				%IntYValueEdit.value,
				%IntZValueEdit.value,
				%IntWValueEdit.value
			)
			data['value'] = n_vec
		
		Info.FLOAT_VAR_TYPE:
			data['value'] = %FloatValueEdit.value
		Info.FLOAT_VEC2_VAR_TYPE:
			var n_vec = Vector2(
				%FloatValueEdit.value,
				%FloatYValueEdit.value
			)
			data['value'] = n_vec
		Info.FLOAT_VEC3_VAR_TYPE:
			var n_vec = Vector3(
				%FloatValueEdit.value,
				%FloatYValueEdit.value,
				%FloatZValueEdit.value
			)
			data['value'] = n_vec
		Info.FLOAT_VEC4_VAR_TYPE:
			var n_vec = Vector4(
				%FloatValueEdit.value,
				%FloatYValueEdit.value,
				%FloatZValueEdit.value,
				%FloatWValueEdit.value
			)
			data['value'] = n_vec
		
		Info.STRING_VAR_TYPE:
			data["value"] = %StrValueEdit.text
		
		_:
			data['value'] = null
	
	data['use_export'] = %ExportButton.button_pressed
	data['is_const'] = %IsConstButton.button_pressed
	data['use_def_val'] = %DefValButton.button_pressed
	
	return data

func cancel():
	Interface.cancel_editing()


func toggle_const(toggle:bool):
	if toggle:
		%DefValButton.button_pressed = true
		%ExportButton.button_pressed = false
		if var_type == 1:
			var_type = 0
		
		defaults_visible = true
		set_var_type_by_id()

func toggle_def_value(toggle:bool):
	if !toggle:
		%ExportButton.button_pressed = false
		%IsConstButton.button_pressed = false
		
		defaults_visible = false
	else:
		defaults_visible = true
		if var_type == 1:
			var_type = 0
	set_var_type_by_id()

func toggle_export(toggle:bool):
	if toggle:
		%DefValButton.button_pressed = true
		%IsConstButton.button_pressed = false
		
		defaults_visible = true
		set_var_type_by_id()
		
		if var_type == 1:
			var_type = 0


func var_type_selected(index:int):
	var_type = v_types[index]
	set_var_type_by_id()

func set_var_type_by_id():
	var id = var_type
	%VarTypeEdit.text = Info.get_name_of_type(id)
	
	if !defaults_visible:
		%StrValueEdit.visible = false
		%BoolValueEdit.visible = false
		%"Numbers Separator".visible = false
		%FloatVecContainer.visible = false
		%IntVecContainer.visible = false
		return
	
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
	
	# INTERFACE CONTAINERS AND SEPARATORS
	%"Numbers Separator".visible = %FloatValueEdit.visible or %IntValueEdit.visible
	%IntVecContainer.visible = %IntValueEdit.visible
	%FloatVecContainer.visible = %FloatValueEdit.visible
	
	# INTERFACE COLORS
	var_type = id
	self_modulate = Info.get_color(id)
	%VarTypeEdit.text = Info.get_name_of_type(id)


















