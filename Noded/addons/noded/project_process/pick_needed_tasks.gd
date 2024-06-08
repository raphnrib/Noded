extends Button
class_name PickNeededTasksPanel

@export var process : ProjectProcess

@onready var task_root = %TaskRoot
@onready var dispose = %dispose

var editing : TaskContainer


func start_picking_tasks(caller:TaskContainer):
	for child in task_root.get_children():
		dispose.add_child(child)
	
	editing = caller
	visible = true
	
	var current_selection : PackedStringArray = caller.task.depends_on
	
	for feat in process.features_uis:
		for task in feat.tasks_uis:
			if task != caller:
				var selected := task.task.label in current_selection
				
				pass
			pass
	
	delete_all_disposable.call_deferred()

func delete_all_disposable():
	for child in dispose.get_children():
		child.queue_free()
