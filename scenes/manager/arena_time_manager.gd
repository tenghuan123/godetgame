extends Node

@export var end_screen_scene: PackedScene

@onready var timer = $Timer


func _ready():
	timer.timeout.connect(on_timer_timeout)

func get_time_elapsed(): 
	if timer == null:
		return
	# 这里大概的意思就是总时间减去定时器剩余的时间，就等于过去了多久时间
	return timer.wait_time - timer.time_left


func on_timer_timeout():
	var victory_screen_instance = end_screen_scene.instantiate()
	print(on_timer_timeout)
	add_child(victory_screen_instance)
