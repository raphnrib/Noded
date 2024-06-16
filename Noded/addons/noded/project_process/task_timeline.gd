@tool
extends GraphElement
class_name TaskTimeLine

@export var default_size_unit : float = 32.0

@onready var complete_bar = %CompletionBar
@onready var button = %Button

var task : TaskData
var task_container : TaskContainer
var dependants : Array[TaskTimeLine]
var offsets : Array[int] ## Positions in 'x' axis of the tasks this depends on

var completion : int:
	set(value):
		complete_bar.set_value_no_signal(value)

var size_unit : float:
	get: return default_size_unit

var fixed_size : int:
	get: return roundi(task.days * default_size_unit)

var not_dependant : bool:
	get: return task.depends_on.is_empty()

var task_label : String:
	get: return task.label


func setup_from_task_data(data:TaskData, task_ui:TaskContainer):
	task = data
	task_container = task_ui
	position_offset = task.last_timeline_pos
	set_new_duration()

## 
func update_timeline_position(to_pos:Vector2) -> int:
	task.last_timeline_pos = to_pos
	position_offset = to_pos
	return roundi(position_offset.x + fixed_size)

func set_phantom_mode(enable:bool):
	if enable:
		button.theme_type_variation = 'PhantomTimelineButton'
		complete_bar.theme_type_variation = 'PhantomBar'
		modulate = Color.WHITE
	else:
		button.theme_type_variation = 'TimelineButton'
		complete_bar.theme_type_variation = ''
		modulate = task.color

func adjust_position_to_precedents_task():
	if offsets.is_empty():
		#print("Task ", task.label, " has no offsets")
		return
	
	var max_x := offsets.max()
	var pos : Vector2= position_offset
	pos.x = max_x
	offsets.clear()
	update_timeline_position(pos)

func _on_resize_request(new_minsize):
	var x_fixed : int = roundi(new_minsize.x / default_size_unit)
	var n_size : Vector2 = Vector2(x_fixed * default_size_unit, default_size_unit)
	set_size.call_deferred(n_size)
	
	task.days = x_fixed
	task_container.duration_spin_box.set_value_no_signal(x_fixed)

func set_new_duration():
	var length : int = fixed_size
	var n_size := Vector2(length, default_size_unit)
	
	set_size(n_size)
	complete_bar.set_value_no_signal(task.completion)


func _on_mouse_entered():
	if task_container:
		task_container.set_hightlight_panel(true)

func _on_mouse_exited():
	if task_container:
		task_container.set_hightlight_panel(false)
