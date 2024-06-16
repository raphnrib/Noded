@tool
extends PanelContainer
class_name SlimProjContainer

@onready var label = $MarginContainer/VBoxContainer/Label
@onready var tot_files = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/TotFiles
@onready var tot_size = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/TotSize
@onready var button = $MarginContainer/VBoxContainer/HBoxContainer/Button
@onready var texture_rect = $MarginContainer/VBoxContainer/HBoxContainer/TextureRect

var gov_main : Govenor
var proj_addon_folder : String


func setup_from(label:String, addon_folder:String, files:int, f_size:int, differs:bool, gov:Govenor):
	self.label.text = label
	proj_addon_folder = addon_folder
	gov_main = gov
	
	tot_files.text = str(files)
	tot_size.text = str(f_size)
	
	button.visible = differs
	texture_rect.visible = !differs
	pass



func _on_button_pressed():
	gov_main.update_noded_in_project(proj_addon_folder)
	pass # Replace with function body.
