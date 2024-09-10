extends MarginContainer


@onready var container: Container = %CluesContainer


func open(clues: Array[String]) -> void:
	for child in container.get_children():
		child.queue_free()
	
	if clues.is_empty():
		_add_clue("I know nothing about this person.")
		
	
	for clue in clues:
		_add_clue(clue)
		
	show()
	

func close() -> void:
	hide()
	
	for child in container.get_children():
		child.queue_free()
	

func _add_clue(clue: String) -> void:
	var label = Label.new()
	label.text = clue
	container.add_child(label)
	
