extends GameScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#super._ready()	
	Globals.music_manager.fade_in_stream(ambience, .5)
	Globals.music_manager.fade_game_music()
	DialogueManager.show_dialogue_balloon(dialogue, "start")
