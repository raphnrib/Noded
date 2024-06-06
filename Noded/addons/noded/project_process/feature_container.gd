@tool
extends PanelContainer
class_name FeatureContainer

@onready var tasks_root = %TasksRoot
@onready var add_task = %AddTask
@onready var on_timeline_check = %OnTimelineCheck
@onready var label = %Label

var data : FeatureData
var control : ProjectProcess

var task_pref = preload("res://addons/noded/project_process/task_container.tscn")


func setup_from_feature_data(f_data:FeatureData, controller:ProjectProcess):
	data = f_data
	control = controller
	
	label.text = data.label
	on_timeline_check.button_pressed = data.on_timeline
	
	if !data.tasks.is_empty():
		for t in data.tasks:
			create_ui_and_timeline_for(t)
	
	print("Feature: ", data.label, " setup")

func create_task_container() -> TaskContainer:
	var n_tcont := task_pref.instantiate() as TaskContainer
	if tasks_root == null:
		tasks_root = %TasksRoot
	tasks_root.add_child(n_tcont)
	return n_tcont


func _on_add_task_pressed():
	var n_task := data.new_task_data()
	create_ui_and_timeline_for(n_task)

func create_ui_and_timeline_for(task_d:TaskData):
	var n_tcont := create_task_container()
	var n_tline := control.create_task_on_timeline()
	
	n_tcont.setup_from(task_d, n_tline)
	n_tline.setup_from_task_data(task_d, n_tcont)


func _on_on_timeline_check_toggled(toggled_on):
	data.on_timeline = toggled_on
	control.dirty = true
