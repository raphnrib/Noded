extends Resource
class_name Space

@export var name : String = "clean_space"

@export var node_name : String = "Node"
@export var node_position : Vector2
@export var node_size : Vector2i

@export var code : int
@export var owner_code	: int
@export var owner_type	: SS.Ownership = 0

## If 'true' this property space should no longer exist
@export var removed_at_source : bool = false
@export var links : Array[Space]

signal space_info_changed
