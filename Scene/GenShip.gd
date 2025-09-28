extends Button

@export var ship : String
@export var shipScale : Vector2
@export var map : Node2D
@export var limit : int

func _ready() -> void:
	pressed.connect(_spawn)
	
func _process(delta: float) -> void:
	if limit <= 0:
		icon = load(ship)
	
func _spawn():
	if limit > 0:
		limit -= 1
		
		var sprite = Sprite2D.new()
		sprite.texture = load(ship)
		sprite.scale = shipScale
		
		map.tileMap.add_child(sprite)
		map.ship = sprite
		map.placing = true
	
	if limit <= 0:
		icon = load(ship)
