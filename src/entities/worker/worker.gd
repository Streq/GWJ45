extends KinematicBody2D
signal hitpoints_changed(val)
signal max_hitpoints_changed(val)


export var speed := 50.0
export var gravity := 200.0
export var jump_speed := 75.0
export var lerp_walk_speed := 10.0
export var climb_speed := 25.0
export var lerp_climb_speed := 10.0
export var hitpoints := 3 setget set_hitpoints
export var max_hitpoints := 3 setget set_max_hitpoints

onready var drill := $drill
onready var bag := $bag
onready var ladder_detector := $ladder_detector
onready var state_machine := $state_machine
onready var pivot = $pivot
onready var anim = $AnimationPlayer
onready var input = $input
onready var jump_audio = $jump
onready var land_audio = $land
onready var hurt_audio = $hurt


var velocity = Vector2()
var has_ladder = false
var grabbing_ladder := false
var air = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_hitpoints(hitpoints)
	set_max_hitpoints(max_hitpoints)
	state_machine.initialize()

func _physics_process(delta):
	var dir = input.dir
	if !grabbing_ladder:
		#fall
		velocity.y += gravity*delta
		
	
		
	has_ladder = can_grab_ladder()
	
	air = !is_on_floor()
	var fall_speed = velocity.y
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if is_on_floor() and air and fall_speed > 150.0:
		get_hurt(1, Vector2(0,-75))
		
	
	drill.position = dir*10.0
	drill.rotation = dir.angle()
	
	if input.is_action_just_released("restart"):
		get_tree().reload_current_scene()
		Global.worker_index+=1

func can_grab_ladder():
	return ladder_detector.get_overlapping_areas().size()>0

func set_hitpoints(val):
	hitpoints = clamp(val, 0, max_hitpoints)
	emit_signal("hitpoints_changed", hitpoints)
	if hitpoints == 0:
		Global.worker_index+=1
		get_tree().reload_current_scene()
	
func set_max_hitpoints(val):
	max_hitpoints = val
	emit_signal("max_hitpoints_changed", max_hitpoints)
	emit_signal("hitpoints_changed", hitpoints)
	


func _on_hurtbox_area_entered(area):
	var dirx = sign(global_position.x - area.global_position.x)
	if !dirx:
		dirx = pivot.scale.x
	else:
		pivot.scale.x = -dirx
	
	get_hurt(1, Vector2(dirx*100.0, -75.0))
	
	
func get_hurt(damage, knockback):
	self.hitpoints -= damage
	velocity = knockback
	state_machine._change_state("hurt", null)
