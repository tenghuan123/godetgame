extends CharacterBody2D

const MAX_SPEED = 40

@onready var healthComponet: HealthComponent = $HealthComponent 

# Called when the node enters the scene tree for the first time.
func _ready():
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    var direction = get_player_current()
    velocity = direction * MAX_SPEED
    move_and_slide()


func get_player_current():
    var player_node = get_tree().get_first_node_in_group("player") as Node2D
    if player_node != null:
        return (player_node.global_position - global_position).normalized()
    return Vector2.ZERO
