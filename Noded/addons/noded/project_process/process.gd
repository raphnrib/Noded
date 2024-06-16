@tool
extends Control
class_name ProjectProcess

@onready var time_line_graph = %TimeLineGraph
@onready var features_root = %FeaturesRoot
@onready var add_feat_btn = %AddFeatBtn
@onready var start_mark = %StartMark
@onready var finish_mark = %FinishMark
@onready var task_picker = %TaskPicker
#@onready var disposables = %disposables
@onready var tab_container = $TabContainer

var dirty : bool = true ## Indicated wheater is necessary to refresh the timeline view
var tab_pos := Vector2.ZERO ## Current tabulation position when placing nodes in the GraphEdit
var main_data : NodedData
var data : ProjProcessData

## Process keeps track of the features
var features_uis : Array[FeatureContainer]

var feature_pref = preload("res://addons/noded/project_process/feature_container.tscn")
var task_timeline = preload("res://addons/noded/project_process/task_timeline.tscn")


func _ready():
	tab_container.current_tab = 0
	add_center_graph_btn()
	center_graph()

func _process(delta):
	if dirty:
		organize_graph_view()
		dirty = false

## Inicialization and Resource Info Update + Dispose old nodes
func setup_from(main_data:NodedData):
	self.main_data = main_data
	data = main_data.proj_processes_data
	
	if data.features.is_empty(): ## Create default Features Data
		var gen_feat := FeatureData.new()
		gen_feat.general_features = true
		gen_feat.on_timeline = true
		data.features.append(gen_feat)
	
	if features_root == null:
		features_root = %FeaturesRoot
	for child in features_root.get_children():
		features_root.remove_child(child)
		child.queue_free()
	
	for f in data.features:
		var f_ui := create_feature_ui()
		f_ui.setup_from_feature_data(f, self)
	
	dirty = true


## SAVE LOAD -----------------------------------------------------------------##

func save() -> Dictionary:
	# TODO Get data from all the features
	return {}

func load_dictionary(dict:Dictionary, main:NodedMain) -> void:
	
	print(name, " Noded data updated!")
	pass


## TIMELINE VIEW MANAGEMENT --------------------------------------------------##

func add_center_graph_btn():
	var center_graph_btn := Button.new()
	center_graph_btn.text = "Center"
	center_graph_btn.pressed.connect(center_graph)
	
	var hbox : HBoxContainer = time_line_graph.get_menu_hbox()
	hbox.add_child(center_graph_btn)

func center_graph():
	time_line_graph.zoom = 1.0
	finish_center_graphic.call_deferred()

func finish_center_graphic():
	var height : float = time_line_graph.get_rect().size.y
	time_line_graph.scroll_offset = Vector2(0.0, -height * 0.1)


func organize_graph_view():
	start_mark.visible = false
	finish_mark.visible = false
	tab_pos = Vector2.ZERO
	
	# Check which task depends on which beforehand
	var all_task_timelines : Array[TaskTimeLine] = []
	for f in features_uis:
		all_task_timelines.append_array(f.get_all_timelines())
		f.clear_all_dependencies()
	
	for dependant_task in all_task_timelines:
		if dependant_task.not_dependant:
			continue
		
		for precedent_task in all_task_timelines:
			if precedent_task != dependant_task:
				if precedent_task.task.ID in dependant_task.task.depends_on:
					precedent_task.dependants.append(dependant_task)
				pass
	
	# Hide/Show tasks in timeline depending on the 'Show Timeline' check and dependencies
	for f in features_uis:
		f.set_visibility_all()
	
	# Place/Set Positions of nodes and their dependants
	tab_pos = Vector2.ZERO
	for f in features_uis:
		f.place_timeline_nodes(all_task_timelines)
	
	for f in features_uis:
		f.adjust_all_node_offsets()

func move_tabulation_horizontal(by:float):
	tab_pos.x += by

func move_tabulation_vertical(by:float):
	tab_pos.y += by

func move_tabulation_to_position(pos:Vector2):
	tab_pos += pos


## FEATURE CREATIONS ---------------------------------------------------------##

func create_feature_ui() -> FeatureContainer:
	var n_feat := feature_pref.instantiate() as FeatureContainer
	features_root.add_child(n_feat)
	features_uis.append(n_feat)
	return n_feat

## Accessed by the feature to create a timeline entry in the Graph
func create_task_on_timeline() -> TaskTimeLine:
	var n_tline := task_timeline.instantiate() as TaskTimeLine
	time_line_graph.add_child(n_tline)
	return n_tline

func _on_add_feat_btn_pressed():
	var n_feature := data.new_feature_data()
	var n_fui := create_feature_ui()
	n_fui.setup_from_feature_data(n_feature, self)


## TABULATION CHANGED --------------------------------------------------------##

func _on_tab_container_tab_changed(tab):
	if tab == 1:
		organize_graph_view()
	pass # Replace with function body.
