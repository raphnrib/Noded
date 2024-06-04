## Spaces/Nodes Information Editing
extends Node

var edited_data : Dictionary

var cancel_canvas : Button
var var_edit : VarEditPanel

var class_container_pref = preload("res://Trees/class_declaration_node.tscn")
var vars_container_pref = preload("res://class_regions/variables/var_container.tscn")
var enum_container_pref = preload("res://class_regions/enums/enum_container.tscn")
var enum_item_display_pref = preload("res://class_regions/enums/enum_item_display.tscn")
var method_link_pref = preload("res://class_regions/methods/method_link_container.tscn")
var state_machine_grid = preload("res://state_machine/nodes/state_machine_node.tscn")

var editing_section_pref = preload("res://editing_properties/editing_panel_conainer.tscn")
var editing_item_pref = preload("res://editing_properties/editing_item.tscn")

signal on_confirmed
signal on_canceled


func _ready():
	cancel_canvas = load("res://interface_edit/cancel_canvas.tscn").instantiate() as Button
	cancel_canvas.visible = false
	cancel_canvas.pressed.connect(cancel_editing)
	get_node('/root').add_child.call_deferred(cancel_canvas)
	
	var_edit = load("res://interface_edit/var_edit_panel.tscn").instantiate() as VarEditPanel
	var_edit.visible = false
	cancel_canvas.add_child.call_deferred(var_edit)


## Dictionary
## 'position' = vec2 position
## 'type' = int 'Info.VarType'
## 'value'
func call_var_edit_window(data:Dictionary, arg_mode:bool):
	var_edit.position = data['position']
	var_edit.set_data(data)
	var_edit.set_edit_mode(arg_mode)
	
	cancel_canvas.visible = true
	var_edit.visible = true


func confirm_edit():
	on_confirmed.emit()
	edited_data.clear()
	
	var_edit.visible = false
	cancel_canvas.visible = false

func cancel_editing():
	var_edit.visible = false
	cancel_canvas.visible = false
