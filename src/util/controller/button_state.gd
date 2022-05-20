extends Reference
class_name ButtonState

var pressed := false
var just_updated := false

func set_pressed(val:bool):
	just_updated = pressed!=val
	pressed = val
