extends CharacterBody2D

const MAX_SPEED = 125
const ACCELERATION_SMOOTHING = 25

var number_colliding_bodies = 0

@onready var damage_interval_timer = $DamageIntervalTimer
@onready var health_component = $HealthComponent
@onready var health_bar = $HealthBar
@onready var abilities = $Abilities
@onready var animation_player = $AnimationPlayer
@onready var visuals = $Visuals


# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionArea2D.body_entered.connect(on_body_entered)
	$CollisionArea2D.body_exited.connect(on_body_exited)
	damage_interval_timer.timeout.connect(on_damage_interval_timeout)
	health_component.current_health_change.connect(on_current_health_change)
	update_health_display()
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movement = get_movement_player() as Vector2
	var direction = movement.normalized()
	var targer_velocity = direction * MAX_SPEED

	velocity = velocity.lerp(targer_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))

	move_and_slide()

	if(movement.x != 0 || movement.y != 0):
		animation_player.play("walk")
	else: 
		animation_player.play("RESET")

	var move_sign = sign(movement.x)
	if(move_sign == 0):
		return
	else:
		visuals.scale = Vector2(move_sign, 1)
	

func get_movement_player():
	var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	return Vector2(x, y)


func check_deal_damage():
	if(number_colliding_bodies == 0 || !damage_interval_timer.is_stopped()):
		return
	
	health_component.damage(1)
	damage_interval_timer.start()


func update_health_display():
	health_bar.value = health_component.get_health_percent()


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if(not upgrade is Ability):
		return

	var upgrade_ability_sence  = upgrade.ability_controlleer_scene as PackedScene
	var upgrade_ability_sence_instance = upgrade_ability_sence.instantiate()
	abilities.add_child(upgrade_ability_sence_instance)


func on_damage_interval_timeout():
	check_deal_damage()


func on_body_entered(other_body: Node2D):
	number_colliding_bodies += 1
	check_deal_damage()


func on_body_exited(other_body: Node2D):
	number_colliding_bodies -= 1


func  on_current_health_change():
	update_health_display()
