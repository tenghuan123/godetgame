extends Node2D


@onready var label = $Label

func _ready():
	pass
	


func tweenCallBack():
	queue_free()


func start(text:String):
	label.text = text
	
	var tween = create_tween()
	tween.parallel()
	tween.tween_property(self, "global_position", global_position + (Vector2.UP * 16), .3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "global_position", global_position + (Vector2.UP * 48), .5)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)

	
	tween.tween_callback(tweenCallBack)
	
	var scale_tween = create_tween()
	scale_tween.tween_property(self, 'scale', Vector2.ONE * 1.5, .15)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	scale_tween.tween_property(self, 'scale', Vector2.ONE, .2)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	scale_tween.tween_property(self, 'scale', Vector2.ZERO, .5)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
