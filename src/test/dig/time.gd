extends Label

var timer : Timer = null

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Group.get_one("lose_timer")
	

func _process(delta):
	var time = timer.time_left
	var minutes = int(time)/60
	var seconds = fmod(time,60.0)
	text = "%02d" % minutes + ":%02d" % seconds
	if time < 10.0:
		modulate = Color.red if fmod(time, 1.0) > 0.5 else Color.white 
