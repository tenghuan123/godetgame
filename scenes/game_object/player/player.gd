extends CharacterBody2D

@onready var damage_interval_timer = $DamageIntervalTimer
@onready var health_component = $HealthComponent
@onready var health_bar = $HealthBar
@onready var abilities = $Abilities
@onready var animation_player = $AnimationPlayer
@onready var visuals = $Visuals
@onready var velocity_component = $VelocityComponent


var number_colliding_bodies = 0
var basic_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	basic_speed = velocity_component.max_speed
	
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
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(self)

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
	if(upgrade is Ability):
		var upgrade_ability_sence  = upgrade.ability_controlleer_scene as PackedScene
		var upgrade_ability_sence_instance = upgrade_ability_sence.instantiate()
		abilities.add_child(upgrade_ability_sence_instance)
	
	if(upgrade.id == 'player_rate'):
		velocity_component.max_speed = basic_speed * (1 + current_upgrades["player_rate"]["quantity"] * .1)
	


func on_damage_interval_timeout():
	check_deal_damage()


func on_body_entered(other_body: Node2D):
	number_colliding_bodies += 1
	check_deal_damage()


func on_body_exited(other_body: Node2D):
	number_colliding_bodies -= 1


func  on_current_health_change():
	update_health_display()
