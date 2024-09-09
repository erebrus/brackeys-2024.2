extends Node


var character:String = "Test"
var characters: Array[Character]

func _ready() -> void:
	characters=[create_character("C1"), create_character("C2")]	


static func create_character(character_name:String)->Character:
	var ret = Character.new()
	ret.name = character_name
	return ret
