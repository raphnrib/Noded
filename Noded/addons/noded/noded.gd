@tool
extends Control
class_name NodedMain

@export var header_h_box : HBoxContainer

@onready var story_settings : StorySettings = $"VBoxContainer/TabContainer/Story Settings"
@onready var process : ProjectProcess = $VBoxContainer/TabContainer/Process

var data : NodedData
var picker : EditorResourcePicker

signal on_data_changed(n_res:NodedData)


func setup_ui():
	if !Engine.is_editor_hint():
		return
	picker = EditorResourcePicker.new()
	picker.base_type = 'NodedData'
	picker.custom_minimum_size = Vector2i(128, 0)
	picker.resource_changed.connect(resource_data_changed)
	
	header_h_box.add_child(picker)
	header_h_box.move_child(picker, 1)

func resource_data_changed(n_data):
	if data == null or n_data != data:
		data = n_data
		
		story_settings.setup_from_data.call_deferred(data)
		process.setup_from.call_deferred(data)


func _on_save_btn_pressed():
	var path := data.resource_path if !data.resource_path.is_empty() else "res://noded_project.tres"
	ResourceSaver.save(data, path)
