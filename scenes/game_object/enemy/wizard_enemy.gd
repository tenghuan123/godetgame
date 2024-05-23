extends CharacterBody2D

@onready var visuals = $Visuals
@onready var velocity_component = $VelocityComponent

var is_moving = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    if(is_moving):
        velocity_component.accelerate_to_player()
    else:
        velocity_component.decelerate()

    velocity_component.move(self)

    var move_sign = sign(velocity.x)
    if move_sign != 0:
        visuals.scale = Vector2(move_sign, 1)


func get_player_current():
    var player_node = get_tree().get_first_node_in_group("player") as Node2D
    if player_node != null:
        return (player_node.global_position - global_position).normalized()
    return Vector2.ZERO


func set_is_moving(moving: bool):
    is_moving = moving