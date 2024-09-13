extends GameScene


func _ready() -> void:
	super._ready()
	# TODO: should we change music?
	
	await get_tree().create_timer(1).timeout
	
	DialogueManager.show_dialogue_balloon(dialogue, "the_dining_room_party")
	
	await Events.dialogue_finished
	
	# TODO: murder cutscene
	
