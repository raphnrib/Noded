extends SpaceSection
class_name StateSpaceSection

func add_new_item() -> StateSpace:
	var s_space = StateSpace.new()
	initialize_append_space('State', next_index, s_space)
	return s_space
