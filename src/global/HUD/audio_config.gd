extends HBoxContainer

onready var music_bus := AudioServer.get_bus_index("music")
onready var sfx_bus := AudioServer.get_bus_index("sfx")


func _on_audio_toggled(button_pressed):
	AudioServer.set_bus_mute(sfx_bus, button_pressed)

func _on_music_toggled(button_pressed):
	AudioServer.set_bus_mute(music_bus, button_pressed)

func _on_pause_toggled(button_pressed):
	get_tree().paused = button_pressed


func _input(event):
	if event.is_action_pressed("pause"):
		$pause.pressed = !$pause.pressed
	
