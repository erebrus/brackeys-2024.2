class_name GameScene extends Node


@export var portraits_found_on_enter: Array[Types.Characters]


func _ready() -> void:
	_discover_characters()
	

func _discover_characters() -> void:
	for character_id in portraits_found_on_enter:
		var character = State.characters[character_id]
		character.find_portrait()
	
