extends GraphElement
class_name GridElement

@export var obsolete : bool = false


func _process(delta):
	if obsolete:
		queue_free()
