extends PanelContainer
class_name SMStateSpaceContainer

var state : StateSpace
var parent : StateMachine


func setup_from_state_spate(s_space:StateSpace, state_machine:StateMachine):
	state = s_space
	parent = state_machine
	%NameEdit.text = state.name

func refresh_display_info():
	%NameEdit.text = state.name
	%TriggerAnimButton.button_pressed = state.trigger_animation
	%AnimOption.visible = state.trigger_animation
	%InfoLabel.visible = !state.use_anim_name
	%AnimNameEdit.visible = state.use_anim_name
	%UseAnimButton.button_pressed = state.use_anim_name

func _on_name_edit(new_text):
	new_text = parent.states.check_unique_name(new_text)
	state.name = new_text
	%NameEdit.release_focus()
	state.space_info_changed.emit()

func _on_trigger_anim_button_toggled(toggled_on):
	state.trigger_animation = toggled_on
	refresh_display_info()

func _on_use_anim_button_toggled(toggled_on):
	state.use_anim_name = toggled_on
	refresh_display_info()
