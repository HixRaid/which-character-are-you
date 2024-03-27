extends "res://game/scripts/interfaces/interface.gd"

onready var language_option_button = $Panel/LanguagePanel/OptionButton


func _ready():
	match OS.get_locale_language():
		"en":
			language_option_button.selected = 0
		"ru":
			language_option_button.selected = 1
		"tr":
			language_option_button.selected = 2


func _on_language_selected(index):
	match index:
		0:
			TranslationServer.set_locale("en")
		1:
			TranslationServer.set_locale("ru")
		2:
			TranslationServer.set_locale("tr")

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
