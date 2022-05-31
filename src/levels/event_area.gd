extends Area2D

export (NodePath) onready var gusano = get_node(gusano) as Node2D

export (NodePath) onready var camera1 = get_node(camera1) as Camera2D
export (NodePath) onready var camera2 = get_node(camera2) as Camera2D

var triggered = false

func _ready():
	camera2.set_physics_process(false)
	camera2.set_physics_process_internal(false)

func _on_event_area_area_entered(area):
	if !triggered:
		camera2.current = true
		
		triggered = true
		gusano.step()
		yield(gusano,"step")
		yield(gusano,"step")
		yield(gusano,"step")
		yield(gusano,"step")
		camera2.set_physics_process(true)
		camera2.set_physics_process_internal(true)
		
		
