extends Node2D


onready var terrain_detect = $terrain_detect
var timeout = false
var offset = 1.0
func _physics_process(delta):
	if Input.is_action_just_pressed("put"):
		position.x+=delta*offset
	
	var pipe = get_parent()
	pipe._add_tide(pipe.a, 1)
	if timeout:
		timeout = false
		if terrain_detect.get_overlapping_bodies().size() == 0:
			var oil_drop = Factory.items.oil_drop.scene.instance()
			get_tree().current_scene.add_child(oil_drop)
			oil_drop.global_position = global_position
			oil_drop.last_entry = pipe

	
func _on_timer_timeout():
	timeout = true


func _on_terrain_detect_body_entered(body):
	pass # Replace with function body.


func _on_terrain_detect_body_exited(body):
	pass # Replace with function body.
