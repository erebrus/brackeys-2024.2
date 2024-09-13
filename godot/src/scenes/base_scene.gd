class_name GameScene extends Node


@export var dialogue: DialogueResource


func _ready() -> void:
	_setup_characters(self)
	

func _setup_characters(node: Node) -> void:
	for child in node.get_children():
		if child is CharacterTrigger: 
			child.clicked.connect(start_dialogue_with.bind(child.character_id))
		else:
			_setup_characters(child)
	

func start_dialogue_with(character_id: Types.Characters) -> void:
	var character = State.characters[character_id]
	character.find_portrait()
	
	DialogueManager.show_dialogue_balloon(dialogue, character.start_dialogue)
	
