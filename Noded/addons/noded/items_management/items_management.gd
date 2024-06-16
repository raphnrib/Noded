@tool
extends Control
class_name ItemsManagement

@onready var path_label = %PathLabel
@onready var itms_folder_button = %ItmsFolderButton
@onready var items_folders_pick = %ItemsFoldersPick
@onready var items_displays_root = %ItemsDisplaysRoot

var data : NodedData
var on_model_pick : Callable
var on_texture_pick : Callable

var itm_display_pref = preload("res://addons/noded/items_management/item_data_container.tscn")


func setup_data(n_data:NodedData):
	data = n_data
	path_label.text = data.items_folder
	
	refresh_items_display_from_folder()


## SAVE LOAD -----------------------------------------------------------------##

func save() -> Dictionary:
	
	return {}

func load_dictionary(dict:Dictionary, main:NodedMain) -> void:
	
	print(name, " Noded data updated!")
	pass


## PICK FOLDER
func _on_itms_folder_button_pressed():
	items_folders_pick.visible = true
	pass # Replace with function body.

func _on_file_dialog_dir_selected(dir):
	data.items_folder = dir
	path_label = data.items_folder


func create_item_display() -> ItemEditDisplay:
	var itm_displ := itm_display_pref.instantiate() as ItemEditDisplay
	items_displays_root.add_child(itm_displ)
	return itm_displ

func clear_item_displays_root():
	for child in items_displays_root.get_children():
		items_displays_root.remove_child(child)
		child.queue_free()

func refresh_items_display_from_folder():
	var i_folder : String = data.items_folder
	var items := DirAccess.get_files_at(i_folder)
	for i in items:
		var itm_path : String = i_folder + "/" + i
		var loaded_item = ResourceLoader.load(itm_path) as NodedItem
		var itm_displ : ItemEditDisplay = create_item_display()
		
		itm_displ.setup_from_path(loaded_item, self)

func _on_create_new_itm_btn_pressed():
	var item_id : StringName = data.get_new_item_name()
	var item_res_path : String = data.items_folder + '/' + item_id + '.tres'
	
	var n_item := NodedItem.new()
	n_item.id = item_id
	n_item.name = "New Item"
	ResourceSaver.save(n_item, item_res_path)
	
	var itm_displ := create_item_display()
	itm_displ.setup_from_path(n_item, self)

func _on_refresh_items_button_pressed():
	clear_item_displays_root()
	refresh_items_display_from_folder()
	pass # Replace with function body.
