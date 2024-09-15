extends "res://src/scenes/day_end/day_end.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()



func _on_on_murder() -> void:
	$death_sfx.play()
