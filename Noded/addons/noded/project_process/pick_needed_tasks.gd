@tool
extends Button
class_name TaskPicker

@export var process : ProjectProcess

@onready var task_root = %TaskRoot
@onready var dispose = %dispose

var editing : TaskContainer
var editing_list : Array[int]


## Picking tasks to be required to anothers
func start_picking_tasks(caller:TaskContainer):
	visible = true
	for child in task_root.get_children(true):
		task_root.remove_child(child)
		dispose.add_child(child)
	
	editing = caller
	editing_list.clear()
	
	var current_selection : PackedByteArray = caller.task.depends_on
	
	for feat in process.features_uis:
		for task in feat.tasks_uis:
			if task != caller:
				var task_data := task.task
				var selected := task_data.ID in current_selection
				var n_toggle := CheckBox.new()
				
				task_root.add_child(n_toggle)
				n_toggle.text = task_data.label
				n_toggle.button_pressed = selected
				n_toggle.size_flags_horizontal = Control.SIZE_EXPAND_FILL
				n_toggle.toggled.connect(toggle_requirement_for.bind(task_data.ID))
				
				if selected:
					editing_list.append(task_data.ID)
	
	## Finally dispose of any not needed node
	delete_all_disposable.call_deferred()


## EDITING -------------------------------------------------------------------##

func toggle_requirement_for(toggle:bool, task_id:int):
	if toggle:
		editing_list.append(task_id)
	else:
		editing_list.erase(task_id)

func _on_save_button_pressed():
	var new_list : PackedByteArray = editing_list
	editing.task.depends_on = new_list
	visible = false
	
	editing_list.clear()
	process.dirty = true

func _on_cancel_button_pressed():
	visible = false


## HELPERS -------------------------------------------------------------------##

## 'queue_free()' and 'queue()' has proven to be complicated... As a precaution I usually create a node to dispose of its children in another call
func delete_all_disposable():
	for child in dispose.get_children():
		child.queue_free()
