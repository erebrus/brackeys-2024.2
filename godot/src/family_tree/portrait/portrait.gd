class_name Portrait extends MarginContainer

signal clicked

@export var deceased_material: ShaderMaterial


var _character: Character
@export var character_id: Types.Characters:
	set(value):
		character_id = value
		
		if character_id == Types.Characters.Unknown:
			_character = Globals.unknown_character
		else:
			_character = State.characters[character_id]
			
		%Photo.texture = _character.portrait
		
		if _character.is_dead:
			%Photo.material = deceased_material


func _ready() -> void:
	gui_input.connect(_on_portrait_input)
	

func _on_portrait_input(event: InputEvent) -> void:
	if event.is_action_released("left_click"):
		clicked.emit()
	
