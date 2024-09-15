extends MarginContainer


@onready var container: Container = %CluesContainer


func open(clues: Array[String]) -> void:
	for child in container.get_children():
		child.queue_free()
	
	#for i in 6:
		#_add_clue("vanda_day3_money")
	for clue in clues:
		_add_clue(clue)
		
	show()
	

func close() -> void:
	hide()
	
	for child in container.get_children():
		child.queue_free()
	

func scroll(distance):
	%ScrollContainer.scroll_vertical += distance
	

func _add_clue(clue_key: String) -> void:
	var label = Label.new()
	label.text = State.clues[clue_key]
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	container.add_child(label)
	
