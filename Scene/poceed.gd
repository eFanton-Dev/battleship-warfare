extends Button

@export var main : Node2D
@export var campoDX : TileMapLayer
@export var campoSX : TileMapLayer
@export var buttons : Node2D
@export var black : Sprite2D
var onSX : bool = true
var firstTurn : int = 2

func _ready() -> void:
	pressed.connect(_hide)
	
func _hide():
	black.visible = true
	
	firstTurn -= 1
	_resetValues()
	
	if onSX:
		main.tileMap = campoDX
		main.other = campoSX
		
		for child in campoSX.get_children():
			child.visible = false
		for child in campoDX.get_children():
			child.visible = true
		
		onSX = false
	else:
		main.tileMap = campoSX
		main.other = campoDX
		
		for child in campoDX.get_children():
			child.visible = false
		for child in campoSX.get_children():
			child.visible = true
			
		onSX = true

func _resetValues():
	if firstTurn > 0:
		var values = [1, 2, 2, 2, 1, 2, 3]
		var index = 0
		
		for child in buttons.get_children():
			child.limit = values[index]
			index += 1
	else:
		for child in buttons.get_children():
			child.limit = 0
	
	
