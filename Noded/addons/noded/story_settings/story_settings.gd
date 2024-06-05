extends Control
class_name StorySettings

@onready var add_menu_btn = %AddMenu_BTN


func _ready():
	add_menu_btn.visible = false


func _on_graph_edit_connection_from_empty(to_node, to_port, release_position):
	pass # Replace with function body.


func _on_graph_edit_connection_to_empty(from_node, from_port, release_position):
	pass # Replace with function body.


func _close_add_menu():
	add_menu_btn.visible = false
	pass # Replace with function body.
