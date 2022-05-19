extends Node2D

signal goal()

func _on_pipe_point_area_entered(area):
	emit_signal("goal")
