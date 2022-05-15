extends Node2D
class_name Pipe

onready var anim : AnimationPlayer = $AnimationPlayer

var previous : Pipe = null
var next : Pipe = null

onready var entry : Position2D = $entry
onready var exit : Position2D = $exit
onready var particles : CPUParticles2D = $exit/CPUParticles2D

func on_fluid_in():
	anim.play("fill")
	
func on_fluid_out():
	if is_instance_valid(next):
		next.on_fluid_in()
	else:
		particles.emitting = true

func add_next(pipe):
	next = pipe
	next.global_rotation = exit.global_rotation
	next.global_position = exit.global_position - (next.entry.global_position - next.global_position)
	
	
