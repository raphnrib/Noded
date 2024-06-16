@tool
extends HBoxContainer
class_name StepContainer

@onready var check_button = %CheckButton

var s_name := ''
var task : TaskData
var task_ui : TaskContainer


func setup_step(step_name:String, master:TaskContainer):
	s_name = step_name
	task = master.task
	task_ui = master
	
	name = step_name + '_node'
	check_button.button_pressed = task.steps[s_name]
	check_button.text = step_name

func _on_remove_step_pressed():
	task.steps.erase(s_name)
	queue_free()


func _on_check_button_toggled(toggled_on):
	task.steps[s_name] = toggled_on
	task_ui.refresh_completion()
	pass # Replace with function body.
