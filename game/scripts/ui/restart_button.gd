extends Button

var icon_texture_rect

onready var tween = $Tween


func _enter_tree():
	icon_texture_rect = $Icon


func set_disabled(value):
	disabled = value
	icon_texture_rect.modulate = Color.white * 0.75 if value else Color.white


func _on_pressed():
	tween.interpolate_property(icon_texture_rect, "rect_rotation",
		0, 360, 0.75,
		Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
