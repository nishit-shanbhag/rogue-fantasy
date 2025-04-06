class_name HealthComponent
extends Node # Can be a Node, not necessarily a Resource

signal health_changed(current_health, max_health)
signal died

@export var max_health = 100.0
var current_health : float

func _ready():
	current_health = max_health
	emit_signal("health_changed", current_health, max_health)

func take_damage(damage_amount):
	current_health -= damage_amount
	current_health = maxf(current_health, 0) # Ensure health doesn't go below 0
	emit_signal("health_changed", current_health, max_health)

	if current_health <= 0:
		emit_signal("died")
		queue_free() # For now, just remove the entity when it dies

func heal(heal_amount):
	current_health += heal_amount
	current_health = minf(current_health, max_health) # Ensure health doesn't exceed max
	emit_signal("health_changed", current_health, max_health)
