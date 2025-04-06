extends "res://scripts/classes/player.gd"

func _ready():
	super._ready()
	stats.increase_stat_base_value("movement_speed", 30) # Archer is faster
	stats.increase_stat_base_value("attack_speed", 0.2) # Archers attack faster (lower value is faster)
	print("Archer Class Loaded")

func primary_attack(): # Shoot
	print("Archer Shoot!")
	# Implement shoot attack logic here

func secondary_attack(): # Exploding Arrow
	print("Archer Exploding Arrow!")
	# Implement exploding arrow attack logic here

func special_ability(): # Backstep
	print("Archer Backstep!")
	# Implement backstep logic here
