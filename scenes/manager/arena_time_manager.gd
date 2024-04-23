extends Node

@onready var timer = $Timer

func get_time_elapsed(): 
    if timer == null:
        return
    # 这里大概的意思就是总时间减去定时器剩余的时间，就等于过去了多久时间
    return timer.wait_time - timer.time_left