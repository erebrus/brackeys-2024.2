class_name Character extends Resource

signal portrait_found
signal name_found
signal discovered
signal dialogue_changed
signal portrait_clue_found
signal name_clue_found


@export var id: Types.Characters
@export var name: String = "Unknown"
@export var portrait: Texture = preload("res://assets/gfx/portraits/person_unknown.png")

@export var name_available:= false # true if you can select name in tree popup
@export var portrait_available:= false # true if you can select name in tree popup

@export var is_discovered:= false #set when position is verified on tree
@export var is_dead:= false
@export var is_known:= false # set when the dialogue should show the name instead of ???

@export var portrait_clues: Array[String]
@export var name_clues: Array[String]

@export var start_dialogue: String

func get_name_label() -> String:
	if is_known or is_discovered:
		return name
	else:
		return "???"
		
func find_name() -> void:
	Logger.info("Character name found: %s" % self)
	name_available = true
	name_found.emit()
	

func find_portrait() -> void:
	Logger.info("Character portrait found: %s" % self)
	portrait_available = true
	portrait_found.emit()
	

func find_portrait_clue(clue: String) -> void:
	if not portrait_clues.has(clue):
		portrait_clues.append(clue)
		portrait_clue_found.emit(clue)
	

func find_name_clue(clue: String) -> void:
	if not name_clues.has(clue):
		name_clues.append(clue)
		name_clue_found.emit(clue)
	

func discover() -> void:
	if is_discovered:
		return
	
	Logger.info("Character discovered: %s" % self)
	is_discovered = true
	discovered.emit()
	

func set_dialogue(dialogue: String) -> void:
	if dialogue == start_dialogue:
		return
	start_dialogue = dialogue
	dialogue_changed.emit()
	

func _to_string() -> String:
	return Types.Characters.keys()[id]
