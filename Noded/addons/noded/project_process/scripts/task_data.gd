@tool
extends Resource
class_name TaskData

@export var ID : int = -1
@export var label : String = "Task"
@export var look_for : String

@export var color : Color = Color.WHITE
@export var days : int = 1
@export var completion : int = 0

@export var depends_on : PackedByteArray = []
@export var description : String

@export var steps : Dictionary = {}
@export var last_timeline_pos : Vector2

var id_string: String:
	get:
		if ID > 9999:
			return str(ID)
		elif ID > 999:
			return str("0", ID)
		elif ID > 99:
			return str("00", ID)
		elif ID > 9:
			return str("000", ID)
		else:
			return str("0000", ID)
