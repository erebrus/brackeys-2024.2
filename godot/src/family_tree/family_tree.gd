extends Control


var portraits: Array[TreePortrait]

@onready var choose_portrait_popup: Control = %ChoosePortraitPopup
@onready var choose_name_popup: Control = %ChooseNamePopup


func _ready() -> void:
	_find_portraits(self)
	#Events.character_name_set.connect(_on_changed)
	#Events.character_portrait_set.connect(_on_changed)
	

func _find_portraits(node: Node) -> void:
	for child in node.get_children():
		if child is TreePortrait:
			portraits.append(child)
			
			child.portrait_clicked.connect(_on_portrait_clicked.bind(child))
			child.name_label_clicked.connect(_on_name_clicked.bind(child))
		else:
			_find_portraits(child)
	

func _check_portrait_is_correct(portrait: TreePortrait) -> void:
	if portrait.is_correct:
		portrait.character.discover()
		_check_fully_discovered()
	

func _check_fully_discovered() -> void:
	for portrait in portraits:
		
		if not portrait.is_correct:
			Logger.debug("There's missing information yet.")
			return
	
	Logger.info("Family tree discovered!")
	

func _on_portrait_clicked(portrait: TreePortrait) -> void:
	if portrait.character != null and portrait.character.is_discovered:
		return
	
	choose_portrait_popup.show()
	var character = await choose_portrait_popup.selected
	if character != null:
		portrait.set_portrait(character)
		_check_portrait_is_correct(portrait)
	

func _on_name_clicked(portrait: TreePortrait) -> void:
	if portrait.character != null and portrait.character.is_discovered:
		return
	
	choose_name_popup.show()
	var character = await choose_name_popup.selected
	if character != null:
		portrait.set_name_label(character)
		_check_portrait_is_correct(portrait)
	

func _on_changed(character: Character) -> void:
	_check_fully_discovered()
	
