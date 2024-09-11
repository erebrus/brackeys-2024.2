extends Node

const CHARACTER_PATH = "res://src/characters/data"


var character:String = "Test"
var characters: Dictionary # [Types.Characters, Character]

var current_day:= 1
var current_time:= 10

func _ready() -> void:
	load_characters()
	

func load_characters() -> void:
	Logger.info("Loading characters")
	var dir = DirAccess.open(CHARACTER_PATH)  
	dir.list_dir_begin()  
	var file_name = dir.get_next()  
	while file_name != "":  
		var file_path = CHARACTER_PATH + "/" + file_name  
		var character: Character = ResourceLoader.load(file_path)
		characters[character.id] = character
		
		file_name = dir.get_next()  
	Logger.info("Characters loaded")
	

func change_time(day: int, time: int):
	current_day = day
	current_time = time
	Events.time_changed.emit(current_day, current_time)
	
