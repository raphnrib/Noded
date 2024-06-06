@tool
extends Resource
class_name StorySettingsData

@export var pos_offset : Vector2 = Vector2(0.0, 0.0)

@export var cultures : Array[NodedEntryData] = []
@export var characters : Array[NodedEntryData] = []

#@export var images
#@export var text_notes

## Node connections; from the GraphEdit
@export var connections : Dictionary


func new_character_entry() -> NodedEntryData:
	var n_char := NodedEntryData.new_character_entry()
	characters.append(n_char)
	return n_char

func new_culture_entry() -> NodedEntryData:
	var n_char := NodedEntryData.new_culture_entry()
	cultures.append(n_char)
	return n_char
