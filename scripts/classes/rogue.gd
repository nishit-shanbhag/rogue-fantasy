extends "res://scripts/classes/player.gd"

func _ready():
	super._ready()
	stats.increase_stat_base_value("attack_power", 10) # Rogue hits harder
	stats.increase_stat_base_value("crit_chance", 0.1) # Rogue has higher crit chance
	print("Rogue Class Loaded")

func primary_attack(): # Stab
	print("Rogue Stab!")
	# Implement stab attack logic here

func secondary_attack(): # Returning Dagger
	print("Rogue Returning Dagger!")
	# Implement returning dagger attack logic here

func special_ability(): # Dash
	print("Rogue Dash!")
	# Implement dash logic here
