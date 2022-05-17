extends Node2D
class_name Pipe

onready var anim : AnimationPlayer = $AnimationPlayer
onready var entry : Position2D = $entry
onready var exit : Position2D = $exit
onready var exit_area : Area2D = $exit/Area2D
onready var particles : CPUParticles2D = $exit/CPUParticles2D


var previous : Pipe = null
var next : Pipe = null
var flowing = false
var spilling = false
var full = false


func _ready():
	anim.play("fill")

func _physics_process(delta):
	var spill = flowing and full
	var has_next = is_instance_valid(next)
	if has_next:
		next.flowing = spill
	else:
		for pipe_area in exit_area.get_overlapping_areas():
			_on_exit_area_entered(pipe_area)
	particles.emitting = !has_next and spill
	
	if flowing:
		anim.advance(delta)
	flowing = false

func on_fluid_out():
	full = true


func add_next(pipe):
	next = pipe
	pipe.previous = self
#	next.global_rotation = exit.global_rotation
#	next.global_position = exit.global_position - (next.entry.global_position - next.global_position)
	
func remove_next():
	if is_instance_valid(next):
		next.previous = null
		next = null

func remove_prev():
	if is_instance_valid(previous):
		previous.next = null
		previous = null

func on_no_fluid_in():
	anim.play("empty_from_end")

func _on_exit_area_entered(area):
	if !is_instance_valid(next) and !is_instance_valid(area.owner.previous):
		call_deferred("add_next", area.owner)

func _on_exit_area_exited(area):
	if area.owner == next:
		call_deferred("remove_next")

#func _exit_tree():
#	remove_prev()
#	remove_next()
