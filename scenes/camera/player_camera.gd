extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = acquire_target()
	global_position = global_position.lerp(direction, 1 - exp( - delta * 100))


func acquire_target(): 
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	
	if player_node != null:
		return player_node.global_position
		
	return Vector2.ZERO
