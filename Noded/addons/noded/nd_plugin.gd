@tool
extends EditorPlugin


const MainPanel = preload("res://addons/noded/noded.tscn")

var main_panel_instance


func _enter_tree():
	main_panel_instance = MainPanel.instantiate() as NodedMain
	EditorInterface.get_editor_main_screen().add_child(main_panel_instance)
	
	main_panel_instance.setup_ui()
	_make_visible(false)


func _exit_tree():
	if main_panel_instance:
		main_panel_instance.queue_free()


func _has_main_screen():
	return true


func _make_visible(visible):
	if main_panel_instance:
		main_panel_instance.visible = visible


func _get_plugin_name():
	return "Noded"


func _get_plugin_icon():
	# Must return some kind of Texture for the icon.
	return EditorInterface.get_editor_theme().get_icon("Node", "EditorIcons")
