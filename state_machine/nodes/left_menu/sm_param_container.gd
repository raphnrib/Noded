## Container for the parameters in a State Machine context

extends PanelContainer
class_name SMParamSpaceContainer

@export var param_section : SMParamsSpaceSection
@export var state_machine : StateMachine
@export var param : SMParamSpace
@export var grid : GraphEdit


var condition_node_pref = preload("res://state_machine/nodes/grid/sm_condition_node.tscn")


func setup_from_param(sm_param:SMParamSpace, parent:SMParamsSpaceSection, sm_grid:GraphEdit):
	param = sm_param
	param_section = parent
	grid = sm_grid
	
	%LineEdit.text = param.name
	if param.type == SMParamSpace.tp.FLOAT:
		%Label.text = 'float'
	elif param.type == SMParamSpace.tp.INT:
		%Label.text = 'int'
	elif param.type == SMParamSpace.tp.BOOL:
		%Label.text = 'bool'
	elif param.type == SMParamSpace.tp.TRIGGER:
		%Label.text = 'trigg'
	elif param.type == SMParamSpace.tp.TIMER:
		%Label.text = 'timer'


func _on_line_edit_text_changed(new_text):
	param.name = new_text
	param_section.section_info_changed.emit()
	param.space_info_changed.emit()
	%LineEdit.release_focus()


func _on_add_to_grid_button_pressed():
	var condition_node = condition_node_pref.instantiate() as SMConditionNode
	var condition = state_machine.conditions.add_new_item()
	
	pass # Replace with function body.
