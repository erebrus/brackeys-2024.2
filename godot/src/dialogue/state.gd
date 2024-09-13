extends Node

const CHARACTER_PATH = "res://src/characters/data"


var character:String = "Test"
var characters: Dictionary # [Types.Characters, Character]
var clues:Dictionary={}
var current_day:= 1
var current_time:= 10

func _ready() -> void:
	verify_dialogue_files()
	load_characters()
	load_clues()
	
func verify_dialogue_files():
	#TODO got through each file and check characters always exist
	pass
	
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
	

func load_clues():
	var clues_file:FileAccess = FileAccess.open("res://assets/dialogue/clues.txt",FileAccess.READ)
	while not clues_file.eof_reached():
		var line = clues_file.get_csv_line("|")
		if line.size()!=3:
			if not(line.size()==1 and line[0]==""):
				Logger.warn("Ignoring invalid line:%s" % line)
			continue
		Logger.debug(str(line))
		clues[line[0]] = line[1]
		
		
func change_time(day: int, time: int):
	current_day = day
	current_time = time
	Events.time_changed.emit(current_day, current_time)
	
