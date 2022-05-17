extends KinematicBody2D

var velocity = Vector2()
export var speed := 50.0
export var gravity := 200.0
export var jump_speed := 75.0
export var lerp_walk_speed := 10.0
export var climb_speed := 25.0
export var lerp_climb_speed := 10.0

onready var drill := $drill
onready var bag := $bag
onready var ladder_detector := $ladder_detector

var grabbing_ladder := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	var dir = InputUtils.get_input_dir()
	if !grabbing_ladder:
		#fall
		velocity.y += gravity*delta
	else:
		#move in ladder
		velocity.y = lerp(velocity.y, climb_speed*dir.y, delta*lerp_climb_speed)
	
	velocity.x = lerp(velocity.x, speed*dir.x, delta*lerp_walk_speed)
	
	if is_on_floor() and dir.y<0:
		velocity.y -= jump_speed
	
	var has_ladder = can_grab_ladder()
	if has_ladder:
		if dir.y:
			grabbing_ladder = true
	else:
		grabbing_ladder = false
	
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
	drill.position = dir*4.0
	
func can_grab_ladder():
	return ladder_detector.get_overlapping_areas().size()>0
	
