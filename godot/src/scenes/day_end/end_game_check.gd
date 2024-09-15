extends "res://src/scenes/day_end/day_end.gd"

@export var win_intro: DialogueResource

func _ready() -> void:
	
	await get_tree().create_timer(start_timeout).timeout
	if dialogue:
		DialogueManager.show_dialogue_balloon(dialogue, dialogue_start)
		await Events.dialogue_finished
	
	Globals.music_manager.fade_game_music()
	Globals.music_manager.fade_in_stream(ambience, murder_ambience_fade_in)
	
	
	var tween = create_tween()
	tween.tween_property($Overlay, "modulate:a", 1, night_timeout)
	
	await tween.finished
	if not State.win:
		$death_sfx.play()
		
		Globals.music_manager.fade_in_murder_music(murder_music_fade_in)
		$Murder.show()
		
		await get_tree().create_timer(murder_timeout).timeout

		if intro:
				DialogueManager.show_dialogue_balloon(intro, "start")
				Events.dialogue_finished.connect(mark_as_done)
	else:
		$Win.show()
		$win_sfx.play()
		Globals.music_manager.fade_stream(ambience, .5)
		Globals.music_manager.fade_game_music()
		DialogueManager.show_dialogue_balloon(win_intro, "start")

	
func mark_as_done():
	Events.dialogue_finished.disconnect(mark_as_done)
	done = true
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		if done:
			Globals.music_manager.fade_murder_music()
			Globals.music_manager.fade_in_game_music()
		
			State.advance_day()
		#elif not dialog_done:
			#dialog_done=true
			#if intro:
				#DialogueManager.show_dialogue_balloon(intro, "start")
				#Events.dialogue_finished.connect(mark_as_done)
