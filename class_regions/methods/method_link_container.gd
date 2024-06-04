## Class Space field
## Links the method to a class

extends PanelContainer
class_name MethodLinkContainer

@export var class_space : ClassSpace
@export var method_space : MethodSpace


func _ready():
	%ImplementButton.pressed.connect(create_and_link_method)
	%DeleteMethodLink.pressed.connect(delete_method_link)


func setup_from_method_space(m_space:MethodSpace, cl_space:ClassSpace):
	class_space = cl_space
	method_space = m_space
	
	name = method_space.node_name
	method_space_updated()
	method_space.on_info_updated.connect(method_space_updated)
	
	## If has already implementation Start Node
	if method_space.has_start_node:
		var n_start_node = Grid.create_method_start_node(false) as NodeMethodStart
		n_start_node.setup_from_method_space(method_space, class_space)
	
	## If has other Call Nodes
	if !method_space.execute_nodes.is_empty():
		pass

func method_space_updated():
	%MethodNameEdit.text = method_space.name
	%MethodNameEdit.release_focus()
	%DeleteMethodLink.visible = !method_space.has_start_node

func create_and_link_method():
	var n_func_start = Grid.create_method_start_node() as NodeMethodStart
	n_func_start.setup_from_method_space(method_space, class_space)
	method_space_updated()

func delete_method_link():
	class_space.methods.erase(method_space)
	queue_free()

func _on_method_name_edit_text_submitted(new_text):
	new_text = SS.get_unique_name_from_strings(new_text, class_space.methods_names)
	method_space.name = new_text
	method_space.on_info_updated.emit()
