@tool
extends PanelContainer
class_name TaskContainer

@onready var duration_spin_box : SpinBox = %DurationSpinBox
@onready var high_light_panel = %HighLightPanel
@onready var del_task = %DelTask
@onready var color_picker_button = %ColorPickerButton
@onready var completion_slider = %CompletionSlider

var cheked_on_timeline := false
var task : TaskData
var timeline : TaskTimeLine


func setup_from(data:TaskData, task_tline:TaskTimeLine):
	task = data
	timeline = task_tline
	
	duration_spin_box = %DurationSpinBox as SpinBox
	duration_spin_box.set_value_no_signal(task.days)
	
	color_picker_button.color = task.color
	timeline.modulate = task.color


func _on_duration_changed(value):
	task.days = value
	timeline.set_new_duration()
	pass # Replace with function body.

func set_hightlight_panel(on:bool):
	high_light_panel.visible = on

func _on_del_task_pressed():
	pass # Replace with function body.


func _on_color_picker_button_color_changed(color):
	task.color = color
	timeline.modulate = task.color
	pass # Replace with function body.

func _on_completion_slider_value_changed(value):
	task.completion = value
	timeline.completion = value
	pass # Replace with function body.
