class_name NameLabel extends PanelContainer

signal clicked


@export var character: Character:
	set(value):
		character = value
		
		if character == null:
			return
		
		$Label.text = character.name
	

func _ready() -> void:
	gui_input.connect(_on_gui_input)
	

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		clicked.emit()
