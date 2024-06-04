## The section holded by the GlobalSpace

extends SpaceSection
class_name SMSpaceSection

func add_new_item() -> StateMachine:
	var n_space = StateMachine.new()
	initialize_append_space('StateMachine', next_index, n_space)
	section_info_changed.emit()
	return n_space
