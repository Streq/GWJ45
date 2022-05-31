extends Node

onready var camera : Camera2D = get_parent()
onready var tween : Tween = $Tween
onready var frequency : Timer = $frequency
onready var duration : Timer = $duration


var amplitude = 0

func _ready():
	start()

func start(duration := 0.2, frequency := 15, amplitude := 16):
	self.amplitude = amplitude
	self.duration.wait_time = duration
	self.frequency.wait_time = 1.0/float(frequency)
	
	self.duration.start()
	self.frequency.start()

var flip = false
func single_shake():
	var rand = Vector2()
	rand.x = amplitude * Bool.sign(flip)
	flip = !flip
#	rand.x = rand_range(-amplitude, amplitude)
#	rand.y = rand_range(-amplitude, amplitude)
	
	tween.interpolate_property(camera, "offset", camera.offset, rand, frequency.wait_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()




func _on_frequency_timeout():
	single_shake()


func _on_duration_timeout():
	frequency.stop()
	tween.interpolate_property(camera, "offset", camera.offset, Vector2.ZERO, frequency.wait_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
