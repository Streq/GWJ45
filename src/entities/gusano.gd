extends Node2D
signal step()
signal rumble(duration, frequency, amplitude)

onready var tween = $Tween
onready var tongue = $tongue
onready var growl_sound := $growl_sound
onready var step_sound := $step_sound
onready var tongue_sound := $tongue_sound
onready var tongue_sound2 := $tongue_sound2

const IDLE := 0
const STEP_FORWARD := 1

var state := IDLE

export var speed := 0.125
export var idle_time := 0.25
export var step_distance := 16
export var pause_after_stop := 2.0
export var tongue_distance := 16.0*8.0
export var tongue_speed_rate := 1.0
var stop = false

func step():
	growl_sound.play()
	emit_signal("rumble", 1.0, 7, 8.0)
	yield(get_tree().create_timer(2.0), "timeout")
	
	
	while !stop:
		state = STEP_FORWARD
		tween.interpolate_property(self, "position", position, position + Vector2(step_distance, 0), speed)
		tween.start()
		yield(tween, "tween_all_completed")
		emit_signal("step")
		step_sound.play()
		emit_signal("rumble", idle_time, 15, 2.0)
		state = IDLE
		yield(get_tree().create_timer(idle_time), "timeout")
		
	yield(get_tree().create_timer(pause_after_stop), "timeout")
	tongue_sound2.play()
	tween.interpolate_property(tongue, "position", tongue.position, tongue.position + Vector2(tongue_distance, 0), tongue_speed_rate)
	tween.start()
	yield(tween, "tween_all_completed")
	tween.interpolate_property(tongue, "position", tongue.position, tongue.position - Vector2(tongue_distance, 0), tongue_speed_rate*2)
	tween.start()
	
	


func _on_stop_detector_area_entered(area):
	stop = true
