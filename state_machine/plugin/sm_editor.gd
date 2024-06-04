@tool
extends EditorPlugin

const control_pref = preload("res://state_machine/plugin/sm_editing.tscn")

var dock_scene : Control

func _enter_tree():
	dock_scene = control_pref.instantiate() as SMEditing
	add_control_to_dock(DOCK_SLOT_RIGHT_BL, dock_scene)
	setup_pluging.call_deferred()

func setup_pluging():
	dock_scene.sm_plugin = self


func _exit_tree():
	remove_control_from_docks(dock_scene)
	dock_scene.queue_free
	pass
