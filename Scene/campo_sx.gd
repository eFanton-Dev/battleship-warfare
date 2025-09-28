extends Node2D

@export var ship : Sprite2D
@export var tileMap : TileMapLayer
@export var other : TileMapLayer
@export var splash : AnimatedSprite2D
@export var explosion : AnimatedSprite2D
@export var placing : bool = false
@export var attack : bool = false
var viewport : Viewport
var scopeCreated : bool = false

func checkCell():
	var mouse_tile = viewport.get_mouse_position()
	
	var map_pos = tileMap.local_to_map(mouse_tile)
	
	var coo = tileMap.map_to_local(map_pos)
		
	ship.position = to_global(coo)
	
func _ready() -> void:
	viewport = get_viewport()
	
func _process(delta: float) -> void:
	if attack and !scopeCreated:
		ship = Sprite2D.new()
		ship.texture = load("res://Assets/Scope.png")
		add_child(ship)
		scopeCreated = true
		placing = true
		
	if placing:
		checkCell()
	
	if Input.is_action_pressed("Place"):
		if attack and placing:
			var mouse_tile = viewport.get_mouse_position()
			var map_pos = tileMap.local_to_map(mouse_tile)
			checkCoo(map_pos)
			
		placing = false
		

func checkCoo(coo : Vector2):
	for child in other.get_children():
		var map_pos = other.local_to_map(child.position)
		if coo == Vector2(map_pos):
			var anim_coo = other.map_to_local(coo)
			startExplosion(to_global(anim_coo))
			createCross("res://Assets/HitCross.png", anim_coo)
			other.remove_child(child)
			if other.get_children().size() == 0:
				get_tree().change_scene_to_file("res://Main/VictoryPage/VictoryPage.tscn")
			return
		else:
			var anim_coo = other.map_to_local(coo)
			startSplash(to_global(anim_coo))
			
			createCross("res://Assets/MissedCross.png", anim_coo)

func startSplash(pos : Vector2):
	splash.visible = true
	splash.position = pos
	splash.play()
	
func startExplosion(pos : Vector2):
	explosion.visible = true
	explosion.position = pos
	explosion.play()
	
func createCross(path : String, coo : Vector2):
	var cross = Sprite2D.new()
	cross.texture = load(path)
	cross.position = coo
	cross.scale = Vector2(0.1, 0.1)
	cross.z_index = 2
	tileMap.add_child(cross)

func checkWin():
	if other.get_children().is_empty() and attack:
		get_tree().quit()
