extends Button

@export var main : Node2D
var firstTurn : int = 1

func _pressed() -> void:
	get_parent().visible = false
	
	if firstTurn <= 0:
		main.attack = true
		main.placing = true
	else:
		firstTurn -= 1
