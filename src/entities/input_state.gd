extends Node
class_name input_state

var dir := Vector2()
var buttons := {
	jump = ButtonState.new(),
	drill = ButtonState.new(),
	bag = ButtonState.new(),
	put = ButtonState.new(),
	next_pipe = ButtonState.new(),
	prev_pipe = ButtonState.new(),
	rotate = ButtonState.new(),
	rotate_down = ButtonState.new(),
	restart = ButtonState.new()
}

func clear_just_updated():
	for button in buttons.values():
		button.just_updated = false

func clear():
	for button in buttons.values():
		button.pressed = false
		dir = Vector2()
func is_action_just_pressed(action):
	return buttons[action].is_just_pressed() 

func is_action_just_released(action):
	return buttons[action].is_just_released() 

func is_action_pressed(action):
	return buttons[action].pressed
