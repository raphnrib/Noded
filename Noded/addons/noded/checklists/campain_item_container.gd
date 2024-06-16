@tool
extends HBoxContainer
class_name NodedCampainItem

var id : String
var campain : String
var data : CheckListsData


func setup_from(item_name:String, relative_to:String, c_data:CheckListsData):
	id = item_name
	campain = relative_to
	data = c_data
