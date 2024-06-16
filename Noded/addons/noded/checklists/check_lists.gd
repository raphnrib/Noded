@tool
extends Control
class_name NodedChecklist

var data : CheckListsData


func load_from_data(n_data:NodedData):
	pass


## SAVE LOAD -----------------------------------------------------------------##

func save() -> Dictionary:
	
	return {}

func load_dictionary(dict:Dictionary, main:NodedMain) -> void:
	
	print(name, " Noded data updated!")
	pass
