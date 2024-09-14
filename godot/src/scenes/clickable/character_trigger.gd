class_name CharacterTrigger extends Clickable

@export var character_id: Types.Characters
@export var outline_shader: Material 


@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	super._ready()
	assert(outline_shader != null)
	
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func _on_mouse_entered() -> void:
	sprite.material = outline_shader
	

func _on_mouse_exited() -> void:
	sprite.material = null
	
