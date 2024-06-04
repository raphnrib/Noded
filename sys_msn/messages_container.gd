extends PanelContainer
class_name MessagesDisplay

@onready var messages_display = %MessagesDisplay

func _ready():
	MSN.local_container = self
