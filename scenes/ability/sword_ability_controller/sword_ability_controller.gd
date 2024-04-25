extends Node

@export var sword_ability: PackedScene

const MAX_RANGE = 150
var damage = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("Timer")
	$Timer.timeout.connect(on_timer_timeout)


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

	player.get_parent().add_child(sword_instance)
	sword_instance.hitbox_component.damage = damage

	sword_instance.global_position = enemies[0].global_position
	# 我们现在需要一个角度来攻击敌人
	var direction = enemies[0].global_position - player.global_position
	sword_instance.global_rotation = direction.angle()

	
