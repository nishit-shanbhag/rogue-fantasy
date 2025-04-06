extends Node2D

var player_instance # Will hold the instantiated player

func _ready():
	print("Press 1 for Warrior, 2 for Archer, 3 for Rogue, 4 for Mage")

func _process(_delta): # _delta is used to indicate it's not used in the function, more conventional in Godot 4
	if Input.is_key_pressed(KEY_1):
		load_class("res://scripts/classes/warrior.gd")
	elif Input.is_key_pressed(KEY_2):
		load_class("res://scripts/classes/archer.gd")
	elif Input.is_key_pressed(KEY_3):
		load_class("res://scripts/classes/rogue.gd")
	elif Input.is_key_pressed(KEY_4):
		load_class("res://scripts/classes/mage.gd")

func load_class(class_script_path):
	if player_instance: # Remove previous player if exists
		player_instance.queue_free() # Safely remove from scene tree
	var class_script = load(class_script_path)
	player_instance = class_script.new()
	player_instance.position = Vector2(100, 100) # Set initial position
	add_child(player_instance) # Add player to the scene
