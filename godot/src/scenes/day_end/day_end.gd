extends GameScene

signal on_murder

@export var dialogue_start:= "the_dining_room_party"

@export var start_timeout:= 1.0
@export var night_timeout:= 2.0
@export var murder_timeout:= 1.0
@export var murder_music_fade_in:= 0.2
@export var murder_ambience_fade_in := 6.0
@export var intro: DialogueResource

var done := false
#var dialog_ready :=false 
#var dialog_done :=false 
func _ready() -> void:
	#super._ready()
	
	await get_tree().create_timer(start_timeout).timeout
	if dialogue:
		DialogueManager.show_dialogue_balloon(dialogue, dialogue_start)
		await Events.dialogue_finished
	
	Globals.music_manager.fade_game_music()
	Globals.music_manager.fade_in_stream(ambience, murder_ambience_fade_in)
	
	
	var tween = create_tween()
	tween.tween_property($Overlay, "modulate:a", 1, night_timeout)
	
	await tween.finished
	on_murder.emit()
	
	Globals.music_manager.fade_in_murder_music(murder_music_fade_in)
	$Murder.show()
	
	await get_tree().create_timer(murder_timeout).timeout

	if intro:
			DialogueManager.show_dialogue_balloon(intro, "start")
			Events.dialogue_finished.connect(mark_as_done)
	#done = true
	
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
