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


func _on_coyote_timer_timeout():
	coyote = false

func _ready() -> void:
	$CoyoteTimer.wait_time = coyote_frames / 60.0

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		Engine.time_scale = 1
		get_tree().reload_current_scene()
		
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote):
		velocity.y = JUMP_VELOCITY
		var jumping = true
		coyote = false

	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite
	if direction > 0:
			animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	var was_on_floor = is_on_floor()
	move_and_slide()
	
	if !is_on_floor() and was_on_floor and velocity.y>=0:
		coyote = true
		$CoyoteTimer.start()
		
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	# Apply movement
	if direction :
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
