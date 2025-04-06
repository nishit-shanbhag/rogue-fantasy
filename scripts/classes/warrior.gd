extends "res://scripts/classes/player.gd" # Adjust path if needed

@onready var animated_sprite = $Sprite2D # Assuming your player sprite is directly under Player node

var can_attack = true
var attack_cooldown = 1 # seconds

func _ready():
	super._ready()
	# Class-specific stats modifications or abilities
	stats.increase_stat_base_value("health", 20) # Warrior starts with more health
	stats.increase_stat_base_value("attack_power", 5)
	print("Warrior Class Loaded")

func primary_attack(): # Slash
	if not can_attack:
		return # Cooldown active, can't attack

	can_attack = false
	print("Warrior Slash!")
	var attack_damage = stats.get_stat_value("attack_power")

	# Instantiate Slash Effect
	var slash_effect_instance = load("res://scenes/slash_effect.tscn").instantiate()
	# Make SlashEffect a CHILD of the Player temporarily
	add_child(slash_effect_instance) # Add as child of Player, NOT get_parent()

	# Position Slash Effect RELATIVE to the Player (adjust offset as needed)
	slash_effect_instance.position = Vector2(120, 10) # Example: slightly to the right
	#slash_effect_instance.rotation = animated_sprite.rotation # Match player rotationd

	slash_effect_instance.play("default") # Play the animation

	# Connect animation_finished signal to queue_free function
	slash_effect_instance.animation_finished.connect(_on_slash_animation_finished.bind(slash_effect_instance)) # Connect signal

	# Collision check (same as before) ...
	var space_state = get_world_2d().get_direct_space_state()
	var query_params = PhysicsShapeQueryParameters2D.new()
	query_params.shape = CircleShape2D.new()
	query_params.shape.radius = 60
	query_params.collide_with_bodies = true
	query_params.collide_with_areas = false
	query_params.transform = global_transform
	query_params.exclude = [self]

	var result = space_state.intersect_shape(query_params)
	for hit in result:
		if hit.collider is CharacterBody2D and hit.collider.is_in_group("enemy"):
			var enemy_health_component = hit.collider.get_node("HealthComponent")
			if enemy_health_component:
				enemy_health_component.take_damage(attack_damage)
				print("Dealt", attack_damage, "damage to enemy.")

	# Cooldown Timer
	var timer = get_tree().create_timer(attack_cooldown)
	await timer.timeout
	can_attack = true

func _on_slash_animation_finished(slash_effect_node):
	slash_effect_node.queue_free() # Remove SlashEffect node after animation finishes
