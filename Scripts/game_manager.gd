extends Node

var score = 0
@onready var end_label: Label = $"End Label"
@onready var label: Label = $"../Player/Camera2D/Label"
var time = 0.0
var stopped = false
@onready var timer: Label = $"../Player/Camera2D/Timer"

func _process(delta):
	update_stopwatch_label()
	if stopped:
		return
	time += delta

func update_stopwatch_label():
	timer.text = time_to_string()

func reset():
	time = 0.0
	
func time_to_string() -> String:
	var msec = fmod(time, 1) * 100
	var sec = fmod(time, 60)
	var min = time / 60
	var format_string = "%02d : %02d : %02d"
	var actual_string = format_string % [min, sec, msec]
	return actual_string

func add_point():
	score += 1
	label.text = str(score) + "/18"
	
func stop_stopwatch():
	stopped = true
	end_label.text = "                    Congrats! \n You Finished in " + timer.text + " Seconds!"
	timer.text = end_label.text
	
