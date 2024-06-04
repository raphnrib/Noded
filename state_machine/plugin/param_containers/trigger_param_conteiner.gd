extends ParamContainer
class_name TriggParamContainer


func _on_value_toggled(toggled_on):
	var b_param = param as SMTriggerParam
	b_param.value = toggled_on
