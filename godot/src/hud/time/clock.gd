extends TextureRect


func _ready() -> void:
	Events.time_changed.connect(_on_time_changed)
	_set_time(State.current_time)
	

func _set_time(time: int) -> void:
	if time < 12:
		%Label.text = "AM"
	else:
		%Label.text = "PM"
		time -= 12
	
	%SmallNeedle.rotation = PI / 6 * time
	

func _on_time_changed(_day: int, time: int) -> void:
	_set_time(time)
