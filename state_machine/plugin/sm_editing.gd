@tool
extends Control
class_name SMEditing

var editing : StateMachine
var sm_plugin : EditorPlugin

var fl_param_container = preload("res://state_machine/plugin/param_containers/float_param_conteiner.tscn")
var int_param_container = preload("res://state_machine/plugin/param_containers/int_param_conteiner.tscn")
var bool_param_container = preload("res://state_machine/plugin/param_containers/bool_param_conteiner.tscn")
var trigg_param_container = preload("res://state_machine/plugin/param_containers/trigger_param_conteiner.tscn")


func _ready():
	var picker = EditorResourcePicker.new()
	picker.base_type = "StateMachine"
	%ResourcePickRoot.add_child(picker)

func add_parameter(tp:int):
	match tp:
		0:
			var n_param = SMFloatParam.new()
			
			editing.parameters.append(n_param)
			var ui = fl_param_container.instantiate() as FloatParamContainer
			ui.param = n_param
			%ParametersRoot.add_child(ui)
		1:
			var n_param = SMIntParam.new()
			
			editing.parameters.append(n_param)
			var ui = fl_param_container.instantiate() as IntParamContainer
			ui.param = n_param
			%ParametersRoot.add_child(ui)
		0:
			var n_param = SMBoolParam.new()
			
			editing.parameters.append(n_param)
			var ui = fl_param_container.instantiate() as BoolParamContainer
			ui.param = n_param
			%ParametersRoot.add_child(ui)
		0:
			var n_param = SMTriggerParam.new()
			
			editing.parameters.append(n_param)
			var ui = fl_param_container.instantiate() as TriggParamContainer
			ui.param = n_param
			%ParametersRoot.add_child(ui)


func _on_open_state_machine_button_pressed():
	pass

func object_selected(file):
	%PathLabel.text = file
	%ParametersPanel.visible = true
