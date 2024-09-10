extends PanelContainer

const START_DAY = 18

func _ready() -> void:
	Events.time_changed.connect(_on_time_changed)
	%DayLabel.text = str(START_DAY + State.current_day)
	

func _on_time_changed(day: int, _time: int) -> void:
	%DayLabel.text = str(START_DAY + day)
