class_name FamilyTree extends Control


var portraits: Array[TreePortrait]

@onready var choose_portrait_popup: Control = %ChoosePortraitPopup
@onready var choose_name_popup: Control = %ChooseNamePopup
@onready var clues_popup: Control = %CluesPopup


func _ready() -> void:
	_find_portraits(self)
	Events.family_tree_requested.connect(_on_family_tree_requested )

func _on_family_tree_requested(close:=false):
	_close_popups()
	if not close and not visible:
		visible = true
		$sfx_open.play()
		return
	if close and visible:
		visible = false
		$sfx_close.play()
		
func _input(event: InputEvent) -> void:
	if Globals.in_dialogue:
		return
	if event.is_action_pressed("toggle_tree"):
		toggle_tree()
		
func toggle_tree():
		_close_popups()
		visible = not visible
		if visible:
			$sfx_open.play()
		else:
			$sfx_close.play()

func _find_portraits(node: Node) -> void:
	for child in node.get_children():
		if child is TreePortrait:
			portraits.append(child)

			child.portrait_clicked.connect(_on_portrait_clicked.bind(child))
			child.name_label_clicked.connect(_on_name_clicked.bind(child))
			child.mouse_entered.connect(_on_portrait_mouse_entered.bind(child))
			child.mouse_exited.connect(_on_portrait_mouse_exited.bind(child))
			
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
	Events.family_tree_complete.emit()
	

func _close_popups() -> void:
	if choose_name_popup.visible:
		choose_name_popup.close()
	if choose_portrait_popup.visible:
		choose_portrait_popup.close()
	if clues_popup.visible:
		clues_popup.close()
	

func _on_portrait_clicked(portrait: TreePortrait) -> void:
	if portrait.character != null and portrait.character.is_discovered:
		return
	
	_close_popups()
	choose_portrait_popup.show()
	var character = await choose_portrait_popup.selected
	if character != null:
		portrait.set_portrait(character)
		_check_portrait_is_correct(portrait)
		
	

func _on_name_clicked(portrait: TreePortrait) -> void:
	if portrait.character != null and portrait.character.is_discovered:
		return
	
	_close_popups()
	choose_name_popup.show()
	var character = await choose_name_popup.selected
	if character != null:
		portrait.set_name_label(character)
		_check_portrait_is_correct(portrait)
		
	

func _on_portrait_mouse_entered(portrait: TreePortrait) -> void:
	clues_popup.open(portrait.clues)
	

func _on_portrait_mouse_exited(portrait: TreePortrait) -> void:
	clues_popup.close()
	
