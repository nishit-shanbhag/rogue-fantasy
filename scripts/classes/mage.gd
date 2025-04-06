extends "res://scripts/classes/player.gd"

func _ready():
	super._ready()
	stats.increase_stat_base_value("spell_power", 15) # Mage has higher spell power
	stats.increase_stat_base_value("cooldown_reduction", 0.1) # Mage has cooldown reduction
	print("Mage Class Loaded")

func primary_attack(): # Magic Bolt
	print("Mage Magic Bolt!")
	# Implement magic bolt attack logic here

func secondary_attack(): # Mana Wave
	print("Mage Mana Wave!")
	# Implement mana wave attack logic here

func special_ability(): # Warp
	print("Mage Warp!")
	# Implement warp logic here
