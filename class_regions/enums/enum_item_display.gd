extends PanelContainer
class_name  EnumItemDisplay

var enum_container : EnumContainer

var text : String:
	get:
		return %Label.text
	set(val):
		%Label.text = val


func _on_exclude_item_pressed():
	enum_container.remove_item(text)
	queue_free()
