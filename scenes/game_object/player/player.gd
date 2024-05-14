extends CharacterBody2D

const MAX_SPEED = 125
const ACCELERATION_SMOOTHING = 25

var number_colliding_bodies = 0

@onready var damage_interval_timer = $DamageIntervalTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionArea2D.body_entered.connect(on_body_entered)
	$CollisionArea2D.body_exited.connect(on_body_exited)
	damage_interval_timer.timeout.connect(on_damage_interval_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movement = get_movement_player()
	var direction = movement.normalized()
	var targer_velocity = direction * MAX_SPEED
	velocity = velocity.lerp(targer_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	move_and_slide()
	


func get_movement_player():
	var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	return Vector2(x, y)


func on_body_entered(other_body: Node2D):
	number_colliding_bodies += 1
	check_deal_damage()


func on_body_exited(other_body: Node2D):
	number_colliding_bodies -= 1


func check_deal_damage():
	if(number_colliding_bodies == 0 || !damage_interval_timer.is_stopped()):
		return
	
	$HealthComponent.damage(1)
	damage_interval_timer.start()
	print($HealthComponent.current_health)


func  on_damage_interval_timeout():
	check_deal_damage()
