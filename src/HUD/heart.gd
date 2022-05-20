extends Control


func set_full(val:bool):
	if val:
		modulate = Color.white
	else:
		modulate = Color.black
