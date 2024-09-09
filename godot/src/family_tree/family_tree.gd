extends Control


var portraits: Array[TreePortrait]

@onready var choose_portrait_popup: Control = %ChoosePortraitPopup
@onready var choose_name_popup: Control = %ChooseNamePopup


func _ready() -> void:
	_find_portraits(self)
	Events.character_name_set.connect(_on_changed)
	Events.character_portrait_set.connect(_on_changed)
	

func _find_portraits(node: Node) -> void:
	for child in node.get_children():
		if child is TreePortrait:
			portraits.append(child)
			child.set_portrait(Globals.unknown_character)
			child.set_name_label(Globals.unknown_character)
			
			child.portrait_clicked.connect(_on_portrait_clicked.bind(child))
			child.name_label_clicked.connect(_on_name_clicked.bind(child))
		else:
			_find_portraits(child)
	

func _on_portrait_clicked(portrait: TreePortrait) -> void:
	choose_portrait_popup.show()
	var character = await choose_portrait_popup.selected
	if character != null:
		portrait.set_portrait(character)
	

func _on_name_clicked(portrait: TreePortrait) -> void:
	choose_name_popup.show()
	var character = await choose_name_popup.selected
	if character != null:
		portrait.set_name_label(character)
	

func _on_changed(_character: Character) -> void:
	for portrait in portraits:
		if not portrait.is_correct:
			Logger.info("Theres missing information yet.")
			return
	
	Logger.info("Family tree discovered!")
	
