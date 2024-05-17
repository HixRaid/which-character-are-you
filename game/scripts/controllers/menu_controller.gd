extends Node

onready var quit_button = $"../Panel/QuitButton"


func _ready():
	if OS.has_feature("web"):
		quit_button.visible = false


func quit():
	get_tree().quit()
