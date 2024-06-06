@tool
extends Resource
class_name NodedEntryData

## Defined on creation only
@export var type : String = 'None'
@export var node_name : String

## Defined by the user
@export var name : String = "Named" ## The entry name
@export var classif_name : String = ''
@export var classif_index : int = -1
@export var description : String = "Description" ## The desciption of this entry

## Auto save & load
@export var node_position : Vector2
@export var node_size : Vector2

const ENTRY_TYPES = { char=&'Character', culture=&'Culture' }


static func new_character_entry() -> NodedEntryData:
	var n_entry := NodedEntryData.new()
	n_entry.type = ENTRY_TYPES.char
	n_entry.node_name = str("char_node_", randi_range(1000, 9999))
	return n_entry

static func new_culture_entry() -> NodedEntryData:
	var n_entry := NodedEntryData.new()
	n_entry.type = ENTRY_TYPES.culture
	n_entry.node_name = str("char_node_", randi_range(1000, 9999))
	return n_entry
