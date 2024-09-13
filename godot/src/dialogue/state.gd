extends Node

const CHARACTER_PATH = "res://src/characters/data"


var character:String = "Test"
var characters: Dictionary # [Types.Characters, Character]
var clues:Dictionary={}
var current_day:= 1
var current_time:= 1

var clues_previous_count=0

func _ready() -> void:
	verify_dialogue_files()
	load_characters()
	load_clues()
	Events.dialogue_finished.connect(_on_dialogue_finished)
	
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
	

func advance_time(time: int):
	if time > current_time:
		change_time(current_day, time)
		

func _on_dialogue_finished():
	var count = 0
	for cid in Types.Characters.values():
		if cid == Types.Characters.Unknown:
			continue
		var c = characters[cid]
		count+=c.name_clues.size() + c.portrait_clues.size()
		
	Logger.info("clues count %d vs %s" % [count, clues_previous_count + Types.CLUE_COUNTS[Vector2i(current_day, current_time)]] )
	
	if count - clues_previous_count == Types.CLUE_COUNTS[Vector2i(current_day, current_time)]:
		Logger.info("advancing time/day")
		clues_previous_count = count
		if current_day == 1 and current_time < 3:
			change_time(current_day, current_time+1)
		else:
			current_day += 1
			current_time = 1
			Events.day_changed.emit(current_day)
			
