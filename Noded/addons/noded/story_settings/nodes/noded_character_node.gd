extends GraphNode
class_name NodedCharacterNode

@onready var name_line_edit = %NameLineEdit
@onready var classif_select = %ClassifSelect
@onready var description_text_edit = %DescriptionTextEdit


func get_data() -> NodedCharacterData:
	var n_cdata := NodedCharacterData.new()
	n_cdata.name = name_line_edit.text
	n_cdata.description = description_text_edit.text
	n_cdata.classif_index = classif_select.get_selected_id()
	n_cdata.classif_name = classif_select.get_item_text(n_cdata.classif_index)
	return n_cdata


func _on_name_gen_btn_pressed():
	var name_gen := NodedNameGenerator.new()
	
	match classif_select.get_selected_id():
		0: name_line_edit.text = name_gen.get_first_name()
		1: name_line_edit.text = name_gen.generate_warriors_name()
		2: name_line_edit.text = name_gen.generate_mystic_name()
		3: name_line_edit.text = name_gen.generate_coastal_name()
		4: name_line_edit.text = name_gen.generate_traders_name()
		5: name_line_edit.text = name_gen.generate_planters_name()
