extends Node2D


func _ready():
	$Area2D.area_entered.connect(on_area_entered)



func on_area_entered(_area: Area2D):
	GameEvents.emit_experience_vial(1)
	queue_free()
