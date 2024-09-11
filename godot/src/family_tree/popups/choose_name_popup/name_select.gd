extends VBoxContainer


signal clicked


var _character: Character
@export var character_id: Types.Characters:
	set(value):
		character_id = value
		
		%NameLabel.character_id = character_id
		
		if character_id == Types.Characters.Unknown:
			_character = Globals.unknown_character
		else:
			_character = State.characters[character_id]
			
		for clue in _character.name_clues:
			_add_clue(clue)
		

func _ready() -> void:
	gui_input.connect(_on_portrait_input)
	

func _add_clue(clue: String) -> void:
	var label = Label.new()
	label.text = clue
	%CluesContainer.add_child(label)
	

func _on_portrait_input(event: InputEvent) -> void:
	if event.is_action_released("left_click"):
		clicked.emit()
	
