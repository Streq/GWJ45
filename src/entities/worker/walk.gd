extends State


# Initialize the state. E.g. change the animation
func _enter(params):
	owner.anim.play("walk")

# Clean up the state. Reinitialize values like a timer
func _exit():
	return

# Called during _process
func _update(delta: float):
	return

# Called during _physics_process
func _physics_update(delta: float):
	var input = owner.input
	if owner.is_on_floor():
		if owner.has_ladder and input.dir.y<0:
			emit_signal("finish", "ladder", null)
		elif input.is_action_just_pressed("jump"):
			goto("jump")
		elif input.dir.x:
			owner.pivot.scale.x = sign(input.dir.x)
			owner.velocity.x = lerp(owner.velocity.x, owner.speed*input.dir.x, delta*owner.lerp_walk_speed)
		else:
			emit_signal("finish", "idle", null)
	else:
		emit_signal("finish", "air", null)
	
	
# Called during _input
func _handle_input(event: InputEvent):
	return
