@tool
extends Resource
class_name TaskData

@export var label: String = "Task"
@export var color : Color = Color.WHITE
@export var days : int = 1
@export var completion : int = 0
@export var depends_on : PackedStringArray = []
