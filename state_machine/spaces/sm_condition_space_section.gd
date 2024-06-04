## Conditions that compare the current params state with the original and determines if a condition is met

extends SpaceSection
class_name SMConditionSpaceSection

## add_new_item method blueprint
func add_new_item() -> SMConditionSpace:
	var n_space = SMConditionSpace.new()
	initialize_append_space('Condition', next_index, n_space)
	return n_space
