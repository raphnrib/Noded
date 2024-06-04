extends PanelContainer
class_name SpaceSectionEditor

var changed : bool = false
var editing_space : SpaceSection

signal editing_finished(changed)


func setup(section:SpaceSection):
	editing_space = section
	if section.items_array.is_empty():
		MSN.msn("The section has no items!", MSN.Mode.WARNING)
		queue_free()
	else:
		for i in section.items_array:
			var edit = create_local_item_display()
			edit.setup(i, section, self)

func create_local_item_display() -> EditingItem:
	var i_edit = Interface.editing_item_pref.instantiate() as EditingItem
	%ItemsRoot.add_child(i_edit)
	return i_edit

func _on_close_windoe():
	editing_finished.emit(changed)
	queue_free()
