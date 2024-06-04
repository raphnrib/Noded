extends ClassRegion
class_name EnumsRegion

var parent_space
var enum_section : SpaceSection


## Creates the node in the tree
func create_enum_container() -> EnumContainer:
	var n_enum_container = Interface.enum_container_pref.instantiate() as EnumContainer
	%ItemsRoot.add_child(n_enum_container)
	%AddNewBtn.move_to_front()
	return n_enum_container

## Links the Container Node with the variant it manipulates
func _on_add_new():
	# Create interface
	var n_enum_container = create_enum_container() as EnumContainer
	
	# Create actual items and link
	var enum_space = enum_section.add_new_item() as EnumSpace
	n_enum_container.setup_from_enum_space(enum_space, enum_section)
