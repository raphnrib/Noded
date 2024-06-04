extends Node

@export var grid : GraphEdit

var viewport : Viewport
var main_control : Main

var proj_name : String:
	get:
		return main_control.proj_name_edit.text
	set(val):
		main_control.proj_name_edit.text = val


## Get the current grid (GraphEdit) node reference
func _ready():
	main_control = get_node('/root/Main') as Main
	grid = get_node('/root/Main/GraphEdit') as GraphEdit
	viewport = get_viewport()


func clear_grid():
	for i in range(0, grid.get_child_count()):
		#MSN.custom_msn(n, Color('74b9ff'))
		var el = grid.get_child(i) as GridElement
		if el != null:
			MSN.custom_msn([el.name, ' obsolete'], Color.WHITE, 10.0)
			el.queue_free()


func check_node_is_connected_from(node_name) -> bool:
	for cn in grid.get_connection_list():
		if cn['from_node'] == node_name:
			return true
	return false

func create_delete_button(size:int=32) -> Button:
	var btn = Button.new()
	btn.icon = load("res://UI/cross-mark_lorc.png")
	btn.expand_icon = true
	btn.custom_minimum_size = Vector2i(size, size)
	return btn


func create_method_start_node(set_position:bool=true) -> NodeMethodStart:
	var n_method_start_node = load('res://grid_nodes/methods/node_method_start.tscn').instantiate() as NodeMethodStart
	grid.add_child(n_method_start_node)
	
	var pos = viewport.get_mouse_position() + grid.scroll_offset
	if set_position:
		n_method_start_node.position_offset = pos + Vector2(128.0, 0.0)
	
	return n_method_start_node
