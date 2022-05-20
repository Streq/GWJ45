extends Node


func _physics_process(delta):
	var input = owner.input_state
	input.jump = Input.is_action_pressed("bag")
	input.attack = Input.is_action_pressed("drill")
	input.dir = InputUtils.get_input_dir()
