extends MarginContainer


@onready var container: Container = %CluesContainer


func open(clues: Array[String]) -> void:
	for child in container.get_children():
		child.queue_free()
	
	for clue in clues:
		_add_clue(clue)
		
	show()
	

func close() -> void:
	hide()
	
	for child in container.get_children():
		child.queue_free()
	

func _add_clue(clue_key: String) -> void:
	var label = Label.new()
	label.text = State.clues[clue_key]
	container.add_child(label)
	
