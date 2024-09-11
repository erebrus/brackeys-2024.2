extends Area2D

@export var dialogue: DialogueResource
@export var dialogue_title: String = "start"

func _ready() -> void:
	assert(dialogue != null)
	input_event.connect(_on_input_event)
	

func start_dialogue() -> void:
	DialogueManager.show_dialogue_balloon(dialogue, dialogue_title)
	

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released("left_click"):
		start_dialogue()
	
