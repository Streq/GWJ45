extends KinematicBody2D

var velocity = Vector2()
export var speed := 100.0
export var gravity := 200.0
export var jump_speed := 200.0
export var lerp_walk_speed := 10.0

onready var drill := $drill


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	velocity.y += gravity*delta
	var dir = InputUtils.get_input_dir()
	velocity.x = lerp(velocity.x, speed*dir.x, delta*lerp_walk_speed)
	if is_on_floor() and dir.y<0:
		velocity.y -= jump_speed
	velocity = move_and_slide(velocity, Vector2.UP)
	
	drill.position = dir*4.0
	
