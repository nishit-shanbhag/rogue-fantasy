class_name Stat
extends Resource # Resources are data containers that can be saved and reused

@export var name : String = "Stat Name"
@export var base_value : float = 1.0
var current_value : float # Calculated value based on modifiers

func _init(stat_name = "Stat Name", base = 1.0):
	name = stat_name
	base_value = base
	current_value = base_value

func calculate_value():
	current_value = base_value # In the future, add logic for modifiers here
	return current_value
