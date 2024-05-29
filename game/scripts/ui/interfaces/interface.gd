extends Control

signal set_visible(value)

onready var panel = $Panel


func set_visible(active):
	panel.visible = active
	emit_signal("set_visible", active)
