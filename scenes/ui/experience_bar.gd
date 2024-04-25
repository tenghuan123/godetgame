extends CanvasLayer

@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar
@export var experience_manager: Node

func _ready():
    progress_bar.value = 0
    experience_manager.experience_updated.connect(on_experience_updated)



func on_experience_updated(current:float, target: float):
    var percent = current / target
    progress_bar.value = percent