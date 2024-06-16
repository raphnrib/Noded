@tool
extends EditorPlugin


const MainPanel = preload("res://addons/gov_plugin/govenor.tscn")

var main_panel_instance


func _enter_tree():
	main_panel_instance = MainPanel.instantiate() as Govenor
	EditorInterface.get_editor_main_screen().add_child(main_panel_instance)
	
	main_panel_instance.configure_govenor()
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
	return "Govenor"


func _get_plugin_icon():
	# Must return some kind of Texture for the icon.
	return load("res://addons/gov_plugin/abstract-050_viscious-speed.png")
