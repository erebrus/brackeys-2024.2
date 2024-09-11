extends Clickable

@export var dialogue: DialogueResource
@export var dialogue_title: String = "start"


func _ready() -> void:
	super._ready()
	
	assert(dialogue != null)
	clicked.connect(start_dialogue)
	

func start_dialogue() -> void:
	DialogueManager.show_dialogue_balloon(dialogue, dialogue_title)
	
