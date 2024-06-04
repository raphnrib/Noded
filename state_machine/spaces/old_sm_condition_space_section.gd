#extends SpaceSection
#class_name SMConditionSpaceSection
#
### add_new_item method blueprint
#func add_new_item() -> Space:
	#printerr("Should call add_new float, int, bool or trigger_condition")
	#return null
#
#
#func add_float_condition() -> SMFloatCondition:
	#var n_space = SMFloatCondition.new()
	#initialize_append_space('Float', next_index, n_space)
	#return n_space
#
#func add_bool_condition() -> SMBoolCondition:
	#var n_space = SMBoolCondition.new()
	#initialize_append_space('Float', next_index, n_space)
	#return n_space
#
#func add_int_condition() -> SMIntCondition:
	#var n_space = SMIntCondition.new()
	#initialize_append_space('Float', next_index, n_space)
	#return n_space
#
#func add_trigger_condition() -> SMTriggerCondition:
	#var n_space = SMTriggerCondition.new()
	#initialize_append_space('Float', next_index, n_space)
	#return n_space
