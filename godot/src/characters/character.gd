class_name Character extends Resource


@export var name: String = "Unknown"
@export var portrait: Texture = preload("res://assets/gfx/portraits/person_unknown.png")


func _to_string() -> String:
	return name
