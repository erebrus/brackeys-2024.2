class_name Character extends Resource


signal discovered


@export var id: Types.Characters
@export var name: String = "Unknown"
@export var portrait: Texture = preload("res://assets/gfx/portraits/person_unknown.png")

@export var is_discovered:= false
@export var is_dead:= false


func discover() -> void:
	if is_discovered:
		return
	
	is_discovered = true
	discovered.emit()
	

func _to_string() -> String:
	return name
