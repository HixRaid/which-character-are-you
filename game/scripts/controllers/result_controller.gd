extends Node

onready var character_image = $"../Panel/CharacterImage"
onready var name_label = $"../Panel/NameLabel"
onready var description_label = $"../Panel/DescriptionLabel"


func set_character(character):
	character_image.texture = load("res://game/images/characters/" + character.image)
	name_label.text = character.name_key
	description_label.text = character.description_key
