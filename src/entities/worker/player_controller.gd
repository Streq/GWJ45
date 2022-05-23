extends Node

var input = null


func _ready():
	owner.connect("ready", self, "setup")
	
func setup():
	input = owner.input

func _physics_process(delta):
	input.clear_just_updated()
	for action in input.buttons:
		var button = input.buttons[action]
		button.pressed = Input.is_action_pressed(action)
		#for mouse wheel inputs
		if Input.is_action_just_released(action):
			button.just_updated = true
	input.dir = InputUtils.get_input_dir()
