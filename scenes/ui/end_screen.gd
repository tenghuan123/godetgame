extends CanvasLayer

@onready var restart_button = $%RestartButton
@onready var quit_button = $%QuitButton
@onready var title_label = $%TitleLabel
@onready var description_label = $%DescriptionLabel
@onready var panel_container = %PanelContainer
@onready var animation_player = $AnimationPlayer

func _ready():
	get_tree().paused = true
	restart_button.pressed.connect(on_restart_button_pressed)
	quit_button.pressed.connect(on_quit_button_pressed)
	
	#增加结束时弹窗动画
	panel_container.pivot_offset = panel_container.size / 2
	panel_container.scale = Vector2.ZERO
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0.3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)


func on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func on_quit_button_pressed():
	animation_player.play("out")
	await  animation_player.animation_finished
	get_tree().quit()


func set_defeat(title: String, description: String):
	title_label.text = title
	description_label.text = description
	play_jingle(true)
	


func play_jingle(defeat: bool = false):
	if defeat:
		$DefeatStreamPlayer.play_random()
	else:
		$VictoryStreamPlayer.play_random()
