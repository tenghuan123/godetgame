extends Node
class_name HealthComponent

@export var max_health: float = 10
var current_health
# 死亡信号
signal died

signal current_health_change

# Called when the node enters the scene tree for the first time.
func _ready():
    current_health = max_health


func damage(damage_count:float):
    current_health = max(current_health - damage_count, 0)
    current_health_change.emit()
    Callable(check_died).call_deferred()

func check_died():
    if current_health == 0:
        died.emit()
        # 这里的owner类似于 js中的this
        owner.queue_free()

func get_health_percent():
    if(max_health == 0):
        return 0

    return min(1, current_health / max_health)