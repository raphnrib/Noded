@tool
extends Control
class_name ProjectProcess

@onready var time_line_graph = %TimeLineGraph
@onready var features_root = %FeaturesRoot
@onready var add_feat_btn = %AddFeatBtn
@onready var start_mark = %StartMark
@onready var finish_mark = %FinishMark

var dirty : bool = true ## Indicated wheater is necessary to refresh the timeline view
var tab_pos := Vector2.ZERO ## Current tabulation position when placing nodes in the GraphEdit
var data : ProjProcessData

## Process keeps track of the features
var features_uis : Array[FeatureContainer]

var feature_pref = preload("res://addons/noded/project_process/feature_container.tscn")
var task_timeline = preload("res://addons/noded/project_process/task_timeline.tscn")


func _ready():
	add_center_graph_btn()

func _process(delta):
	if dirty:
		organize_graph_view()
		dirty = false

## Inicialization and Resource Info Update
func setup_from(main_data:NodedData):
	if main_data.proj_processes_data == null:
		main_data.proj_processes_data = ProjProcessData.new()
	
	data = main_data.proj_processes_data
	if data.features.is_empty(): ## Create default Features Data
		var gen_feat := FeatureData.new()
		gen_feat.general_features = true
		gen_feat.on_timeline = true
		data.features.append(gen_feat)
	
	if features_root == null:
		features_root = %FeaturesRoot
	
	for f in data.features:
		var f_ui := create_feature_ui()
		f_ui.setup_from_feature_data(f, self)
	
	dirty = true


func add_center_graph_btn():
	var center_graph_btn := Button.new()
	center_graph_btn.text = "Center"
	center_graph_btn.pressed.connect(center_graph)
	
	var hbox : HBoxContainer = time_line_graph.get_menu_hbox()
	hbox.add_child(center_graph_btn)

func center_graph():
	var height : float = time_line_graph.get_rect().size.y
	time_line_graph.scroll_offset = Vector2(0.0, -height * 0.1)
	time_line_graph.zoom = 1.0

func organize_graph_view():
	start_mark.visible = false
	finish_mark.visible = false
	
	# TODO Hide or show the tasks in the timeline depending on the 'Show Timeline' check @ theirs Feature owner
	for f in features_uis:
		f.set_visibility_all()
	
	# TODO Organize all the visible nodes setting their positions
	# Organize by: ?
	tab_pos = Vector2.ZERO
	for f in features_uis:
		if f.visible_on_timeline:
			pass
			#f.organize_timeline(current_position)
	
	pass

func move_tabulation_horizontal(by:int):
	tab_pos.x += by

func move_tabulation_vertical(by:int):
	tab_pos.y += by

func move_tabulation_to_position(pos:Vector2):
	tab_pos += pos


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
