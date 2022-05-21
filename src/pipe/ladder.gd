extends Node2D


var up := false
var down := false
onready var sprite = $Sprite


func update_display():
	var frame = 0
	if !up:
		if !down:
			frame = 0
		else:
			frame = 1
	else:
		if down:
			frame = 2
		else:
			frame = 3
		
	sprite.frame = frame
	
	
func _on_upper_ladder_detect_area_entered(area):
	up = true
	update_display()

func _on_upper_ladder_detect_area_exited(area):
	up = false
	update_display()

func _on_lower_ladder_detect_area_entered(area):
	down = true
	update_display()

func _on_lower_ladder_detect_area_exited(area):
	down = false
	update_display()
	
