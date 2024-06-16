@tool
extends VBoxContainer
class_name CampainContainer

@onready var marks_root = %MarksRoot

var id : String
var data : CheckListsData

var camp_item_pref = preload("res://addons/noded/checklists/campain_item_container.tscn")


func setup_from(campain_id:String, data:CheckListsData):
	self.data = data
	
	var campain_items : Dictionary = data.campains[campain_id]
	for key in campain_items.keys():
		var n_item := create_campain_button()
		
	
	pass

func create_campain_button() -> NodedCampainItem:
	var n_item := camp_item_pref.instantiate() as NodedCampainItem
	marks_root.add_child(n_item)
	return n_item


func _on_add_line_edit_text_submitted(new_text):
	data.campains[id][new_text] = false
	var n_item := create_campain_button()
	
