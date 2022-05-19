extends Node2D

signal goal()

var goal_reached = false

func _on_pipe_point_area_entered(area):
	if !goal_reached:
		goal_reached = true
		emit_signal("goal")
	area.queue_free()
