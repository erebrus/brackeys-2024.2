class_name Character extends Resource

signal portrait_found
signal name_found
signal discovered
signal dialogue_changed


@export var id: Types.Characters
@export var name: String = "Unknown"
@export var portrait: Texture = preload("res://assets/gfx/portraits/person_unknown.png")

@export var name_available:= false # true if you can select name in tree popup
@export var portrait_available:= false # true if you can select name in tree popup

@export var is_discovered:= false #set when position is verified on tree
@export var is_dead:= false

@export var portrait_clues: Array[String]
@export var name_clues: Array[String]

@export var start_dialogue: String


func find_name() -> void:
	Logger.info("Character name found: %s" % self)
	name_available = true
	name_found.emit()
	

func find_portrait() -> void:
	Logger.info("Character portrait found: %s" % self)
	portrait_available = true
	portrait_found.emit()
	

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
