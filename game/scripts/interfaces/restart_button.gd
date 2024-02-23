extends Button

onready var icon_texture_rect = $Icon
onready var tween = $Tween


func _on_pressed():
	tween.interpolate_property(icon_texture_rect, "rect_rotation",
		0, 360, 0.75,
		Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
