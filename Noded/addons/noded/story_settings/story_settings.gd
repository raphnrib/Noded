@tool
extends Control
class_name StorySettings

@onready var add_menu_btn = %AddMenu_BTN
@onready var graph_edit : GraphEdit = $PanelContainer/MarginContainer/GraphEdit
@onready var discart = $discart

var add_node_btn : Button
var main : NodedMain
var data : StorySettingsData

var entry_node = preload("res://addons/noded/story_settings/settings_entry_node.tscn")


## CALLBACKS -----------------------------------------------------------------##
func _ready():
	add_menu_btn.visible = false
	
	var header := graph_edit.get_menu_hbox()
	add_node_btn= Button.new()
	add_node_btn.text = "Add"
	add_node_btn.pressed.connect(add_new_entry)
	add_node_btn.disabled = true
	
	header.add_child(add_node_btn)

func setup_from_data(n_data:NodedData):
	data = n_data.story_settings_data
	add_node_btn.disabled = data == null
	
	if !data.characters.is_empty():
		for c in data.characters:
			var n_node := create_entry_node()
			n_node.setup_from_data(c, false)
	
	if !data.cultures.is_empty():
		for c in data.characters:
			var n_node := create_entry_node()
			n_node.setup_from_data(c, false)


## SAVE LOAD -----------------------------------------------------------------##

func save() -> Dictionary:
	
	return {}

func load_dictionary(dict:Dictionary, main:NodedMain) -> void:
	
	print(name, " Noded data updated!")
	pass


## FUNCTIONALITY -------------------------------------------------------------##

func clear_graph_node():
	for c in graph_edit.get_children():
		discart.add_child(c)
	
	clear_discart.call_deferred()

func clear_discart():
	for c in discart.get_children():
		c.queue_free()


func add_new_entry():
	add_menu_btn.visible = true

func _close_add_menu():
	add_menu_btn.visible = false
	pass # Replace with function body.


func create_entry_node() -> NodedEntryNode:
	var n_node = entry_node.instantiate() as NodedEntryNode
	graph_edit.add_child(n_node)
	n_node.position_offset = get_local_mouse_position() + graph_edit.scroll_offset
	return n_node

func _on_add_char_pressed():
	var n_char := data.new_character_entry()
	var n_node := create_entry_node()
	n_node.setup_from_data(n_char, true)
	_close_add_menu()


func _on_add_culture_pressed():
	var n_cul := data.new_culture_entry()
	var n_node := create_entry_node()
	n_node.setup_from_data(n_cul, true)
	_close_add_menu()


func _on_graph_edit_delete_nodes_request(nodes):
	for node in nodes:
		var entry := (node as NodedEntryNode).data
		
		match entry.type:
			NodedEntryData.ENTRY_TYPES.char:
				data.characters.erase(entry)
			NodedEntryData.ENTRY_TYPES.culture:
				data.cultures.erase(entry)
		
		discart.add_child(node)
	
	clear_discart.call_deferred()
