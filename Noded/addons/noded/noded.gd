@tool
extends Control
class_name NodedMain

@export var header_h_box : HBoxContainer
@export var skip_old : bool = false

@onready var story_settings : StorySettings = $"VBoxContainer/TabContainer/Story Settings"
@onready var process : ProjectProcess = $VBoxContainer/TabContainer/Process
@onready var game : GameInfo = $VBoxContainer/TabContainer/Game
@onready var items = $VBoxContainer/TabContainer/Items
@onready var promo = $VBoxContainer/TabContainer/LaunchPromo
@onready var noded_settings = %NodedSettings

## SETTINGS ------ ||
@onready var default_3d_model_default_steps_edit = %Default3DModelDefaultStepsEdit

var data : NodedData
var picker : EditorResourcePicker

var to_save : Dictionary:
	get: return { &'Story':story_settings, &'Process': process, &'Game':game, &'Items':items, &'Promos':promo, &'Settings':noded_settings }

const proj_data_path := "res://project.noded" ## "res://noded_project.tres"
const old_proj_path := "res://noded_project.tres"

signal on_data_changed(n_res:NodedData)


func setup_ui():
	$VBoxContainer/TabContainer.current_tab = 0
	_on_reload_resource_pressed()

func resource_data_changed(from_data:NodedData=data):
	story_settings.setup_from_data.call_deferred(from_data)
	process.setup_from.call_deferred(from_data)
	game.setup_from_data(from_data)
	items.setup_data(from_data)
	promo.setup_from(from_data)
	
	## SETTINGS ------||
	default_3d_model_default_steps_edit.text = from_data.model_3d_steps

func _on_default_3d_model_default_steps_edit_text_submitted(new_text):
	data.model_3d_steps = new_text
	data.model_3d_steps = new_text
	pass # Replace with function body.


## SAVE LOAD ALL -------------------------------------------------------------##

func _on_save_btn_pressed():
	var save_game = FileAccess.open(proj_data_path, FileAccess.WRITE)
	var save_nodes := to_save
	
	var node_save_data := {}
	for key in save_nodes.keys():
		var node = save_nodes[key]
		
		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue
		
		# Save each node info under each specific key
		node_save_data[key] = node.call("save")
	
	# Save all info in one line
	var json_string = JSON.stringify(node_save_data)
	save_game.store_line(json_string)

func _on_reload_resource_pressed(debug:=false):
	## Clean old saves
	if FileAccess.file_exists(old_proj_path) and !skip_old:
		print("Noded found old save file!")
		var old_res := ResourceLoader.load(old_proj_path)
		var old := old_res as NodedData
		
		if old != null:
			print("Loading old data...")
			resource_data_changed(old)
			#DirAccess.remove_absolute(old_proj_path)
			return
		else:
			printerr("Error loading old data!")
	
	
	## Start loading NEW data ------------------------------------------------||
	if not FileAccess.file_exists(proj_data_path):
		print("Noded Project still not created @ ", proj_data_path)
		return
	
	
	var saved_data = FileAccess.open(proj_data_path, FileAccess.READ)
	
	while saved_data.get_position() < saved_data.get_length():
		var json_string = saved_data.get_line()
		
		# JSON check
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		
		# Get the data from the JSON object
		var node_data : Dictionary = json.get_data()
		refresh_all_from_noded_data(node_data)
		break

## Refresh all subscreens with data
func refresh_all_from_noded_data(dict:Dictionary):
	# Set all info parsing particular data as Dictionary and 'self' as reference
	var load_nodes : Dictionary = to_save # The ones that had their data saved before
	
	for key in load_nodes.keys():
		if not dict.has(key): # Skip if data is not saved
			print("Saved data don't have data for: ", key)
			continue
		
		var data_dict : Dictionary = dict[key]
		var node = load_nodes[key]
		
		if !node.has_method("load_dictionary"):
			print("persistent node '%s' is missing a load_dictionary() function, skipped" % node.name)
			continue
		
		node.load_dictionary(data_dict, self)
	pass
