class_name TreePortrait extends VBoxContainer

signal portrait_clicked
signal name_label_clicked


@export var solution: Character


@onready var portrait: Portrait = %Portrait
@onready var name_label: NameLabel = %NameLabel


func _ready() -> void:
	portrait.clicked.connect(portrait_clicked.emit)
	name_label.clicked.connect(name_label_clicked.emit)
	

func set_portrait(character: Character) -> void:
	if portrait.character != null and portrait.character != Globals.unknown:
		Events.character_portrait_unset.emit(portrait.character)
		
	portrait.character = character
	
	if portrait.character != null and portrait.character != Globals.unknown:
		Events.character_portrait_set.emit(portrait.character)
	

func set_name_label(character: Character) -> void:
	if name_label.character != null and name_label.character != Globals.unknown:
		Events.character_name_unset.emit(name_label.character)
		
	name_label.character = character
	
	if name_label.character != null and name_label.character != Globals.unknown:
		Events.character_name_set.emit(name_label.character)
	
