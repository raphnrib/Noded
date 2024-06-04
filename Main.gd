extends Control
class_name Main

@export var extension : String = '.tres'

@onready var graph_edit = $GraphEdit
@onready var popup_menu = %AddNodeMenu
@onready var proj_name_edit = %ProjNameEdit

var list_of_save_files	: Array[Dictionary]

var mouse_elsewhere : bool = false


func _ready():
	# Configure the "Load File" menu signal
	var m_popup = %OpenProjMenu.get_popup() as PopupMenu
	m_popup.index_pressed.connect(load_file)
	
	# Setup buttons
	%ClassNodeButton.pressed.connect(create_class_declaration)
	%CloseAddPanelButton.pressed.connect(close_add_node_menu)
	%AddSMButton.pressed.connect(create_state_machine)

func _input(event):
	if !mouse_elsewhere and event is InputEventMouseButton:
		if event.button_index == 2:
			popup_menu.visible = true
			popup_menu.position = get_global_mouse_position()


func create_class_declaration():
	if SS.check_global_space() == "LOADED":
		load_project_info()
	
	var new_cl_decl = create_new_class_declaration()
	new_cl_decl.setup_class(SS.create_class())
	close_add_node_menu()

func create_new_class_declaration() -> ClassDeclarationNode:
	var new_cl_decl = Interface.class_container_pref.instantiate() as ClassDeclarationNode
	new_cl_decl.position_offset = get_offset_mouse_position()
	%GraphEdit.add_child(new_cl_decl)
	return new_cl_decl

func create_state_machine():
	if SS.check_global_space() == "LOADED":
		load_project_info()
	
	var new_sm_grid = create_new_state_machine_grid() as StateMachineGrid
	var n_sm_space = SS.create_state_machine()
	new_sm_grid.setup_from_state_machine(n_sm_space)
	close_add_node_menu()
	pass

func create_new_state_machine_grid() -> StateMachineGrid:
	var n_sm = Interface.state_machine_grid.instantiate() as StateMachineGrid
	n_sm.position_offset = get_offset_mouse_position()
	%GraphEdit.add_child(n_sm)
	return n_sm

func get_offset_mouse_position() -> Vector2:
	return get_local_mouse_position() + %GraphEdit.scroll_offset


func _on_save_project_btn_pressed():
	if SS.global == null:
		MSN.msn("Has no project opened!", MSN.Mode.ERROR)
	else:
		SS.save_project()
		MSN.msn("Project saved!")

func _on_open_proj_menu_about_to_popup():
	var m_popup = %OpenProjMenu.get_popup() as PopupMenu
	m_popup.clear()
	list_of_save_files.clear()
	
	var dir = DirAccess.open("user://")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			if !dir.current_is_dir() and file_name.ends_with(extension):
				var opt = file_name.replace(extension, "")
				m_popup.add_item(opt)
				list_of_save_files.append({"name" : opt, "path" : str("user://", file_name)})
			
			file_name = dir.get_next()

func load_file(index:int):
	MSN.msn(str("Loading: ", list_of_save_files[index]))
	if SS.try_load_from_path(list_of_save_files[index]["path"]):
		load_project_info()
	else:
		MSN.msn(str("File not find @ ", list_of_save_files[index]["path"]), MSN.Mode.ERROR)

func load_project_info():
	clear_grid()
	
	## Load proj info
	%ProjNameEdit.text = SS.proj_name
	var global = SS.global as GlobalSpace
	%GraphEdit.scroll_offset = global.scroll_offset
	
	## Load all classes
	for c in global.classes:
		var n_class_display = create_new_class_declaration()
		n_class_display.position_offset = c.node_position
		n_class_display.setup_class(c)
	
	var state_machines = global.state_machines.items_array
	for sm in state_machines:
		var n_grid = create_new_state_machine_grid() as StateMachineGrid
		n_grid.position_offset = sm.node_position
		n_grid.setup_from_state_machine(sm, true)


func close_add_node_menu():
	%AddNodeMenu.visible = false

func clear_grid():
	Grid.clear_grid()

func _on_open_user_folder_pressed():
	var win = FileDialog.new()
	
	win.file_mode = FileDialog.FILE_MODE_OPEN_DIR
	win.access = FileDialog.ACCESS_USERDATA
	win.use_native_dialog = true
	
	get_node('/root').add_child(win)
	win.visible = true
	win.size = Vector2(512.0, 512.0)
	
	win.confirmed.connect(destroy_node.bind(win))
	win.canceled.connect(destroy_node.bind(win))

func destroy_node(node:Node):
	node.queue_free()


func _on_graph_edit_scroll_offset_changed(offset):
	if SS.global != null:
		SS.global.scroll_offset = offset
