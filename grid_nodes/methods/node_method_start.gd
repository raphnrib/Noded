extends GraphNode
class_name NodeMethodStart

@export var method_space : MethodSpace

var parent_space


func _ready():
	%VarsRegion.region_label = "Arguments"
	setup_delete_button.call_deferred()

func setup_delete_button():
	var btn = Grid.create_delete_button(24)
	get_titlebar_hbox().add_child(btn)
	btn.move_to_front()
	
	btn.self_modulate = Color("e17055")
	btn.pressed.connect(delete_node)


func setup_from_method_space(m_space, parent_s):
	method_space = m_space
	if method_space.has_start_node:
		position_offset = method_space.node_position
	else:
		method_space.has_start_node = true
		method_space.node_position = position_offset
	
	parent_space = parent_s
	name = method_space.node_name
	
	%MethodNameEdit.text = method_space.name
	%VarsRegion.parent_space = method_space
	
	method_space.on_info_updated.connect(refresh_ui_info)
	position_offset_changed.connect(_on_position_changed)


func _on_method_name_submitted(new_text):
	new_text = SS.get_unique_name_from_strings(new_text, parent_space.methods_names)
	method_space.name = new_text
	method_space.on_info_updated.emit()

func refresh_ui_info():
	%MethodNameEdit.text = method_space.name
	%MethodNameEdit.release_focus()

func _on_position_changed():
	method_space.node_position = position_offset

func delete_node():
	## TODO Confirmation box
	#if Grid.check_node_is_connected_from(name):
	
	method_space.has_start_node = false
	method_space.on_info_updated.disconnect(refresh_ui_info)
	method_space.on_info_updated.emit()
	queue_free()
