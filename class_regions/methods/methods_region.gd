extends ClassRegion
class_name MethodsRegion

@export var class_space : ClassSpace

@export var to_implement_icon : Texture2D
@export var implemented_icon : Texture2D


func _ready():
	%AddNewBtn.pressed.connect(add_new_method)


func create_new_method_link() -> MethodLinkContainer:
	var n_method_link = Interface.method_link_pref.instantiate() as MethodLinkContainer
	%ItemsRoot.add_child(n_method_link)
	%AddNewBtn.move_to_front()
	return n_method_link

func add_new_method():
	var n_method_link = create_new_method_link()
	n_method_link.setup_from_method_space(class_space.add_method(), class_space)
