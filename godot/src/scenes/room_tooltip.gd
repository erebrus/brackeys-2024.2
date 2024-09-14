extends TextureRect

func _ready() -> void:
	Events.show_tootip.connect(_on_tooltip)
	Events.hide_tooltip.connect(_on_hide)
	

func _on_tooltip(location: Types.Locations) -> void:
	match location:
		Types.Locations.LivingRoom:
			%Label.text = "Living Room"
		Types.Locations.DiningRoom:
			%Label.text = "Dining Room"
		_:
			%Label.text = Types.Locations.keys()[location]
	show()
	

func _on_hide() -> void:
	hide()
