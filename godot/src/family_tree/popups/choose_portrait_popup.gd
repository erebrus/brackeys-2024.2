extends PanelContainer

signal selected(character: Character)


@export var PortraitScene: PackedScene


@onready var container: Container = %PortraitContainer


func _ready() -> void:
	assert(PortraitScene != null)
	
	_add_portrait(Globals.unknown)
	for character in Globals.characters:
		_add_portrait(character)
	

func _add_portrait(character: Character) -> void:
	var portrait = PortraitScene.instantiate()
	portrait.person = character
	portrait.show_name = false
	portrait.portrait_clicked.connect(_on_portrait_clicked.bind(character))
	
	container.add_child(portrait)
	

func show_character(character: Character) -> void:
	for child in container.get_children():
		if child.person == character:
			child.show()
	

func hide_character(character: Character) -> void:
	for child in container.get_children():
		if child.person == character:
			child.hide()
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		selected.emit(null)
		hide()
	

func _on_portrait_clicked(character: Character) -> void:
	selected.emit(character)
	hide()
