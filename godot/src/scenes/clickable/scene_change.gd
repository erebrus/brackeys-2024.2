extends Clickable


@export var target_location: Types.Locations


func _ready() -> void:
	super._ready()
	clicked.connect(Events.request_location_change.emit.bind(target_location))
	
