extends PanelContainer
class_name EditingItem

var space_item : Space
var parent : SpaceSection
var controller : SpaceSectionEditor


func setup(item:Space, section:SpaceSection, control:SpaceSectionEditor):
	space_item = item
	parent = section
	controller = control
	
	%PropNameLabel.text = space_item.name
	
	var no_links = space_item.links.is_empty()
	%DelButton.visible = no_links
	%PropLinksPanel.self_modulate = Info.COL_GREEN if no_links else Info.COL_YELLOW
	
	if no_links:
		%PropLinksLabel.text = "Not linked!"
	else:
		var txt = ''
		for l in item.links:
			txt += str(" -", l.name, " ")
		%PropLinksLabel.text = txt

func _on_del_button_pressed():
	parent.items_array.erase(space_item)
	space_item.removed_at_source = true
	controller.changed = true
	queue_free()
