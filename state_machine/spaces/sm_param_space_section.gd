extends SpaceSection
class_name SMParamsSpaceSection

func add_new_item() -> Space:
	printerr("Should call: add 'float, int, bool or trigger'")
	return null

func add_float_param() -> SMFloatParamSpace:
	var n_enum = SMFloatParamSpace.new()
	initialize_append_space('Float', next_index, n_enum)
	super.emit_signal('section_info_changed')
	return n_enum

func add_int_param() -> SMIntParamSpace:
	var n_enum = SMIntParamSpace.new()
	initialize_append_space('Int', next_index, n_enum)
	super.emit_signal('section_info_changed')
	return n_enum

func add_bool_param() -> SMBoolParamSpace:
	var n_enum = SMBoolParamSpace.new()
	initialize_append_space('Bool', next_index, n_enum)
	super.emit_signal('section_info_changed')
	return n_enum

func add_trigger_param() -> SMTriggerParamSpace:
	var n_enum = SMTriggerParamSpace.new()
	initialize_append_space('Trgg', next_index, n_enum)
	super.emit_signal('section_info_changed')
	return n_enum

func add_timer_param() -> SMTimerParamSpace:
	var n_enum = SMTimerParamSpace.new()
	initialize_append_space('Timer', next_index, n_enum)
	super.emit_signal('section_info_changed')
	return n_enum
