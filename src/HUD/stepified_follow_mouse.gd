extends Node

func _physics_process(delta):
	follow_mouse()
func follow_mouse():
	var mouse = owner.get_global_mouse_position()
	owner.global_position.x = stepify(mouse.x-8.0, 16.0)+8.0
	owner.global_position.y = stepify(mouse.y-8.0, 16.0)+8.0

