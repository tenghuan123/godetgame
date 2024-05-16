extends Node

@export var end_screen_scene: PackedScene

func _ready():
	$%Player.health_component.died.connect(on_player_died)



func on_player_died():
	if(end_screen_scene == null):
		return

	var end_screen_scene_instantiate = end_screen_scene.instantiate()
	add_child(end_screen_scene_instantiate)
	end_screen_scene_instantiate.set_defeat('游戏结束', '你被击杀了')
