extends State


# Initialize the state. E.g. change the animation
func _enter(params):
	owner.anim.play("land")
	owner.anim.connect("animation_finished", self, "_on_animation_finished")
	owner.land_audio.play()
	
# Clean up the state. Reinitialize values like a timer
func _exit():
	owner.anim.disconnect("animation_finished", self, "_on_animation_finished")
	
# Called during _process
func _update(delta: float):
	return

# Called during _physics_process
func _physics_update(delta: float):
	var input = owner.input
	if owner.is_on_floor():
		owner.velocity.x = lerp(owner.velocity.x, owner.speed*input.dir.x, delta*owner.lerp_walk_speed)
	else:
		goto("air")

func _on_animation_finished(name):
	goto("idle")
	
# Called during _input
func _handle_input(event: InputEvent):
	return
