extends CanvasLayer


@export var arena_time_manager: Node

func _process(delta):
    if arena_time_manager == null:
        return
    
    var timer = arena_time_manager.get_time_elapsed()
