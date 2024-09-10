extends Control


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_T:
			var day = State.current_day
			var time = State.current_time + 1
			if time >= 24:
				time -= 24
				day += 1
			
			State.change_time(day, time)
