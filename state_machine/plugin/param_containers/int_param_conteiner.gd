extends ParamContainer
class_name IntParamContainer


func _on_value_value_changed(value):
	var i_param = param as SMIntParamSpace
	i_param.value = roundi(value)
