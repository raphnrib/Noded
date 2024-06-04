extends GraphNode
class_name FuncStart

var arg_tree = preload("res://Trees/arg_edit_container.tscn")


func setup_from_data(args):
	# TODO Create a new argument for each
	for a in args:
		var n_arg = add_new_func_argument()
		n_arg.set_data(a)

func get_data():
	# TODO Return all connected nodes
	pass

func discart_implementation():
	# TODO Notity the node owner that the variable can change its type again
	pass


func _on_add_arg_pressed():
	add_new_func_argument()

# Adding aguments to the function
func add_new_func_argument():
	var arg_container = arg_tree.instantiate() as FuncArgEdit
	add_child(arg_container)
	%AddArg.move_to_front()
	return arg_container

func get_arguments_array():
	var func_args = []
	for arg in get_children():
		if arg is FuncArgEdit:
			func_args.append(arg.get_data())
	return func_args
