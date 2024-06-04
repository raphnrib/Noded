extends HBoxContainer
class_name ClassRegionHeader

@export var label_text : String = "Region Name"

var can_resize_x : bool:
	set(val):
		%Space1xBtn.visible = val
		%Space1_5xBtn.visible = val
		%Space2xBtn.visible = val

@onready var space_1x_btn = %Space1xBtn
@onready var space_1_5x_btn = %Space1_5xBtn
@onready var space_2x_btn = %Space2xBtn


func _ready():
	%Label.text = label_text
