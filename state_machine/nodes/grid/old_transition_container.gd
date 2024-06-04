#extends GraphNode
##class_name SMConditionNode
#
#var parent : SMStateNode
#var condition : SMCondition
#var linked_parameter : SMParamSpace
#
#var port : int
#
#@onready var param_label = %ParamLabel
#
#
#func setup_from_parameter_space(p_space:SMParamSpace, transit:SMCondition, state:SMStateNode):
	#condition = transit
	#parent = state
	#
	#if p_space == null:
		#linked_parameter = condition.linked_to
	#else:
		#linked_parameter = p_space
		#linked_parameter.links.append(condition)
		#condition.linked_to = linked_parameter
	#
	#refresh_param_name()
	### Listen to changes in the parameter
	#linked_parameter.space_info_changed.connect(refresh_param_name)
	#
	#if linked_parameter is SMFloatParamSpace:
		#%BooleanParamContainer.visible = false
		#%NumParamComparing.visible = true
		#%FloatSpinBox.visible = true
		#%IntSpinBox.visible = false
	#elif linked_parameter is SMIntParamSpace:
		#%BooleanParamContainer.visible = false
		#%NumParamComparing.visible = true
		#%FloatSpinBox.visible = false
		#%IntSpinBox.visible = true
	#elif linked_parameter is SMBoolParamSpace:
		#%BooleanParamContainer.visible = true
		#%NumParamComparing.visible = false
	#else:
		#%BooleanParamContainer.visible = false
		#%NumParamComparing.visible = false
#
#func refresh_param_name():
	#if linked_parameter != null:
		#%ParamLabel.text = linked_parameter.name
#
#
#func _on_del_button_pressed():
	### Remove links
	#linked_parameter.links.erase(condition)
	### TODO Remove connections
	#
	### Remove Node
	#queue_free()
