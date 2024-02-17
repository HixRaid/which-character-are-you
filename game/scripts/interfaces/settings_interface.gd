extends "res://game/scripts/interfaces/interface.gd"


func _on_scale_selected(index):
	match index:
		0:
			set_scale(1.15)
		1:
			set_scale(1)
		2:
			set_scale(0.75)


func set_scale(value):
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_EXPAND, Vector2(1280,720), value)
