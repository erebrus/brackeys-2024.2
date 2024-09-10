class_name NameLabel extends PanelContainer

signal clicked

@export var solved_font: LabelSettings
@export var guess_font: LabelSettings
@export var show_unknown:= false


var _character: Character
@export var character_id: Types.Characters:
	set(value):
		if _character != null and  _character.discovered.is_connected(_on_character_discovered):
			_character.discovered.disconnect(_on_character_discovered)
		
		character_id = value
		
		if character_id == Types.Characters.Unknown:
			_character = Globals.unknown_character
		else:
			_character = State.characters[character_id]
		
		if character_id == Types.Characters.Unknown and not show_unknown:
			%Label.text = ""
		else:
			%Label.text = _character.name
		
		if _character != null and _character.is_discovered:
			%Label.label_settings = solved_font
		else:
			_character.discovered.connect(_on_character_discovered)
		
	

func _ready() -> void:
	gui_input.connect(_on_gui_input)
	%Label.label_settings = guess_font
	
	if _character != null and _character.is_discovered:
		%Label.label_settings = solved_font
	

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		clicked.emit()
	

func _on_character_discovered() -> void:
	%Label.label_settings = solved_font
