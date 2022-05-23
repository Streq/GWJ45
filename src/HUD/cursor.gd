extends Node2D

func _physics_process(delta):
	if $Area2D.get_overlapping_areas().size():
		modulate = Color.green
	else:
		modulate = Color.red
