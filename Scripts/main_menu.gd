extends Control

@onready var start_button: Button = $HBoxContainer/VBoxContainer/start_button
@onready var exit_button: Button = $HBoxContainer/VBoxContainer/exit_button
@export var start_level = preload("res://scenes/game.tscn") as PackedScene

func _ready():
	start_button.button_down.connect(on_button_down)
	exit_button.button_down.connect(on_exit_pressed)
	
func on_button_down() -> void:
	get_tree().change_scene_to_packed(start_level)
	
func on_exit_pressed() -> void:
	get_tree().quit()
