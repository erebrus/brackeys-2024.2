extends TextureRect


func _ready() -> void:
	Globals.in_game=false


func _on_sound_button_toggled(toggled_on: bool) -> void:
	$sfx_button.play()
	Globals.sound_on=toggled_on


func _on_music_button_toggled(toggled_on: bool) -> void:
	$sfx_button.play()
	Globals.music_on=toggled_on


func _on_start_button_pressed() -> void:
	$sfx_button.play()
	Globals.start_game()
	
