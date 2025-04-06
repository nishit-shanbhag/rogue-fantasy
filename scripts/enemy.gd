extends CharacterBody2D

@export var move_speed = 100.0
@export var attack_range = 50.0
@export var attack_damage = 5.0
@export var enemy_stats_resource : Resource = preload("res://scripts/stats_container.gd").new() # Use same stats container for now

var player # Reference to the player node
var stats # Enemy stats instance

func _ready():
	stats = enemy_stats_resource
	stats.stats.health.base_value = 50 # Example enemy health
	stats.stats.attack_power.base_value = attack_damage # Use exported damage
	stats.calculate_stat_values() # Ensure current values are calculated

func _physics_process(delta):
	if player == null: # Find player if not set yet
		player = get_tree().get_first_node_in_group("player")
		if player == null:
			return # Player not found, can't do anything

	var direction_to_player = (player.global_position - global_position).normalized()
	velocity = direction_to_player * move_speed

	if global_position.distance_to(player.global_position) <= attack_range:
		attack_player()
		velocity = Vector2.ZERO # Stop moving when attacking

	self.velocity = velocity # Set velocity for move_and_slide
	move_and_slide()

func attack_player():
	print("Enemy Attack!")
	var player_health_component = player.get_node("HealthComponent") # Assuming HealthComponent is a child of Player
	if player_health_component:
		var damage = stats.get_stat_value("attack_power")
		player_health_component.take_damage(damage)
		print("Dealt", damage, "damage to player.")
	else:
		printerr("Player HealthComponent not found!")
