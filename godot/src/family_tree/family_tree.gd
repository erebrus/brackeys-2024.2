extends Control


var portraits: Array[TreePortrait]

@onready var choose_portrait_popup: Control = %ChoosePortraitPopup


func _ready() -> void:
	_find_portraits(self)
	

func _find_portraits(node: Node) -> void:
	for child in node.get_children():
		if child is TreePortrait:
			portraits.append(child)
			child.person = Character.new()
			child.portrait_clicked.connect(_on_portrait_clicked.bind(child))
			child.name_clicked.connect(_on_name_clicked.bind(child))
		else:
			_find_portraits(child)
	

func _release_portrait(character: Character) -> void:
	choose_portrait_popup.show_character(character)
	

func _select_portrait(character: Character) -> void:
	choose_portrait_popup.hide_character(character)
	

func _on_portrait_clicked(portrait: TreePortrait) -> void:
	choose_portrait_popup.show()
	var character = await choose_portrait_popup.selected
	if character != null:
		if portrait.current_portrait != Globals.unknown:
			_release_portrait(portrait.current_portrait)
		
		portrait.set_portrait(character)
		if character != Globals.unknown:
			_select_portrait(character)
	

func _on_name_clicked(portrait: TreePortrait) -> void:
	Logger.info("name clicked!")
	
