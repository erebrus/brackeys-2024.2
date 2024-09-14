extends GameScene
@export var dialogue_start:= "the_dining_room_party"
@export var dialogue_murder:= "murder"

@export var start_timeout:= 1.0
@export var night_timeout:= 2.0
@export var murder_timeout:= 1.0
@export var murder_music_fade_in:= 0.2


func _ready() -> void:
	super._ready()
	
	await get_tree().create_timer(start_timeout).timeout
	
	DialogueManager.show_dialogue_balloon(dialogue, dialogue_start)
	await Events.dialogue_finished
	
	Globals.music_manager.fade_game_music()
	var tween = create_tween()
	tween.tween_property($Overlay, "modulate:a", 1, night_timeout)
	
	await tween.finished
	
	Globals.music_manager.fade_in_murder_music(murder_music_fade_in)
	$Murder.show()
	
	DialogueManager.show_dialogue_balloon(dialogue, dialogue_murder)
	await Events.dialogue_finished
	
	await get_tree().create_timer(murder_timeout).timeout
	
	Globals.music_manager.fade_murder_music()
	Globals.music_manager.fade_in_game_music()
	
	State.advance_day()
	
