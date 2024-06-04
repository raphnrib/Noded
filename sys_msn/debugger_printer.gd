extends Node

enum Mode { NORMAL, WARNING, ERROR }

var local_container : MessagesDisplay

var msn_pref = preload("res://sys_msn/msn_container.tscn")


func custom_msn(message, color:Color=Color('dfe6e9'), perm:float=2.0, time_in=0.5, time_out=0.5):
	if local_container == null:
		printerr("No local messages container was setup! Place a 'messages_display' in the scene tree")
		return
	
	var to_print = get_string(message)
	var n_msn = msn_pref.instantiate() as MsnContainer
	
	n_msn.text = to_print
	n_msn.modulate = color
	n_msn.enter_time = time_in
	n_msn.permanence = perm
	n_msn.exit_time = time_out
	
	local_container.messages_display.add_child(n_msn)
	n_msn.play()

func msn(message, mode:Mode=Mode.NORMAL):
	if local_container == null:
		printerr("No local messages container was setup! Place a 'messages_display' in the scene tree")
		return
	
	var to_print = get_string(message)
	var n_msn = msn_pref.instantiate() as MsnContainer
	n_msn.text = to_print
	
	if mode == Mode.ERROR:
		n_msn.modulate = Color('ff7675')
	elif  mode == Mode.WARNING:
		n_msn.modulate = Color('ffeaa7')
	
	local_container.messages_display.add_child(n_msn)
	n_msn.play()

func get_string(message) -> String:
	if message is Array and message.any(is_string):
		var complete_str = ''
		for c in message:
			complete_str += str(c)
		return complete_str
	else:
		return str(message)

func is_string(val):
	return val is String
