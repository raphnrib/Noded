extends PanelContainer
class_name EnumContainer

@export var enum_space : EnumSpace
@export var parent : SpaceSection


func setup_from_enum_space(e_space:EnumSpace, e_section:SpaceSection):
	enum_space = e_space
	parent = e_section
	
	name = e_space.node_name
	%EnumNameEdit.text = e_space.name
	
	if !enum_space.items.is_empty():
		for i in enum_space.items:
			var i_display = create_item_interface()
			setup_item_display(i_display, i)

func _on_delete_enum_pressed():
	parent.items_array.erase(enum_space)
	queue_free()


func add_item_to_enum():
	%AddItemLineEdit.visible = true

func remove_item(item_str:String):
	enum_space.items.erase(item_str)

func confirm_add_item(new_item):
	new_item = SS.get_unique_name_from_strings(new_item, enum_space.items)
	enum_space.items.append(new_item)
	
	var i_display = create_item_interface() as EnumItemDisplay
	setup_item_display(i_display, new_item)
	i_display.enum_container = self
	
	%AddItemLineEdit.visible = false
	%AddItemLineEdit.text = ''

func set_new_enum_name(new_name:String):
	enum_space.name = new_name
	%EnumNameEdit.release_focus()


func setup_item_display(display:EnumItemDisplay, item:String):
	display.text = item
	display.enum_container = self

func create_item_interface() -> EnumItemDisplay:
	var n_display = Interface.enum_item_display_pref.instantiate() as EnumItemDisplay
	%ItemsRoot.add_child(n_display)
	%AddItemBtn.move_to_front()
	return n_display as EnumItemDisplay
