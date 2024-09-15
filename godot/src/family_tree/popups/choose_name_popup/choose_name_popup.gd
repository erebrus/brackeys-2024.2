extends PanelContainer

signal selected(character: Character)


@export var NameScene: PackedScene

@onready var container: Container = %NameContainer


func _ready() -> void:
	assert(NameScene != null)
	
	Events.character_name_set.connect(hide_character)
	Events.character_name_unset.connect(show_character)
	
	_add_name(Globals.unknown_character)
	for character in State.characters.values():
		_add_name(character)
	

func close() -> void:
	selected.emit(null)
	hide()
	

func _add_name(character: Character) -> void:
	var name_label = NameScene.instantiate()
	name_label.character_id = character.id
	name_label.clicked.connect(_on_name_clicked.bind(character))
	character.name_found.connect(show_character.bind(character))
	
	if not character.name_available:
		name_label.visible = false
	
	container.add_child(name_label)
	

func show_character(character: Character) -> void:
	for child in container.get_children():
		if child.character_id == character.id:
			child.show()
	

func hide_character(character: Character) -> void:
	for child in container.get_children():
		if child.character_id == character.id:
			child.hide()
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		selected.emit(null)
		hide()
	

func _on_name_clicked(character: Character) -> void:
	selected.emit(character)
	$sfx_pickup_portrait.play()
	hide()
	
