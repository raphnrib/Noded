@tool
extends GraphNode
class_name NodedEntryNode

var data : NodedEntryData

var name_line_edit : LineEdit # = %NameLineEdit
var tp_select : OptionButton #= %TpSelect
var descript_text_edit : TextEdit #= %DescriptTextEdit


func get_data() -> NodedEntryData:
	var n_cdata := NodedEntryData.new()
	
	n_cdata.name = name_line_edit.text
	n_cdata.description = descript_text_edit.text
	n_cdata.classif_index = tp_select.get_selected_id()
	n_cdata.classif_name = tp_select.get_item_text(n_cdata.classif_index)
	
	n_cdata.node_position = position_offset
	n_cdata.node_size = size
	
	return n_cdata

func setup_from_data(n_data:NodedEntryData, skip_position:bool):
	data = n_data
	
	var v_box := get_titlebar_hbox()
	var label := v_box.get_child(0) as Label
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	
	title = data.type
	name = data.node_name
	
	if !skip_position:
		position_offset = data.node_position
		size = data.node_size
	
	name_line_edit = %NameLineEdit as LineEdit
	tp_select = %TpSelect as OptionButton
	descript_text_edit = %DescriptTextEdit as TextEdit
	
	name_line_edit.text = data.name
	name_line_edit.placeholder_text = "Name goes here!"
	tp_select.selected = data.classif_index
	
	var selected_name : String = name_line_edit.get_selected_text()
	if selected_name != data.classif_name:
		printerr("Discrepancy between the classification saved: ", data.classif_name, " and the current name for this index: ", selected_name)


func _on_new_name_submitted(new_text):
	data.name = new_text
	name_line_edit.release_focus()
	pass # Replace with function body.


func _on_tp_selected(index):
	data.classif_index = index
	data.classif_name = name_line_edit.get_selected_text()
	pass # Replace with function body.


func _on_descript_text_changed():
	data.description = descript_text_edit.text
	pass # Replace with function body.
