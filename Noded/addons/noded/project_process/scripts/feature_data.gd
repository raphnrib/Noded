@tool
extends Resource
class_name FeatureData

@export var label : String = "General"
@export var on_timeline : bool = false
@export var tasks : Array[TaskData]

## Set on initialization by the Project Process Manager
@export var general_features : bool


func new_task_data() -> TaskData:
	var n_task := TaskData.new()
	tasks.append(n_task)
	return n_task
