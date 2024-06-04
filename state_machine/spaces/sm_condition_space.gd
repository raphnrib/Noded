## This class holds info about what states should be linked

extends Space
class_name SMConditionSpace

@export var from_state : int
@export var linked_to : SMParamSpace

@export var is_timer : bool = false
@export var to_state : int = -1 ## Next State ID
