@tool
extends PanelContainer
class_name TaskContainer

@onready var duration_spin_box : SpinBox = %DurationSpinBox
@onready var high_light_panel = %HighLightPanel
@onready var del_task = %DelTask
@onready var color_picker_button = %ColorPickerButton
@onready var progress_bar = %ProgressBar

@onready var completion_slider = %CompletionSlider
@onready var task_label_line_edit = %TaskLabelLineEdit
@onready var id_label = %IDLabel
@onready var look_for_edit = %LookForEdit
@onready var descript_edit = %DescriptEdit

@onready var steps_root = %StepsRoot
@onready var add_step_line_edit = %AddStepLineEdit
@onready var select_predefined_steps = %SelectPredefinedSteps

var cheked_on_timeline := false
var main_data : NodedData
var task : TaskData
var timeline : TaskTimeLine
var task_picker_ui : TaskPicker
var controller : FeatureData

var step_container_pref = preload("res://addons/noded/project_process/step_container.tscn")


func setup_from(data:TaskData, task_tline:TaskTimeLine, task_picker:TaskPicker, feat_main:FeatureContainer):
	main_data = feat_main.main_data
	task = data
	timeline = task_tline
	task_picker_ui = task_picker
	controller = feat_main.data
	
	task_label_line_edit.text = data.label
	id_label.text = task.id_string
	look_for_edit.text = task.look_for
	descript_edit.text = task.description
	
	duration_spin_box = %DurationSpinBox as SpinBox
	duration_spin_box.set_value_no_signal(task.days)
	
	color_picker_button.color = task.color
	timeline.modulate = task.color
	completion_slider.set_value_no_signal(task.completion)
	
	## SETUP STEPS
	for step in task.steps.keys():
		var n_stepc := create_new_step_container()
		n_stepc.setup_step(step, self)
	
	refresh_completion()


## SAVE LOAD -----------------------------------------------------------------##

func save() -> Dictionary:
	# TODO Get data and steps data
	return {
		
	}

func load_dictionary(dict:Dictionary, main:NodedMain) -> void:
	
	pass



func refresh_completion():
	if task.steps.is_empty():
		progress_bar.value = completion_slider.value
	else:
		var total := 1.0
		var completed : float = completion_slider.value / 100.0
		for step in task.steps:
			total += 1.0
			if task.steps[step]:
				completed += 1.0
		
		progress_bar.value = 100.0 * (completed/total)


func _on_duration_changed(value):
	task.days = value
	timeline.set_new_duration()
	## Should not release focus to input more than one digit

func set_hightlight_panel(on:bool):
	high_light_panel.visible = on

func _on_del_task_pressed():
	controller.tasks.erase(task)
	timeline.queue_free()
	queue_free()


func _on_color_picker_button_color_changed(color):
	task.color = color
	timeline.modulate = task.color
	pass # Replace with function body.

func _on_completion_slider_value_changed(value):
	task.completion = value
	timeline.completion = value
	refresh_completion()

func _on_dependencies_button_pressed():
	task_picker_ui.start_picking_tasks(self)
	pass # Replace with function body.

func _on_task_label_line_edit_text_submitted(new_text:String):
	task.label = new_text
	task_label_line_edit.release_focus()
	look_for_edit.placeholder_text = new_text.strip_edges().to_upper()
	pass # Replace with function body.

func _on_look_for_edit_text_submitted(new_text):
	task.look_for = new_text
	look_for_edit.release_focus()
	pass # Replace with function body.

func _on_descript_edit_text_changed():
	task.description = descript_edit.text
	pass # Replace with function body.


## STEPS -----------------------||

func  create_new_step_container() -> StepContainer:
	var n_stepc := step_container_pref.instantiate() as StepContainer
	steps_root.add_child(n_stepc)
	return n_stepc

func _on_add_step_line_edit_text_submitted(new_text):
	task.steps[new_text] = false
	var n_stepc := create_new_step_container()
	n_stepc.setup_step(new_text, self)
	add_step_line_edit.text = ''
	add_step_line_edit.release_focus()


func _on_select_predefined_steps_item_selected(index):
	match index:
		1: ## CASE 3D MODEL STEPS
			var steps := main_data.model_3d_steps.strip_edges().split(',')
			for step in steps:
				if task.steps.has(step):
					continue
				else:
					task.steps[step] = false
					var n_stepc := create_new_step_container()
					n_stepc.setup_step(step, self)
	
	select_predefined_steps.selected = 0
	select_predefined_steps.release_focus()
