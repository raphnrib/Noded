extends GraphNode
class_name SMStateNode

var parent : StateMachine
var state : StateSpace
var grid : GraphEdit


func _ready():
	setup_label.call_deferred()

func setup_label():
	var label = get_titlebar_hbox().get_child(0) as Label
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER


func setup_from_state_space(s_space:StateSpace, state_machine:StateMachine, graph:GraphEdit):
	state = s_space
	parent = state_machine
	grid = graph
	
	position_offset = s_space.node_position
	position_offset_changed.connect(position_changed)
	
	refresh_interface_items()
	parent.params.section_info_changed.connect(refresh_interface_items)
	state.space_info_changed.connect(refresh_interface_items)

func refresh_interface_items():
	title = state.name
	position_offset = state.node_position

func position_changed():
	state.node_position = position_offset







