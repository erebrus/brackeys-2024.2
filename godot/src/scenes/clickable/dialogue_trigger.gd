extends Clickable

@export var dialogue: DialogueResource
@export var dialogue_title: String = "start"

@export var character_id: Types.Characters

var character: Character

func _ready() -> void:
	super._ready()
	
	assert(dialogue != null)
	clicked.connect(start_dialogue)
	
	if character_id != Types.Characters.Unknown:
		character = State.characters[character_id]
		dialogue_title = character.start_dialogue
		character.dialogue_changed.connect(_on_dialogue_changed)
	

func start_dialogue() -> void:
	DialogueManager.show_dialogue_balloon(dialogue, dialogue_title)
	

func _on_dialogue_changed() -> void:
	dialogue_title = character.start_dialogue
