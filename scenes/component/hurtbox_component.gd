extends Area2D

class_name HurtBoxComponent

signal hit 

@export var healthComponet: HealthComponent

var floating_text_scene = preload("res://scenes/ui/floating_text.tscn")

func _ready():
	area_entered.connect(on_area_entered)


func on_area_entered(other_area: Area2D):
	if not other_area is HitBoxComponent:
		return

	if healthComponet == null:
		return

	var hixbox_component = other_area as HitBoxComponent
	healthComponet.damage(hixbox_component.damage)
	
	var floating_text_instances = floating_text_scene.instantiate() as Node2D
	var foreground_layer =  get_tree().get_first_node_in_group("foreground_layer") as Node2D
	
	if(foreground_layer == null):
		return
		
	foreground_layer.add_child(floating_text_instances)
	floating_text_instances.global_position = global_position + (Vector2.UP * 16)
	
	var format_string = "%0.1f"
	if(round(hixbox_component.damage) == hixbox_component.damage):
		format_string = "%0.0f"
	floating_text_instances.start(format_string % hixbox_component.damage)
	
	hit.emit()
