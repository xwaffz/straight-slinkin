extends Area2D

@onready var game_manager: Node = %"Game Manager"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
	

func _on_body_entered(_body: Node2D) -> void:
	print("im a coin")
	game_manager.stop_stopwatch()
	queue_free()
