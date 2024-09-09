class_name Portrait extends MarginContainer

signal clicked


@export var character: Character:
	set(value):
		character = value
		
		if character == null:
			return
		
		%Photo.texture = character.portrait
	


func _ready() -> void:
	gui_input.connect(_on_portrait_input)
	

func _on_portrait_input(event: InputEvent) -> void:
	if event.is_action_released("left_click"):
		clicked.emit()
	
