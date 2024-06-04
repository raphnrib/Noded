extends PanelContainer
class_name FuncArgEdit

var controller : FuncStart
var slot_id : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var values = Info.VarType.keys()
	for v in values:
		%Typeselect.add_item(v)


func _on_typeselect_item_selected(index):
	%DefaultValEdit.visible = index != 0

func get_data():
	return { "name":%NameEdit.text, "tp":%Typeselect.selected, "default":%DefaultValEdit.text }

func set_data(values):
	%NameEdit.text = values['name']
	%Typeselect.selected = values["tp"]
	%DefaultValEdit.text = values['default']
