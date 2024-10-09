class_name Player
extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0
var jumping = false
var coyote = false
var coyote_frames = 6
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var start_level = preload("res://scenes/game.tscn") as PackedScene
@onready var kill_zone: Area2D = $"../KillZone"
@onready var collision_shape_2d: CollisionShape2D = $"../KillZone/CollisionShape2D"
@onready var coyote_timer: Timer = $CoyoteTimer
var last_direction = 0  # Track the last direction


func _on_coyote_timer_timeout():
	coyote = false

func _ready() -> void:
	coyote_timer.wait_time = 0.15

func _physics_process(delta:float) -> void:
	if Input.is_action_just_pressed("restart"):
		Engine.time_scale = 1
		get_tree().reload_current_scene()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote):
		velocity.y = JUMP_VELOCITY
		coyote = false
		

	# Check input direction: -1 for left, 0 for none, 1 for right
	if Input.is_action_pressed("move_right"):
		last_direction = 1
	elif Input.is_action_pressed("move_left"):
		last_direction = -1
	else: 
		last_direction = 0

	# Set velocity based on the last direction
	velocity.x = last_direction * SPEED

	# Flip the Sprite
	animated_sprite.flip_h = last_direction < 0

	var was_on_floor = is_on_floor()
	move_and_slide()

	if !is_on_floor() and was_on_floor and velocity.y >= 0:
		coyote = true
		coyote_timer.start()

	# Play animations
	if is_on_floor():
		if last_direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
