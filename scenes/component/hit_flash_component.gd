extends Node


@export var health_component: Node
@export var sprite: Sprite2D
@export var hit_flash_material: ShaderMaterial

var hit_flash_tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	health_component.current_health_change.connect(on_current_health_change)
	sprite.material = hit_flash_material


func on_current_health_change():
	if hit_flash_material != null && hit_flash_tween != null && hit_flash_tween.is_valid():
		hit_flash_tween.kill()
		
	(sprite.material as ShaderMaterial).set_shader_parameter("lerp_percent", 1)
	hit_flash_tween = create_tween()
	hit_flash_tween.tween_property(sprite.material, "shader_parameter/lerp_percent", 0.0, .2)
	
