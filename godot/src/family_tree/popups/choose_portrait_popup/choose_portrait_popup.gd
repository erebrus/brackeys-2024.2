extends Popup

signal selected(character: Character)

@export var PortraitScene: PackedScene


@onready var container: Container = %PortraitContainer

var available: Array[Character]
var is_open:= false


func _ready() -> void:
	assert(PortraitScene != null)
	
	close_requested.connect(close)
	Events.character_portrait_set.connect(hide_character)
	Events.character_portrait_unset.connect(show_character)
	
	_add_portrait(Globals.unknown_character)
	for character in State.characters.values():
		_add_portrait(character)
	

func open() -> void:
	popup_centered()
	is_open = true
	
func close() -> void:
	if is_open:
		selected.emit(null)
	is_open = false
	hide()
	

func _add_portrait(character: Character) -> void:
	var portrait = PortraitScene.instantiate()
	portrait.character_id = character.id
	portrait.clicked.connect(_on_portrait_clicked.bind(character))
	character.portrait_found.connect(_on_portrait_found.bind(character))
	
	if character.portrait_available:
		available.append(character)
	else:
		portrait.visible = false
	
	container.add_child(portrait)
	

func show_character(character: Character) -> void:
	for child in container.get_children():
		if child.character_id ==  character.id:
			child.show()
	

func hide_character(character: Character) -> void:
	for child in container.get_children():
		if child.character_id ==  character.id:
			child.hide()
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		selected.emit(null)
		hide()
	

func _on_portrait_clicked(character: Character) -> void:
	selected.emit(character)
	$sfx_pickup_portrait.play()
	hide()


func _on_portrait_found(character: Character) -> void:
	if not available.has(character):
		available.append(character)
		show_character(character)
