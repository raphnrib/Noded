## Node in a State Machine grid Container of a Parameter

extends HBoxContainer
class_name ParamContainer

var parent : StateMachine
var param : SMParamSpace

@onready var label : LineEdit = %Label
@onready var delete_btn : Button = %DeleteBtn


func _ready():
	label.text_submitted.connect(new_label)
	delete_btn.pressed.connect(delete_parameter)

func new_label(new_text:String):
	param.label = new_text
	label.release_focus()

func delete_parameter():
	parent.parameters.erase(param)
	queue_free()
