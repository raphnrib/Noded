@tool
extends Resource
class_name FeatureData

@export var label : String = "General"
@export var on_timeline : bool = true
@export var tasks : Array[TaskData]

## Set on initialization by the Project Process Manager
@export var general_features : bool


func new_task_data() -> TaskData:
	var n_task := TaskData.new()
	n_task.ID = randi_range(1, 99999)
	tasks.append(n_task)
	return n_task
