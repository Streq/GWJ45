extends KinematicBody2D
signal hitpoints_changed(val)
signal max_hitpoints_changed(val)


var velocity = Vector2()
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

var grabbing_ladder := false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_hitpoints(hitpoints)
	set_max_hitpoints(max_hitpoints)
	state_machine.initialize()


func _physics_process(delta):
	var dir = InputUtils.get_input_dir()
	if !grabbing_ladder:
		#fall
		velocity.y += gravity*delta
	else:
		#move in ladder
		velocity.y = lerp(velocity.y, climb_speed*dir.y, delta*lerp_climb_speed)
	
	velocity.x = lerp(velocity.x, speed*dir.x, delta*lerp_walk_speed)
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y -= jump_speed
		
	var has_ladder = can_grab_ladder()
	if has_ladder:
		if dir.y:
			grabbing_ladder = true
	else:
		grabbing_ladder = false
	
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	drill.position = dir*10.0
	drill.rotation = dir.angle()
	
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
func can_grab_ladder():
	return ladder_detector.get_overlapping_areas().size()>0

func set_hitpoints(val):
	hitpoints = clamp(val, 0, max_hitpoints)
	emit_signal("hitpoints_changed", hitpoints)


func set_max_hitpoints(val):
	max_hitpoints = val
	emit_signal("max_hitpoints_changed", max_hitpoints)
	emit_signal("hitpoints_changed", hitpoints)
	


func _on_hurtbox_area_entered(area):
	self.hitpoints -= 1
	state_machine._change_state("hurt", null)
	var dirx = sign(global_position.x - area.global_position.x)
	if !dirx:
		dirx = pivot.scale.x
	else:
		pivot.scale.x = -dirx
	velocity.y -= 75.0
	velocity.x += dirx*100.0
	
