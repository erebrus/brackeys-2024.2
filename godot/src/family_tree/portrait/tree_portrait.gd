class_name TreePortrait extends VBoxContainer

signal portrait_clicked
signal name_label_clicked


@export var solution: Types.Characters


var is_correct: bool:
	get:
		return portrait.character_id == solution and name_label.character_id == solution
		

var character: Character:
	get:
		if portrait.character_id != name_label.character_id:
			return null
		if portrait.character_id == Types.Characters.Unknown:
			return Globals.unknown_character
		return State.characters[portrait.character_id]
		

var clues: Array[String]:
	get:
		var result: Array[String]
		if portrait._character != null:
			result.append_array(portrait._character.portrait_clues)
		if name_label._character != null:
			result.append_array(name_label._character.name_clues)
		
		return result
	

@onready var portrait: Portrait = %Portrait
@onready var name_label: NameLabel = %NameLabel


func _ready() -> void:
	portrait.clicked.connect(portrait_clicked.emit)
	name_label.clicked.connect(name_label_clicked.emit)
	
	if solution != Types.Characters.Unknown:
		var solution_character = State.characters[solution]
		
		if solution_character != null and solution_character.is_discovered:
			set_portrait(solution_character)
			set_name_label(solution_character)
		
	

func set_portrait(character: Character) -> void:
	if portrait.character_id != Types.Characters.Unknown:
		Events.character_portrait_unset.emit(State.characters[portrait.character_id])
		
	portrait.character_id = character.id
	
	if portrait.character_id != Types.Characters.Unknown:
		Events.character_portrait_set.emit(State.characters[portrait.character_id])
	

func set_name_label(character: Character) -> void:
	if name_label.character_id != Types.Characters.Unknown:
		Events.character_name_unset.emit(State.characters[name_label.character_id])
		
	name_label.character_id = character.id
	
	if name_label.character_id != Types.Characters.Unknown:
		Events.character_name_set.emit(State.characters[name_label.character_id])
	
