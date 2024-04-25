extends Node

@export_range(0,1) var drop_percent: float = .5
@export var healthComponet: HealthComponent
@export var vail_sence: PackedScene 

func _ready():
    healthComponet.died.connect(on_died)


func on_died():
    if randf() > drop_percent:
        return

    if vail_sence == null:
        return
    
    if not owner is Node2D:
        return

    var spawn_position = (owner as Node2D).global_position
    var vail_instance = vail_sence.instantiate() as Node2D

    owner.get_parent().add_child(vail_instance)
    vail_instance.global_position = spawn_position