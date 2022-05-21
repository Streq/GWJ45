extends Node2D


var timeout = false
var offset = 1.0
func _physics_process(delta):
	if Input.is_action_just_pressed("put"):
		position.x+=delta*offset
	
	var pipe = get_parent()
	pipe._add_tide(pipe.a, 1)
	if timeout:
		timeout = false
		var oil_drop = Factory.items.oil_drop.scene.instance()
		get_tree().current_scene.add_child(oil_drop)
		oil_drop.global_position = global_position
		oil_drop.last_entry = pipe

	
func _on_timer_timeout():
	timeout = true

