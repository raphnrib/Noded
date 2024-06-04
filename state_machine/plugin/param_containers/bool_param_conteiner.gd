extends ParamContainer
class_name BoolParamContainer


func _on_value_toggled(toggled_on):
	var b_param = param as SMBoolParamSpace
	b_param.value = toggled_on
