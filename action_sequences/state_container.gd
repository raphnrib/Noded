extends PanelContainer
class_name StateContainer

@export var from_parent : StateData
@export var from_act : Act

var act_pref = preload("res://action_sequences/state_container.tscn")


func setup_action(act:Act, parent:StateData):
	from_act = act
	from_parent = parent

func _on_create_action_button_pressed():
	var new_action = Act.new()
	from_act.state.actions.append(new_action)
	
	var n_display = create_action_display()
	n_display.setup_action(new_action, from_parent)

func create_action_display() -> StateContainer:
	var n_scontainer = act_pref.instantiate() as StateContainer
	%ActsRoot.add_child(n_scontainer)
	%CreateActionButton.move_to_front()
	return n_scontainer


func _on_delete_branch_button_pressed():
	var win = ConfirmationDialog.new()
	get_node('/root').add_child(win)
	
	win.visible = true
	win.dialog_text = "Are you sure you want to delete this branch and all its children?"
	win.dialog_autowrap = true
	win.position = get_global_mouse_position()
	
	win.confirmed.connect(delete_confirm.bind(true, win))
	win.canceled.connect(delete_confirm.bind(false, win))

func delete_confirm(confirm:bool, win:ConfirmationDialog):
	win.queue_free()
	if confirm:
		from_parent.actions.erase(from_act)
		queue_free()
