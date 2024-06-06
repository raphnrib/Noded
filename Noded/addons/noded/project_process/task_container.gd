@tool
extends PanelContainer
class_name TaskContainer

#var feature_owner : FeatureContainer
var task : TaskData
var timeline : TaskTimeLine

@onready var duration_spin_box : SpinBox = %DurationSpinBox
@onready var high_light_panel = %HighLightPanel


func setup_from(data:TaskData, task_tline:TaskTimeLine):
	task = data
	timeline = task_tline
	
	duration_spin_box = %DurationSpinBox as SpinBox
	duration_spin_box.set_value_no_signal(task.days)

func _on_duration_changed(value):
	task.days = value
	timeline.set_new_duration(task.days)
	pass # Replace with function body.

func set_hightlight_panel(on:bool):
	high_light_panel.visible = on
