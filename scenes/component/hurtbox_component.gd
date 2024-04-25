extends Area2D

class_name HurtBoxComponent

@export var healthComponet: HealthComponent

func _ready():
    area_entered.connect(on_area_entered)


func on_area_entered(other_area: Area2D):
    if not other_area is HitBoxComponent:
        return

    if healthComponet == null:
        return

    var hixbox_component = other_area as HitBoxComponent
    healthComponet.damage(hixbox_component.damage)