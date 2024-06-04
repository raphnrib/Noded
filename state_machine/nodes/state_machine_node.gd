extends GraphElement
class_name StateMachineGrid

@export var state_machine : StateMachine

var main_control : Main
var mouse_here : bool = false

var param_container = preload("res://state_machine/nodes/left_menu/sm_param_container.tscn")
#var state_container = preload("res://state_machine/nodes/left_menu/state_space_container.tscn")
var state_node = preload("res://state_machine/nodes/grid/sm_state_node.tscn")


func _ready():
	main_control = get_node("/root/Main") as Main

func setup_from_state_machine(s_machine:StateMachine, load_pos_info:bool=false):
	state_machine = s_machine
	%SMNameEdit.text = state_machine.name
	
	if load_pos_info:
		position_offset = state_machine.node_position
		size = state_machine.node_size
	
	## Loading PARAMETERS and its CONDITION NODES
	if s_machine.params.has_items:
		for p in s_machine.params.items_array:
			p.links.clear() ## Clear to remake them on load
			var p_container = create_param_display()
			#p_container.setup_from_param(p, s_machine.params)
	
	## Loading STATES
	if s_machine.states.has_items:
		for s in s_machine.states.items_array:
			create_state_displays_for(s)
	
	## Load CONDITIONS
	
	## Load LINKS
	
	position_offset_changed.connect(_position_changed)
	resize_request.connect(_resized)


func _input(event):
	if mouse_here:
		if event is InputEventMouseButton and event.is_pressed():
			if event.button_index == 2:
				MSN.msn("Left clicked on inside grid")

func _position_changed():
	state_machine.node_position = position_offset

func _resized(new_minsize):
	state_machine.node_size = new_minsize

func _on_mouse_entered():
	mouse_here = true
	if main_control:
		main_control.mouse_elsewhere = true

func _on_mouse_exited():
	mouse_here = false
	if main_control:
		main_control.mouse_elsewhere = false


func _on_graph_edit_connection_request(from_node, from_port, to_node, to_port):
	if to_port != 0:
		MSN.msn("Not connected to Enter State Port!")
		return
	if from_port == 1:
		MSN.msn("State will ignore conditions!")
	%StateGrid.connect_node(from_node, from_port, to_node, to_port)

## Create a new Parameter based on selected type
func _on_param_tp_option_button_item_selected(index):
	var param_cont = create_param_display()
	
	match index:
		0:
			var n_param = state_machine.params.add_float_param()
			param_cont.setup_from_param(n_param, state_machine.params)
		1:
			var n_param = state_machine.params.add_int_param()
			param_cont.setup_from_param(n_param, state_machine.params)
		2:
			var n_param = state_machine.params.add_bool_param()
			param_cont.setup_from_param(n_param, state_machine.params)
		3:
			var n_param = state_machine.params.add_trigger_param()
			param_cont.setup_from_param(n_param, state_machine.params)
		4:
			var n_param = state_machine.params.add_timer_param()
			param_cont.setup_from_param(n_param, state_machine.params)
	%ParamTpOptionButton.selected = -1

func create_param_display() -> SMParamSpaceContainer:
	var param_cont = param_container.instantiate() as SMParamSpaceContainer
	%ParametersRoot.add_child(param_cont)
	%ParamsEdit.move_to_front()
	return param_cont


## Add a new State to the SMGrid
func _on_add_state_button_pressed():
	var n_state = state_machine.states.add_new_item()
	create_state_displays_for(n_state)

## Add SMGrid Node
func create_state_displays_for(state:StateSpace):
	var n_node = state_node.instantiate() as SMStateNode
	%StateGrid.add_child(n_node)
	n_node.setup_from_state_space(state, state_machine, %StateGrid)
	return null


func start_edit_parameters():
	var edit_panel = Interface.editing_section_pref.instantiate() as SpaceSectionEditor
	%ContentContainer.add_child(edit_panel)
	edit_panel.setup(state_machine.params)
	edit_panel.editing_finished.connect(finish_edit_parameters)

func finish_edit_parameters(has_changes:bool):
	MSN.msn(["Has changes ", has_changes])
	if !has_changes:
		return
	
	var root = %ParametersRoot
	for p in range(0, root.get_child_count()):
		var child = root.get_child(p)
		if child is SMParamSpaceContainer:
			if child.param.removed_at_source:
				child.queue_free()

func _on_sm_name_edit_text_submitted(new_text):
	new_text = SS.global.state_machines.check_unique_name(new_text)
	state_machine.name = new_text
	state_machine.space_info_changed.emit()
	%SMNameEdit.release_focus()















