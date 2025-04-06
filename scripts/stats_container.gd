class_name StatsContainer
extends Resource

@export var stats : Dictionary = {}

func _init():
	stats = {
		"health": Stat.new("Health", 100),
		"movement_speed": Stat.new("Movement Speed", 200),
		"evasion": Stat.new("Evasion", 0),
		"attack_speed": Stat.new("Attack Speed", 1.0),
		"attack_power": Stat.new("Attack Power", 10),
		"attack_crit_dmg": Stat.new("Attack Crit Damage", 1.5),
		"spell_power": Stat.new("Spell Power", 10),
		"spell_crit_dmg": Stat.new("Spell Crit Damage", 1.5),
		"crit_chance": Stat.new("Crit Chance", 0.05),
		"cooldown_reduction": Stat.new("Cooldown Reduction", 0)
	}

func get_stat_value(stat_name):
	if stats.has(stat_name):
		return stats[stat_name].calculate_value()
	else:
		printerr("Stat not found:", stat_name)
		return 0

func increase_stat_base_value(stat_name, amount):
	if stats.has(stat_name):
		stats[stat_name].base_value += amount
		stats[stat_name].calculate_value() # Recalculate current value
	else:
		printerr("Stat not found:", stat_name)

func calculate_stat_values():
	for stat_name in stats:
		stats[stat_name].calculate_value()
