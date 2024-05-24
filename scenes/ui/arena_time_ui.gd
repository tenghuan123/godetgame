extends CanvasLayer

@export var arena_time_manager: Node

@onready var label = $%Label as Label

func _process(_delta):
	if arena_time_manager == null:
		return
	
	var timer = arena_time_manager.get_time_elapsed()

	label.text = format_seconds_to_string(timer)


func format_seconds_to_string(seconds: float):
	var minutes= floor(seconds / 60)
	var remaining_seconds = floor(seconds - minutes * 60)

	return str(minutes) + ':'+ str("%02d" % remaining_seconds)
