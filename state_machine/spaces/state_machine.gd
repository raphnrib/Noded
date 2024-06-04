extends Space
class_name StateMachine

## The parameters are set so the Machine can know the type
@export var params : SMParamsSpaceSection = SMParamsSpaceSection.new()
## The states will hold info about what is happening at the time
@export var states : StateSpaceSection = StateSpaceSection.new()
## Conditions that compare the current params state with the original and determines if a condition is met
@export var conditions : SMConditionSpaceSection ## The transitions informations
