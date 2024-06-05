extends GraphNode
class_name NodedCultureNode

@onready var cult_name_line_edit = %CultNameLineEdit
@onready var culture_tp_select = %CultureTpSelect
@onready var descript_text_edit = %DescriptTextEdit


func get_data() -> NodedCultureData:
	var n_cdata := NodedCultureData.new()
	n_cdata.name = cult_name_line_edit.text
	n_cdata.description = descript_text_edit.text
	n_cdata.classif_index = culture_tp_select.get_selected_id()
	n_cdata.classif_name = culture_tp_select.get_item_text(n_cdata.classif_index)
	return n_cdata


func _on_culture_name_gen_btn_pressed():
	var n_gen = NodedNameGenerator.new()
	cult_name_line_edit.text = n_gen.generate_culture_name()
	pass # Replace with function body.


