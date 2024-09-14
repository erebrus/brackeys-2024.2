extends Node

@onready var current_scene: Node = %StartScene
@onready var family_tree: FamilyTree = %FamilyTree
@onready var overlay: Control = %Overlay

var tween: Tween


func _ready() -> void:
	Events.request_location_change.connect(_on_location_change)
	Events.day_ended.connect(_on_day_ended)
	Events.day_changed.connect(_on_day_changed)
	_fade_in()
	

func _fade_in() -> void:
	if tween != null:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(overlay, "modulate:a", 0, 0.5)
	await tween.finished
	
	overlay.hide()
	

func _fade_out() -> void:
	if tween != null:
		tween.kill()
	
	tween = create_tween()
	
	overlay.modulate.a = 0
	overlay.show()
	tween.tween_property(overlay, "modulate:a", 1, 0.5)
	
	await tween.finished
	

func _change_scene(create_scene: Callable) -> void:
	_fade_out()
	var target = create_scene.call()
	
	await tween.finished
	
	current_scene.queue_free()
	add_child.call_deferred(target)
	move_child.call_deferred(target, 0)
	
	await target.tree_entered
	current_scene = target
	_fade_in()
	

func choose_scene(location: Types.Locations) -> GameScene:
	# TODO: choose scene based on location and time of day?
	
	var path = "res://src/scenes/%s/%s_day_%s.tscn"
	var location_name = Types.Locations.keys()[location].to_lower()
	
	var scene = load(path % [location_name, location_name, State.current_day])
	
	return scene.instantiate()
	

func day_end_scene() -> GameScene:
	var path = "res://src/scenes/day_end/day_%s.tscn"
	var scene = load(path % (State.current_day))
	return scene.instantiate()
	

# TODO: remove
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_T:
			var character = State.characters.values().front()
			var all_clues = State.clues.keys()
			for clue in all_clues:
				if not character.name_clues.has(clue):
					character.find_name_clue(clue)
					State._on_dialogue_finished()
					return
		
		if event.pressed and event.keycode == KEY_E:
			Events.family_tree_complete.emit()
	

func _on_location_change(location: Types.Locations) -> void:
	_change_scene(choose_scene.bind(location))
	

func _on_day_changed(day) -> void:
	var location = Types.Locations.LivingRoom
	if day == 3:
		location = Types.Locations.Garden
	elif day == 4:
		location = Types.Locations.Kitchen
	
	for character in State.characters.values():
		character.start_dialogue = "%s_start" % Types.Characters.keys()[character.id]
		
	
	_change_scene(choose_scene.bind(Types.Locations.LivingRoom))
	

func _on_day_ended() -> void:
	_change_scene(day_end_scene)
	
