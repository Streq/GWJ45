extends Node2D


var last_entry : PipeEntry = null

var velocity := Vector2()
func _physics_process(delta):
	if last_entry == null:
		velocity.y += 100.0 * delta
	else:
		velocity = last_entry.get_tide_velocity()
		
	global_position += velocity * delta


func _on_area_entered(area : Area2D):
	var pipe_point = area.owner
	if !is_instance_valid(last_entry):
		if pipe_point.is_sucking():
			set_last_entry(pipe_point)
	else:
		var next = last_entry.get_tide_next()
		if pipe_point == next or is_instance_valid(next) and pipe_point == next.get_tide_next():
			set_last_entry(pipe_point)
	
func set_last_entry(entry):
	last_entry = entry
	NodeUtils.reparent(self, entry)

func _on_area_exited(area):
	if area.owner == last_entry and last_entry.get_tide_next() == null:
		last_entry = null
		NodeUtils.reparent(self, get_tree().current_scene)
