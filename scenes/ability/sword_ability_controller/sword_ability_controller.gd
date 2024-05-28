extends Node

@export var sword_ability: PackedScene

const MAX_RANGE = 150
var base_damage = 5
var additional_damage_percent = 1
var base_wait_time

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("Timer")
	base_wait_time = $Timer.wait_time
	$Timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


func on_timer_timeout():
	#我们需要将sword的实例添加到main节点中
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return

	var enemies = get_tree().get_nodes_in_group("enemy")
	# 这里需要计算敌人与角色之间的距离，并且过滤出在攻击范围内的敌人
	enemies = enemies.filter(func (enemy: Node2D): return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2))

	if enemies.size() == 0:
		return
	
	enemies.sort_custom(func (a: Node2D, b: Node2D): return a.global_position.distance_squared_to(player.global_position) < b.global_position.distance_squared_to(player.global_position))
	var sword_instance = sword_ability.instantiate() as SwordAbility

	# 攻击方式不应该被实体层阻挡
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer") as Node2D
	foreground_layer.add_child(sword_instance)
	sword_instance.hitbox_component.damage = base_damage * additional_damage_percent

	sword_instance.global_position = enemies[0].global_position
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU))* 4
	# 我们现在需要一个角度来攻击敌人
	var direction = enemies[0].global_position - player.global_position
	sword_instance.global_rotation = direction.angle()

	


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if(upgrade.id == 'sword_rate'):
		var percent_reduction = current_upgrades["sword_rate"]["quantity"] * .1
		$Timer.wait_time = base_wait_time * (1 - percent_reduction)
		$Timer.start()
	
	if(upgrade.id == 'sword_damage'):
		additional_damage_percent = 1 + current_upgrades["sword_damage"]["quantity"] * .15
		
