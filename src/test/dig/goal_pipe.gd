extends Node2D

signal goal()

onready var anim : AnimationPlayer = $AnimationPlayer
onready var entry : Position2D = $entry


var previous : Pipe = null
var flowing = false
var spilling = false
var full = false


func _ready():
	anim.play("fill")

func _physics_process(delta):
	var spill = flowing and full
	
	
	if flowing:
		anim.advance(delta)
		emit_signal("goal")

	flowing = false

func on_fluid_out():
	full = true


func remove_prev():
	if is_instance_valid(previous):
		previous.next = null
		previous = null

func on_no_fluid_in():
	anim.play("empty_from_end")

