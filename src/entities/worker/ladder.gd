extends State

var init_anim_speed = 0.0
# Initialize the state. E.g. change the animation
func _enter(params):
	owner.anim.play("ladder")
	owner.grabbing_ladder = true
	init_anim_speed = owner.anim.playback_speed

# Clean up the state. Reinitialize values like a timer
func _exit():
	owner.grabbing_ladder = false
	owner.anim.playback_speed = init_anim_speed

# Called during _process
func _update(delta: float):
	return

# Called during _physics_process
func _physics_update(delta: float):
	var input = owner.input
	if !owner.has_ladder or input.is_action_just_pressed("jump") and !input.dir.y:
		goto("air")
	else:
		owner.velocity = lerp(owner.velocity, input.dir*owner.climb_speed, delta*owner.lerp_climb_speed)
		if owner.is_on_floor() and input.dir.y>0:
			goto("idle")
		var a = owner.anim as AnimationPlayer
		a.playback_speed = input.dir.y if input.dir.y else abs(input.dir.x)
		
		
	
	
# Called during _input
func _handle_input(event: InputEvent):
	return
