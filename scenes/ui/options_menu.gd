extends CanvasLayer

signal back_pressed

@onready var window_button: Button = %WindowButton
@onready var sfx_slider: HSlider = %SfxHSlider
@onready var music_slider: HSlider = %MusicHSlider
@onready var back_button: Button = %BackButton

func _ready():
	window_button.pressed.connect(on_window_button_pressed)
	back_button.pressed.connect(on_back_button_pressed)
	sfx_slider.value_changed.connect(on_audio_slider_changed.bind('sfx'))
	music_slider.value_changed.connect(on_audio_slider_changed.bind('music'))
	update_display()


func on_back_button_pressed():
	back_pressed.emit()


func on_audio_slider_changed(value: float, name: String):
	set_bus_volume_precent(name, value)


func update_display():
	sfx_slider.value = get_bus_volume_precent("sfx")
	music_slider.value = get_bus_volume_precent("music")


func on_window_button_pressed():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		window_button.text = "窗口模式"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		window_button.text = "全屏模式"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func get_bus_volume_precent(bus_name: String):
	var bus_index = AudioServer.get_bus_index(bus_name)
	var volume_db = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(volume_db)


func set_bus_volume_precent(bus_name: String, precent: float):
	var bus_index = AudioServer.get_bus_index(bus_name)
	var volume_db = linear_to_db(precent)
	AudioServer.set_bus_volume_db(bus_index, volume_db)
	
