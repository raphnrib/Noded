extends ParamContainer
class_name FloatParamContainer


func _on_value_value_changed(value:float):
	var f_param = param as SMFloatParamSpace
	f_param.value = value
