class_name Clickable extends Area2D

signal clicked

@export var outline_shader: Material 
@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	assert(outline_shader != null)
	
	input_event.connect(_on_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	

func _on_mouse_entered() -> void:
	sprite.material = outline_shader
	

func _on_mouse_exited() -> void:
	sprite.material = null
	

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released("left_click"):
		clicked.emit()
	
