@tool
extends Resource
class_name NodedData

@export var story_settings_data : StorySettingsData = StorySettingsData.new()
@export var proj_processes_data : ProjProcessData = ProjProcessData.new()
@export var game_meta_data : NodedGameData = NodedGameData.new()
@export var promo_data : PromoData = PromoData.new()
@export var checklist_data : CheckListsData

@export var items_folder : String = "res://items/"
@export var item_created : int = 0

## SETTINGS --------||
@export var model_3d_steps := 'mesh, animations, textures, shader'


func get_new_item_name() -> StringName:
	var id_number := ''
	if item_created < 9:
		id_number = str('00000', item_created)
	elif item_created < 99:
		id_number = str('0000', item_created)
	elif item_created < 999:
		id_number = str('000', item_created)
	elif item_created < 9999:
		id_number = str('00', item_created)
	elif item_created < 99999:
		id_number = str('0', item_created)
	else:
		id_number = str(item_created)
	
	var new_itm_name :StringName = str("item_", id_number)
	item_created += 1
	return new_itm_name
