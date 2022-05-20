extends State


# Initialize the state. E.g. change the animation
func _enter(params):
	owner.anim.play("idle")

# Clean up the state. Reinitialize values like a timer
func _exit():
	return

# Called during _process
func _update(delta: float):
	return

# Called during _physics_process
func _physics_update(delta: float):
	var input_state = owner.input_state
	var dir = input_state.dir
	if dir.x:
		owner.pivot.scale.x = dir.x
		emit_signal("finish", "walk", null)
	owner.velocity.y += owner.gravity*delta
	owner.velocity.x = lerp(owner.velocity.x, 0.0, owner.lerp_walk_speed*delta)
	if input_state.jump and owner.is_on_floor():
		owner.velocity.y -= owner.jump_speed
# Called during _input
func _handle_input(event: InputEvent):
	return
