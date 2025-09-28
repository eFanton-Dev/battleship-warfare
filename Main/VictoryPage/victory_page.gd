extends Node2D

func _on_gioca_pressed() -> void:
	get_tree().change_scene_to_file("res://Main/HomePage.tscn")
