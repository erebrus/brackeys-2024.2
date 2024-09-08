@tool
class_name TreePortrait extends Portrait


@export var solution: Character


@onready var current_portrait: Character = Globals.unknown
@onready var current_name: Character = Globals.unknown


func set_portrait(character: Character) -> void:
	if person != null:
		person.portrait = character.portrait
	
	current_portrait = character
	%Photo.texture = character.portrait
	

func set_name_label(character: Character) -> void:
	if person != null:
		person.name = character.name
	
	current_name = character
	%NameLabel.text = character.name
	
