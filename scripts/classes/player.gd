extends CharacterBody2D

@export var move_speed = 200.0
@export var player_stats_resource : Resource = preload("res://scripts/stats_container.gd").new() # Preload and instance StatsContainer


var stats # Instance of StatsContainer will be here

func _ready():
	stats = player_stats_resource # Initialize stats

func _physics_process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"): # Use custom actions
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	move_speed = stats.get_stat_value("movement_speed") # Update move_speed from stats
	velocity = velocity.normalized() * move_speed
	move_and_slide()
	
func _input(event): # Use _input for handling input events like mouse clicks
	if event.is_action_pressed("primary_attack"):
		primary_attack()
	if event.is_action_pressed("secondary_attack"):
		secondary_attack()
	if event.is_action_pressed("special_ability"):
		special_ability()

func primary_attack(): # Slash
	print("Warrior Slash!")
	var attack_damage = stats.get_stat_value("attack_power")

	# Basic collision check for enemies (very simplified for now)
	var space_state = get_world_2d().get_direct_space_state()
	var query_params = PhysicsShapeQueryParameters2D.new()
	query_params.shape = CircleShape2D.new() # Use a circle for slash area
	query_params.shape.radius = 60 # Adjust radius as needed
	query_params.collide_with_bodies = true
	query_params.collide_with_areas = false # Assuming enemies are bodies
	query_params.transform = global_transform
	query_params.exclude = [self] # Don't hit yourself

	var result = space_state.intersect_shape(query_params)
	for hit in result:
		if hit.collider is CharacterBody2D and hit.collider.is_in_group("enemy"): # Assuming enemies are in "enemy" group (see next step)
			var enemy_health_component = hit.collider.get_node("HealthComponent")
			if enemy_health_component:
				enemy_health_component.take_damage(attack_damage)
				print("Dealt", attack_damage, "damage to enemy.")

func secondary_attack():
	print("Base Player Secondary Attack")

func special_ability():
	print("Base Player Special Ability")

func get_stat(stat_name):
	return stats.get_stat_value(stat_name)
