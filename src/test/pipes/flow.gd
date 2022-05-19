extends Node2D

func _physics_process(delta):
	var pipe = get_parent()
	pipe._add_tide(pipe.a, 1)
	
func _on_timer_timeout():
	var oil_drop = Factory.items.oil_drop.scene.instance()
	get_tree().current_scene.add_child(oil_drop)
	oil_drop.global_position = global_position
	var pipe = get_parent()
	oil_drop.last_entry = pipe
