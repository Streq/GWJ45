extends Node2D


var last_entry : PipeEntry = null
onready var particles_lifetime:Timer = $particles_lifetime
onready var particles = $CPUParticles2D
onready var sprite = $Sprite

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
		pass
#		if pipe_point.is_sucking():
#			call_deferred("set_last_entry", pipe_point)
	else:
		var next = last_entry.get_tide_next()
		if pipe_point == next or is_instance_valid(next) and pipe_point == next.get_tide_next():
			call_deferred("set_last_entry", pipe_point)
	
func set_last_entry(entry):
	last_entry = entry
	global_position = entry.global_position

	NodeUtils.reparent_keep_transform(self, entry)

func _on_area_exited(area):
	if area.owner == last_entry and (!is_instance_valid(last_entry.a) or !is_instance_valid(last_entry.b)):
		last_entry = null
		yield(get_tree(), "idle_frame")
		NodeUtils.reparent_keep_transform(self, get_tree().current_scene)
		sprite.visible = false
		particles.emitting = true
		particles_lifetime.wait_time = particles.lifetime
		particles_lifetime.start()
		yield(particles_lifetime, "timeout")
		queue_free()
