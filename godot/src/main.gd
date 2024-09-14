extends Node

@onready var current_scene: Node = %StartScene
@onready var family_tree: FamilyTree = %FamilyTree
@onready var overlay: Control = %Overlay

var tween: Tween


func _ready() -> void:
	Events.request_location_change.connect(_on_location_change)
	Events.family_tree_complete.connect(_on_family_tree_complete)
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
	

# TODO: remove
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_T:
			var day = State.current_day
			var time = State.current_time + 1
			if time >= 24:
				time -= 24
				day += 1
			
			State.change_time(day, time)

func _on_location_change(location: Types.Locations) -> void:
	Logger.info("changing location")
	_change_scene(choose_scene.bind(location))
	

func _on_family_tree_complete() -> void:
	State.advance_time(4)
