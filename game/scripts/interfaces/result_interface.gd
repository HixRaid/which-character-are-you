extends "res://game/scripts/interfaces/interface.gd"

onready var name_label = $Panel/NameLabel
onready var description_label = $Panel/DescriptionLabel


func set_character(character):
	name_label.text = character.name
	description_label.text = character.description
