extends KinematicBody2D

var velocity = Vector2()
export var speed := 50.0
export var gravity := 200.0
export var jump_speed := 75.0
export var lerp_walk_speed := 10.0
export var climb_speed := 25.0
export var lerp_climb_speed := 10.0

onready var ladder_detector := $ladder_detector
onready var input_state := $input_state
onready var anim := $AnimationPlayer
onready var pivot := $pivot
onready var state_machine := $state_machine
var grabbing_ladder := false

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine.initialize()


func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	
func can_grab_ladder():
	return ladder_detector.get_overlapping_areas().size()>0
	
