## Interface responsable for editing class info

extends GridElement
class_name ClassDeclarationNode

@export var class_space : ClassSpace

@onready var vars_region = %VarsRegion
@onready var methods_region = %MethodsRegion
@onready var enums_region = %EnumsRegion


func _ready():
	size = Vector2i(256+32, 512)


func setup_class(cl_space:ClassSpace):
	class_space = cl_space
	class_space.check_initialize_class()
	name = class_space.node_name
	size = class_space.node_size
	
	%ClassNameEdit.text = class_space.name
	set_new_class_name(class_space.name)
	_on_position_offset_changed()
	
	setup_regions.call_deferred()
	position_offset_changed.connect(_on_position_offset_changed)
	
	## Load all the existing VARIABLES
	if !class_space.vars.is_empty():
		load_preexisting_variables()
	
	## Load all the existing METHODS
	if !class_space.methods.is_empty():
		load_preexisting_methods()
	
	## Load all existing ENUMS
	if class_space.enum_section != null and !class_space.enum_section.items_array.is_empty():
		load_preexisting_enums()

func load_preexisting_methods():
	var m_reg = %MethodsRegion as MethodsRegion
	for ml in class_space.methods:
		var m_link = m_reg.create_new_method_link() as MethodLinkContainer
		m_link.setup_from_method_space(ml, class_space)

func load_preexisting_variables():
	var v_region = %VarsRegion as VarsRegion
	for v in class_space.vars:
		var v_cont = v_region.create_var_container() as VarContainer
		v_cont.setup_from_var_space(v, class_space)

func load_preexisting_enums():
	var e_region = %EnumsRegion as EnumsRegion
	for e in class_space.enum_section.items_array:
		var e_container = e_region.create_enum_container() as EnumContainer
		e_container.setup_from_enum_space(e, class_space.enum_section)

func setup_regions():
	vars_region.parent_space = class_space
	methods_region.class_space = class_space
	
	## Setup enum Region and Section
	enums_region.parent_space = class_space
	enums_region.enum_section = class_space.enum_section


func _on_class_name_edited(new_text=''):
	new_text = SS.check_unique_class_name(new_text)
	set_new_class_name(new_text)
	%ClassNameEdit.release_focus()

func set_new_class_name(new_name:String):
	class_space.name = new_name
	%ClassNameLabel.text = str("- ", new_name, " -") if new_name != "" else "- Class -"

func set_inheritance(new_text):
	pass


func delete_class():
	if !class_space.locked:
		SS.global.classes.erase(class_space)
		queue_free()

func _on_position_offset_changed():
	class_space.node_position = position_offset


func _on_resize_request(new_minsize):
	class_space.node_size = new_minsize
