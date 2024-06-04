extends ClassRegion
class_name VarsRegion

var parent_space

var region_label : String:
	set(val): %Label.text = val


## Creates the node in the tree
func create_var_container() -> VarContainer:
	var n_var_container = Interface.vars_container_pref.instantiate() as VarContainer
	%ItemsRoot.add_child(n_var_container)
	%AddNewBtn.move_to_front()
	return n_var_container

## Links the Container Node with the variant it manipulates
func _on_add_new():
	var n_var_container = create_var_container()
	n_var_container.setup_from_var_space(parent_space.add_var(), parent_space)
