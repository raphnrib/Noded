@tool
extends GraphElement
class_name TaskTimeLine

@onready var complete_bar = %CompletionBar

var task : TaskData
var task_container : TaskContainer

const size_unit := 20.0

var completion : int:
	set(value):
		complete_bar.set_value_no_signal(value)


func setup_from_task_data(data:TaskData, task_ui:TaskContainer):
	task = data
	task_container = task_ui
	set_new_duration()

func set_timeline_position_duration(from_pos:Vector2) -> Dictionary:
	var positioned_at := Vector2.ZERO
	var duration := Vector2(size_unit, size_unit)
	
	return { "position":positioned_at, "size":duration }


func _on_resize_request(new_minsize):
	var x_fixed : int = roundi(new_minsize.x / 20.0)
	var n_size : Vector2 = Vector2(x_fixed * 20.0, 20.0)
	set_size.call_deferred(n_size)
	
	task.days = x_fixed
	task_container.duration_spin_box.set_value_no_signal(x_fixed)

func set_new_duration():
	var length : int = task.days * size_unit
	var n_size := Vector2(length, size_unit)
	
	set_size(n_size)
	complete_bar.set_value_no_signal(task.completion)


func _on_mouse_entered():
	if task_container:
		task_container.set_hightlight_panel(true)

func _on_mouse_exited():
	if task_container:
		task_container.set_hightlight_panel(false)
