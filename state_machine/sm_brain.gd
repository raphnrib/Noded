## Processes the State Machine from inside the tree
extends Node
class_name SMBrain

class RuntimeParam:
	var id : int
	var value

class RuntimeNumCheck:
	var mode : int # 0=less, 1=equal, 2=larger
	var check_value
	
	func check(param_val:RuntimeParam) -> bool:
		if mode == 0:
			return param_val < check_value
		elif mode == 1:
			return param_val == check_value
		else:
			return param_val > check_value


class RuntimeTransition:
	func check() -> bool:
		##
		return false

#class RuntimeSingleTransition extends RuntimeTransition:
	#var param_id : int
#
#class RuntimeCombinedTransition extends RuntimeTransition:
	#var transitions : Array[RuntimeTransition]

class StateRuntime:
	var id : int
	var transitions : Array[RuntimeTransition]


var parameters : Array[RuntimeParam] = [
	
]

var states : Array[StateRuntime] = [
	
]

## Function to be placed in the StateMachine Designer
func initialize_states():
	
	pass
