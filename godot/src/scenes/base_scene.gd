class_name GameScene extends Node


@export var dialogue: DialogueResource
@export var location: Types.Locations


func _ready() -> void:
	_setup_characters(self)
	

func _setup_characters(node: Node) -> void:
	for child in node.get_children():
		if child is CharacterTrigger: 
			child.clicked.connect(start_dialogue_with.bind(child.character_id))
			
			var character = State.characters[child.character_id]
			character.left_location.connect(_on_character_left.bind(child))
			character.entered_location.connect(_on_character_entered.bind(child))
			
			if character.location != location:
				child.hide()
			
		else:
			_setup_characters(child)
	

func start_dialogue_with(character_id: Types.Characters) -> void:
	var character = State.characters[character_id]
	character.find_portrait()
	
	DialogueManager.show_dialogue_balloon(dialogue, character.start_dialogue)
	

func _on_character_left(location_left: Types.Locations, character: CharacterTrigger) -> void:
	if location_left == location:
		character.hide()
	

func _on_character_entered(location_entered: Types.Locations, character: CharacterTrigger) -> void:
	if location_entered == location:
		character.show()
	
