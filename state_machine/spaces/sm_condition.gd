extends Space
class_name SMConditionSpace

enum ModeNum { Less, Equal, More }
enum ModeBool { Is, IsNot }

@export var param_code : int = 0
@export var num_compare : ModeNum
@export var boll_compare : ModeBool
