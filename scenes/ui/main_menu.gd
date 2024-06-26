extends CanvasLayer


@onready var play_button = %PlayButton
@onready var options_button = %OptionsButton
@onready var quit_button = %QuitButton

var options_scene = preload("res://scenes/ui/options_menu.tscn")
 
func _ready():
	play_button.pressed.connect(on_play_button_pressed)
	options_button.pressed.connect(on_options_button_pressed)
	quit_button.pressed.connect(on_quit_button_pressed)
	


func on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func on_options_button_pressed():
	var options_instance = options_scene.instantiate()
	add_child(options_instance)
	options_instance.back_pressed.connect(on_back_pressed.bind(options_instance))


func on_back_pressed(sence: Node):
	sence.queue_free()


func on_quit_button_pressed():
	get_tree().quit()
