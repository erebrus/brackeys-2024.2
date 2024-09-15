extends Node

const CHARACTER_PATH = "res://src/characters/data"
const CHARACTERS = [
	preload("res://src/characters/data/daughter.tres"),
	preload("res://src/characters/data/family_head.tres"),
	preload("res://src/characters/data/first_son.tres"),
	preload("res://src/characters/data/friend_of_the_family.tres"),
	preload("res://src/characters/data/grandson.tres"),
	preload("res://src/characters/data/second_son.tres"),
	preload("res://src/characters/data/sister_of_wife.tres"),
	preload("res://src/characters/data/son_from_first_marriage.tres"),
	preload("res://src/characters/data/widow_of_second_son.tres"),
	preload("res://src/characters/data/wife.tres"),
	preload("res://src/characters/data/wife_of_first_son.tres")
]

var debug_clue_count:=0
var character:String = "Test"
var characters: Dictionary # [Types.Characters, Character]
var clues:Dictionary={}
var current_day:= 1
var current_time:= 1

var clues_previous_count=0
var family_tree_complete:= false
var win:=false

func _ready() -> void:
	verify_dialogue_files()
	load_clues()
	Events.dialogue_finished.connect(_on_dialogue_finished)
	Events.family_tree_complete.connect(_on_family_tree_complete)
	

func verify_dialogue_files():
	#TODO got through each file and check characters always exist
	pass
	
func load_characters() -> void:
	Logger.info("Loading characters")
	#var dir = DirAccess.open(CHARACTER_PATH)  
	#dir.list_dir_begin()  
	#var file_name = dir.get_next()  
	#while file_name != "":  
		#var file_path = CHARACTER_PATH + "/" + file_name  
		#var character: Character = ResourceLoader.load(file_path)
		#characters[character.id] = character
		#
		#file_name = dir.get_next()  
	for character in CHARACTERS:
		characters[character.id] = character
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
	

func reset() -> void:
	load_characters()
	var hidden_characters = [
		Types.Characters.SisterOfWife,
		Types.Characters.FriendOfTheFamily,
		Types.Characters.Daughter,
		Types.Characters.FirstBornSon,
		Types.Characters.Grandson,
		Types.Characters.SonFromFirstMariageOfHeadOfFamily,
		
	]
	
	for id in hidden_characters:
		var character = characters[id]
		character.set_location(Types.Locations.None)
		

func advance_day() -> void:
	Logger.info("advancing day")
	current_day += 1
	current_time = 1
	Events.day_changed.emit(current_day)
	Events.time_changed.emit(current_day, current_time)
	

func advance_time() -> void:
	Logger.info("advancing time")
	current_time += 1
	
	match current_time:
		2:
			characters[Types.Characters.Daughter].set_location(Types.Locations.Garden)
			characters[Types.Characters.SisterOfWife].set_location(Types.Locations.DiningRoom)
			characters[Types.Characters.FriendOfTheFamily].set_location(Types.Locations.LivingRoom)
		3:
			characters[Types.Characters.FirstBornSon].set_location(Types.Locations.LivingRoom)
			characters[Types.Characters.Grandson].set_location(Types.Locations.Garden)
			characters[Types.Characters.SonFromFirstMariageOfHeadOfFamily].set_location(Types.Locations.DiningRoom)
			
	Events.time_changed.emit(current_day, current_time)
	

func count_clues():
	if debug_clue_count>0:
		return debug_clue_count
	var count= 0
	for cid in Types.Characters.values():
		if cid == Types.Characters.Unknown:
			continue
		var c = characters[cid]
		count+=c.name_clues.size() + c.portrait_clues.size()
	return count

func _check_clues_for_advancement() -> void:
	var count = count_clues()
		
	Logger.info("clues count %d vs %s" % [count, clues_previous_count + Types.CLUE_COUNTS[Vector2i(current_day, current_time)]] )
	
	if count - clues_previous_count == Types.CLUE_COUNTS[Vector2i(current_day, current_time)]:
		
		if current_day == 1 and current_time < 3:
			clues_previous_count = count
			advance_time()
		else: 
			if current_day != 1 or family_tree_complete:
				clues_previous_count = count
				Events.day_ended.emit()
	

func _on_family_tree_complete():
	family_tree_complete = true
	Events.family_tree_requested.emit(false)
	_check_clues_for_advancement() 
	

func _on_dialogue_finished():
	_check_clues_for_advancement()
	
