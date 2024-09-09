class_name TreePortrait extends VBoxContainer

signal portrait_clicked
signal name_label_clicked


@export var solution: Types.Characters


var is_correct: bool:
	get:
		if portrait.character == null or name_label.character == null:
			return false
			
		return portrait.character.id == solution and name_label.character.id == solution
		

@onready var portrait: Portrait = %Portrait
@onready var name_label: NameLabel = %NameLabel


func _ready() -> void:
	portrait.clicked.connect(portrait_clicked.emit)
	name_label.clicked.connect(name_label_clicked.emit)
	

func set_portrait(character: Character) -> void:
	if portrait.character != null and portrait.character != Globals.unknown_character:
		Events.character_portrait_unset.emit(portrait.character)
		
	portrait.character = character
	
	if portrait.character != null and portrait.character != Globals.unknown_character:
		Events.character_portrait_set.emit(portrait.character)
	

func set_name_label(character: Character) -> void:
	if name_label.character != null and name_label.character != Globals.unknown_character:
		Events.character_name_unset.emit(name_label.character)
		
	name_label.character = character
	
	if name_label.character != null and name_label.character != Globals.unknown_character:
		Events.character_name_set.emit(name_label.character)
	
