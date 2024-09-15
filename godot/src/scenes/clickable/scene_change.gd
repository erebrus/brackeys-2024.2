extends Clickable


@export var target_location: Types.Locations


func _ready() -> void:
	super._ready()
	clicked.connect(_on_clicked)
	
	mouse_entered.connect(Events.show_tootip.emit.bind(target_location))
	mouse_exited.connect(Events.hide_tooltip.emit)
	

func _on_clicked() -> void:
	if Globals.in_dialogue:
		return
	Logger.info("Clicked location change: %s" % Types.Locations.keys()[target_location])
	Events.request_location_change.emit(target_location)
