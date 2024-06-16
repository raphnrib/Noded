@tool
extends Control
class_name NodedPromo

var data : PromoData

@onready var screen_shots_root = %ScreenShotsRoot
@onready var select_trailer_clip = %SelectTrailerClip
@onready var clear_trailer_clip = %ClearTrailerClip
@onready var trailer_path_label = %TrailerPathLabel


func setup_from(noded_data:NodedData):
	data = noded_data.promo_data
	%ScreeshotsFolderLabel.text = data.screenshots_folder
	
	trailer_path_label.text = data.launch_trailer
	refresh_thumbnails()

func refresh_thumbnails():
	for child in screen_shots_root.get_children():
		screen_shots_root.remove_child(child)
		child.queue_free()
	
	if data.screenshots_folder.is_empty():
		return
	
	if DirAccess.dir_exists_absolute(data.screenshots_folder):
		var files := DirAccess.get_files_at(data.screenshots_folder)
		for f in files:
			var file := f.to_lower()
			if !file.ends_with('.jpg') and !file.ends_with('.png') and !file.ends_with('.jpeg'):
				continue
			var f_path := data.screenshots_folder + '/' + file
			var img := Image.load_from_file(f_path)
			var tex := TextureRect.new()
			
			tex.texture = ImageTexture.create_from_image(img)
			tex.custom_minimum_size = Vector2(196, 196)
			tex.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			tex.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			
			screen_shots_root.add_child(tex)


## SAVE LOAD -----------------------------------------------------------------##

func save() -> Dictionary:
	
	return {}

func load_dictionary(dict:Dictionary, main:NodedMain) -> void:
	
	print(name, " Noded data updated!")
	pass


## SELECTING LAUNCH TRAILER --------------------------------------------------##

func select_trailer_file():
	var win := EditorFileDialog.new()
	
	win.access = EditorFileDialog.ACCESS_FILESYSTEM
	win.file_mode = EditorFileDialog.FILE_MODE_OPEN_FILE
	win.display_mode = EditorFileDialog.DISPLAY_THUMBNAILS
	#win.filters = ['*.png', '*.jpg', '*jpeg']
	win.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_PRIMARY_SCREEN
	win.size = Vector2i(800, 600)
	
	win.file_selected.connect(launch_trailer_picked.bind(win))
	win.canceled.connect(dispose_window.bind(win))
	
	add_child(win)
	win.visible = true

func clear_trailer_path():
	data.launch_trailer = ''
	trailer_path_label.text = ''

func launch_trailer_picked(trailer:String, win:EditorFileDialog):
	data.launch_trailer = trailer
	trailer_path_label.text = trailer
	dispose_window.call_deferred(win)


## SELECTING SCREENSHOTS FOLDER ----------------------------------------------##
func add_screen_shot_folder():
	var win := EditorFileDialog.new()
	
	win.access = EditorFileDialog.ACCESS_FILESYSTEM
	win.file_mode = EditorFileDialog.FILE_MODE_OPEN_DIR
	win.display_mode = EditorFileDialog.DISPLAY_THUMBNAILS
	#win.filters = ['*.png', '*.jpg', '*jpeg']
	win.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_PRIMARY_SCREEN
	win.size = Vector2i(800, 600)
	
	win.dir_selected.connect(screenshot_folder_picked.bind(win))
	win.canceled.connect(dispose_window.bind(win))
	
	add_child(win)
	win.visible = true

func screenshot_folder_picked(folder:String, win:EditorFileDialog):
	data.screenshots_folder = folder
	%ScreeshotsFolderLabel.text = folder
	
	refresh_thumbnails()
	dispose_window.call_deferred(win)


## HELPERS -------------------------------------------------------------------##

func dispose_window(win:EditorFileDialog):
	remove_child(win)
	win.queue_free()
