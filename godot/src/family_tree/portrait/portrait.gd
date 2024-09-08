class_name Portrait extends VBoxContainer

signal portrait_clicked
signal name_clicked


@export var person: Character:
	set(value):
		person = value
		if person == null:
			return
		
		%Photo.texture = person.portrait
		%NameLabel.text = person.name

@export var show_name: bool:
	set(value):
		show_name = value
		%NameLabel.visible = show_name

@onready var portrait: Control = %Portrait
@onready var name_label: Label = %NameLabel


func _ready() -> void:
	portrait.gui_input.connect(_on_portrait_input)
	name_label.gui_input.connect(_on_name_input)
	

func _on_portrait_input(event: InputEvent) -> void:
	if event.is_action_released("left_click"):
		portrait_clicked.emit()
	

func _on_name_input(event: InputEvent) -> void:
	if event.is_action_released("left_click"):
		name_clicked.emit()
	
