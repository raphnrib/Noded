@tool
extends Control
class_name Govenor

@onready var projects_root = %ProjectsRoot
@onready var nodeds_root = %NodedsRoot
@onready var s_gs_root = %SGsRoot
@onready var current_noded_folder_info = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/CurrentNodedFolderInfo

var data : GovenorData
var updated_info : Array[GovernedProjInfoCollected]
var sys_time
var organized : int = 0
var noded_folder_stats := Vector2.ZERO ## x = num of files // y = size of folder

var governated_proj_pref = preload("res://addons/gov_plugin/proj_info_container.tscn")
var slim_folder_pref = preload("res://addons/gov_plugin/slim_proj_container.tscn")

const projs_folder := 'd:/Godot Projects'
const data_path := 'res://govenor_data.tres'
const sg_path := 'sg_else.gd'
const noded_path := 'addons/noded'


func _ready():
	configure_govenor()
	refresh_projects_info()
	
	update_noded_in_project("")

func configure_govenor():
	if !FileAccess.file_exists(data_path):
		var n_data := GovenorData.new()
		ResourceSaver.save(n_data, data_path)
	data = ResourceLoader.load(data_path)


func refresh_projects_info():
	for child in projects_root.get_children():
		projects_root.remove_child(child)
		child.queue_free()
	
	noded_folder_stats = calc_folder_size('res://addons/noded')
	current_noded_folder_info.text = str(noded_folder_stats.x, " items :: ", noded_folder_stats.y, " bytes")
	
	var projects := DirAccess.get_directories_at(projs_folder)
	for proj_f in projects:
		if proj_f != 'Noded':
			check_project(proj_f, projs_folder + "/" + proj_f)

func check_project(proj, p_path):
	var addon_path := str(p_path, "/", noded_path)
	var proj_numbers := Vector2i.ZERO
	var is_equal := false
	
	if DirAccess.dir_exists_absolute(addon_path):
		proj_numbers = calc_folder_size(addon_path)
		
		is_equal = proj_numbers.x == noded_folder_stats.x and\
		proj_numbers.y == noded_folder_stats.y
	
	var n_slim := slim_folder_pref.instantiate() as SlimProjContainer
	projects_root.add_child(n_slim)
	n_slim.setup_from(proj, addon_path, proj_numbers.x, proj_numbers.y, !is_equal, self)

func calc_folder_size(path:String) -> Vector2i:
	var sub_dirs := DirAccess.get_directories_at(path)
	var f_size := Vector2i(0, 0)
	
	if sub_dirs:
		for s_dir in sub_dirs:
			f_size += calc_folder_size(path + "/" + s_dir)
	
	var files := DirAccess.get_files_at(path)
	if files:
		for f in files:
			if f.ends_with(".import"):
				continue
			
			#print("Adding file: ", f, " path ", path + "/" + f)
			var f_acc := FileAccess.open(path + "/" + f, FileAccess.READ)
			f_size.y += f_acc.get_length()
			f_size.x += 1
	
	return f_size


## UPDATE NODED IN SPECIFIC PROJECT FOLDER

func update_noded_in_project(proj_path:String):
	var from := "D:/Godot Projects/Testings/test folder"
	var to  := "D:/Godot Projects/Testings/copied folder"
	
	clear_folder_contents(to)
	#print(DirAccess.get_directories_at("D:/Godot Projects/Testings"))
	#if DirAccess.dir_exists_absolute(to):
		#print(OS.execute('rmdir', [to]))

func clear_folder_contents(folder_path:String):
	# TODONEXT
	var sub_folders := DirAccess.get_directories_at(folder_path)
	if sub_folders:
		for folder in sub_folders:
			var s_folder_path := folder_path + "/" + folder
			
			for file in DirAccess.get_files_at(s_folder_path):
				DirAccess.remove_absolute(s_folder_path)
				print("File: ", file, " removed!")
	
	pass










func refresh_old():
	for child in projects_root.get_children():
		projects_root.remove_child(child)
		child.queue_free()
	
	sys_time = Time.get_unix_time_from_system()
	updated_info.clear()
	
	var dir = DirAccess.open(projs_folder)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir() and file_name != "Noded":
				var curr_folder_proj := GovernedProjInfoCollected.new()
				updated_info.append(curr_folder_proj)
				curr_folder_proj.proj_name = file_name
				curr_folder_proj.proj_root = projs_folder + file_name + '/'
				
				## Find SG Else script info
				check_sg_file(curr_folder_proj)
				
				## Find Noded addon info
				check_noded_addon(curr_folder_proj)
			
			file_name = dir.get_next()
	else:
		printerr("An error occurred when trying to access the path.")
	
	match organized:
		1:
			updated_info.sort_custom(compare_sg_edited)
		2:
			updated_info.sort_custom(compare_noded_edited)
	
	for proj in updated_info:
		var n_proj_node = governated_proj_pref.instantiate() as GovernatedProject
		n_proj_node.setup_from_info(proj, self)
		projects_root.add_child(n_proj_node)


func check_sg_file(proj:GovernedProjInfoCollected):
	var sg_else_path : String = proj.proj_root + sg_path
	proj.has_sg = FileAccess.file_exists(sg_else_path)
	
	if proj.has_sg:
		proj.sg_last_access = FileAccess.get_modified_time(sg_else_path)
		proj.sg_time_since_last_access = sys_time - proj.sg_last_access
	else:
		proj.sg_last_access = 9223372036854775807
		proj.sg_time_since_last_access = 9223372036854775807

func check_noded_addon(proj:GovernedProjInfoCollected):
	var noded_addon_path : String = proj.proj_root + noded_path
	proj.has_noded = DirAccess.dir_exists_absolute(noded_addon_path)
	
	if proj.has_noded:
		proj.noded_last_access = FileAccess.get_modified_time(noded_addon_path)
		proj.noded_time_since_last_access = sys_time - proj.noded_last_access
	else:
		proj.noded_last_access = 0
		proj.noded_time_since_last_access = 99999999

func compare_sg_edited(proj_a:GovernedProjInfoCollected, proj_b:GovernedProjInfoCollected) -> bool:
	return proj_a.sg_time_since_last_access < proj_b.sg_time_since_last_access

func compare_noded_edited(proj_a:GovernedProjInfoCollected, proj_b:GovernedProjInfoCollected) -> bool:
	return proj_a.noded_time_since_last_access < proj_b.noded_time_since_last_access


func _on_organize_btn_item_selected(index):
	organized = index
	refresh_projects_info()
	pass # Replace with function body.

func mark_sg_updated_version():
	pass

func update_all_noded_from(proj:GovernedProjInfoCollected):
	var dir = DirAccess.open(projs_folder)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir() and file_name != proj.proj_name:
				var from_path : String = proj.proj_root + sg_path
