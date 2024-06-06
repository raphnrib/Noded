@tool
extends GraphElement
class_name TaskTimeLine

#var feature_owner : FeatureContainer
var task : TaskData
var task_container : TaskContainer


func setup_from_task_data(data:TaskData, task_ui:TaskContainer):
	task = data
	task_container = task_ui
	set_new_duration(task.days)

func _on_resize_request(new_minsize):
	var x_fixed : int = roundi(new_minsize.x / 20.0)
	var n_size : Vector2 = Vector2(x_fixed * 20.0, 20.0)
	set_size.call_deferred(n_size)
	
	task.days = x_fixed
	task_container.duration_spin_box.set_value_no_signal(x_fixed)

func set_new_duration(n_days:int):
	var n_size := Vector2(20.0 * n_days, 20.0)
	set_size(n_size)


func _on_mouse_entered():
	if task_container:
		task_container.set_hightlight_panel(true)

func _on_mouse_exited():
	if task_container:
		task_container.set_hightlight_panel(false)
