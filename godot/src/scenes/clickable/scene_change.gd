extends Clickable


@export var target_location: Types.Locations


func _ready() -> void:
	super._ready()
	clicked.connect(_on_clicked)
	

func _on_clicked() -> void:
	Logger.info("Clicked location change: %s" % Types.Locations.keys()[target_location])
	Events.request_location_change.emit(target_location)
