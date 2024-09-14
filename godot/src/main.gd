extends Node

@onready var current_scene: GameScene = %StartScene
@onready var family_tree: FamilyTree = %FamilyTree


func _ready() -> void:
	Events.request_location_change.connect(change_scene)
	#current_scene.ambience.play()
	Globals.music_manager.fade_in_stream(current_scene.ambience)


func change_scene(location: Types.Locations) -> void:
	# TODO: start fade to black
	#Globals.music_manager.fade_stream(current_scene.ambience,.5)
	current_scene.ambience.stop()
	var target = choose_scene(location).instantiate()
	
	# TODO: wait until is black
	
	current_scene.queue_free()
	add_child(target)
	move_child(target, 0)
	
	#
	await current_scene.tree_exited
	current_scene = target
	Logger.info("Entered location: %s" % Types.Locations.keys()[location])
	Globals.music_manager.change_game_music_to(get_music_for_location(location))
	Globals.music_manager.fade_in_stream(current_scene.ambience,.5)
	# TODO: fade in
	
	
#TODO complete and move this
func get_music_for_location(location:Types.Locations):
	if State.current_day>1:
		return Types.GameMusic.STORM
	match location:
		Types.Locations.Garden:
			return Types.GameMusic.CALM
		_:
			return Types.GameMusic.DINING
		 
	

func choose_scene(location: Types.Locations) -> PackedScene:
	# TODO: choose scene based on location and time of day?
	
	var path = "res://src/scenes/%s/%s_day_%s.tscn"
	var location_name = Types.Locations.keys()[location].to_lower()
	
	return load(path % [location_name, location_name, State.current_day])
	

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
