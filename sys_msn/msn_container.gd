extends MarginContainer
class_name MsnContainer

var enter_time : float = 0.5
var permanence : float = 2.0
var exit_time : float = 0.5

var text : String:
	set(val):
		$Label.text = val

func play():
	modulate.a = 0.0
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1, enter_time)
	tween.tween_callback(permanence_timer)

func permanence_timer():
	var timer = get_tree().create_timer(permanence)
	timer.timeout.connect(start_exit)

func start_exit():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0, exit_time)
	tween.tween_callback(excuse_itself)

func excuse_itself():
	queue_free()
