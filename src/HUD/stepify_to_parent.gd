extends Node

func _physics_process(delta):
	follow_parent()
func follow_parent():
	var parent = owner.get_parent().global_position
	owner.global_position.x = stepify(parent.x-8.0, 16.0)+8.0
	owner.global_position.y = stepify(parent.y-8.0, 16.0)+8.0

