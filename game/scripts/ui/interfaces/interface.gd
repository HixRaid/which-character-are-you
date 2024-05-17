extends Control

onready var panel = $Panel


func set_visibility(active):
	panel.visible = active
