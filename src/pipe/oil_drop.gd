extends Node2D


var last_entry : PipeEntry = null
onready var particles_lifetime:Timer = $particles_lifetime
onready var particles = $CPUParticles2D
onready var sprite = $Sprite

var velocity := Vector2()

func _ready():
	particles_lifetime.connect("timeout", self, "queue_free")
	

func _physics_process(delta):
	if last_entry == null:
		velocity.y += 75.0 * delta
	else:
		var vel = last_entry.get_tide_velocity(global_position)
		var next = last_entry.get_tide_next()
#		if we are too close to next_entry for velocity to be valid
		if is_instance_valid(next) and (vel == Vector2.ZERO or 
			vel.length_squared()*delta*delta>global_position.distance_squared_to(next.global_position)): 
			call_deferred("set_last_entry", next)
		velocity = vel
		
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
#	global_position = entry.global_position

	NodeUtils.reparent_keep_transform(self, entry)

func _on_area_exited(area):
	if area.owner == last_entry and (!is_instance_valid(last_entry.a) or !is_instance_valid(last_entry.b)):
		call_deferred("exit_pipe")

func exit_pipe():
	if (!is_instance_valid(last_entry.a) or !is_instance_valid(last_entry.b)):
		last_entry = null
		NodeUtils.reparent_keep_transform(self, get_tree().current_scene)
		sprite.visible = false
		particles.emitting = true
		particles_lifetime.wait_time = particles.lifetime
		particles_lifetime.start()
		$terrain_detect/CollisionShape2D.disabled = false

func _on_terrain(body):
	queue_free()


func _on_oil_drop_input_event(viewport, event, shape_idx):
#	var vel = last_entry.get_tide_velocity(global_position)
	pass # Replace with function body.
