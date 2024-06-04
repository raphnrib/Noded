extends GraphElement

@export var start_action : ActionSequence

var act_pref = preload("res://action_sequences/state_container.tscn")


func setup_from_action_sequence(act_seq:ActionSequence):
	start_action = act_seq

func _on_create_action_button_pressed():
	var new_action = Act.new()
	start_action.from_state.actions.append(new_action)
	
	var n_display = create_action_display() as StateContainer
	n_display.setup_action(new_action, start_action.from_state)

func create_action_display() -> StateContainer:
	var n_scontainer = act_pref.instantiate() as StateContainer
	%ActsRoot.add_child(n_scontainer)
	%CreateActionButton.move_to_front()
	return n_scontainer


func _on_position_offset_changed():
	start_action.node_position = position_offset


func _on_delete_action_seq_button_pressed():
	var win = ConfirmationDialog.new()
	get_node('/root').add_child(win)
	
	win.visible = true
	win.dialog_text = "Are you sure you want to delete this Action Sequence and all its children?"
	win.dialog_autowrap = true
	win.position = get_global_mouse_position()
	
	win.confirmed.connect(delete_confirm.bind(true, win))
	win.canceled.connect(delete_confirm.bind(false, win))

func delete_confirm(confirm:bool, win:ConfirmationDialog):
	win.queue_free()
	if confirm:
		SS.global.act_sequences.erase(start_action)
		queue_free()
