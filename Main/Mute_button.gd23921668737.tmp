extends TextureButton
	
var music = AudioServer.get_bus_index("Master")

func _on_pressed() -> void:
	AudioServer.set_bus_mute(music, not AudioServer.is_bus_mute(music))
