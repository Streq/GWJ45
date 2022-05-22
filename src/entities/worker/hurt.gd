extends State

var first_frame = true
# Initialize the state. E.g. change the animation
func _enter(params):
	owner.anim.play("hurt")
	first_frame = true
	owner.hurt_audio.play()

# Clean up the state. Reinitialize values like a timer
func _exit():
	return

# Called during _process
func _update(delta: float):
	return

# Called during _physics_process
func _physics_update(delta: float):
	var input = owner.input
	if owner.is_on_floor() and !first_frame:
		emit_signal("finish", "idle", null)
	first_frame = false
	
# Called during _input
func _handle_input(event: InputEvent):
	return
