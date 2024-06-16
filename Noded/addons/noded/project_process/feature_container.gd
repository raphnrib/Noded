@tool
extends PanelContainer
class_name FeatureContainer

@onready var tasks_root = %TasksRoot
@onready var add_task = %AddTask
@onready var on_timeline_check = %OnTimelineCheck
@onready var label = %Label
@onready var label_2 = %Label2
@onready var label_edit : LineEdit = %LabelEdit
@onready var delete_button = %DeleteButton

var visible_on_timeline := false
var main_data : NodedData
var data : FeatureData
var control : ProjectProcess
## The Feature keeps track of all the task entries
var tasks_uis : Array[TaskContainer]

var task_pref = preload("res://addons/noded/project_process/task_container.tscn")


## INITS ---------------------------------------------------------------------##

func setup_from_feature_data(f_data:FeatureData, controller:ProjectProcess):
	data = f_data
	control = controller
	main_data = control.main_data
	
	if data.general_features:
		label.text = "General"
		label_2.visible =false
		label_edit.visible = false
		delete_button.visible = false
	else:
		delete_button.visible = true
		label.visible = false
		label_2.visible = true
		label_edit.visible = true
		label_edit.text = data.label
	on_timeline_check.button_pressed = data.on_timeline
	
	if !data.tasks.is_empty():
		for t in data.tasks:
			create_ui_and_timeline_for(t)


## SAVE LOAD -----------------------------------------------------------------##

func save() -> Dictionary:
	# TODO Get all tasks data
	return {}

func load_dictionary(dict:Dictionary, main:NodedMain) -> void:
	
	pass


func create_task_container() -> TaskContainer:
	var n_tcont := task_pref.instantiate() as TaskContainer
	if tasks_root == null:
		tasks_root = %TasksRoot
	tasks_root.add_child(n_tcont)
	tasks_uis.append(n_tcont)
	return n_tcont

func _on_add_task_pressed():
	var n_task := data.new_task_data()
	create_ui_and_timeline_for(n_task)

func create_ui_and_timeline_for(task_d:TaskData):
	var n_tcont := create_task_container()
	var n_tline := control.create_task_on_timeline()
	
	n_tcont.setup_from(task_d, n_tline, control.task_picker, self)
	n_tline.setup_from_task_data(task_d, n_tcont)


## ORGANIZING TIMELINE -------------------------------------------------------##

func get_all_timelines() -> Array[TaskTimeLine]:
	var result : Array[TaskTimeLine]
	for t in tasks_uis:
		result.append(t.timeline)
	return result

func clear_all_dependencies():
	for t in tasks_uis:
		var timeline := t.timeline
		timeline.dependants.clear()
		timeline.offsets.clear()

func set_visibility_all():
	visible_on_timeline = data.on_timeline
	for t in tasks_uis:
		var timeline := t.timeline
		var has_dependents := !timeline.dependants.is_empty()
		
		timeline.visible = visible_on_timeline or has_dependents
		timeline.set_phantom_mode(!visible_on_timeline and has_dependents)

func place_timeline_nodes(all_timelines:Array[TaskTimeLine]):
	for t in tasks_uis:
		var timeline := t.timeline
		var has_dependants := !timeline.dependants.is_empty()
		
		# If not visible nor is shown as 'phanton'
		if !visible_on_timeline and !has_dependants:
			continue
		
		# Update pos and get 'x' position from its end
		var new_x = timeline.update_timeline_position(control.tab_pos)
		if has_dependants:
			for dependant in all_timelines:
				#var dependant := checking_dependent.timeline as TaskTimeLine
				if dependant == timeline:
					continue
				
				var task := dependant.task
				if dependant in timeline.dependants:
					# Add to the 'x' position of the dependant
					dependant.offsets.append(new_x)
		
		control.move_tabulation_vertical(timeline.size_unit)

func adjust_all_node_offsets():
	for t in tasks_uis:
		var timeline := t.timeline
		timeline.adjust_position_to_precedents_task()


## CALLBACKS SIGNALS ---------------------------------------------------------##

## Makes a feature timeline visible or not
func _on_on_timeline_check_toggled(toggled_on):
	data.on_timeline = toggled_on
	control.dirty = true

func _on_label_edit_text_submitted(new_text):
	data.label = new_text
	label_edit.release_focus()
	pass # Replace with function body.


func _on_delete_button_pressed():
	var main_features := control.data.features
	main_features.erase(data)
	queue_free()
