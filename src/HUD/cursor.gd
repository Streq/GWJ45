extends Node2D
onready var range_detect = $range_detect

onready var drill = $drill
onready var bag = $bag
onready var sprite = $Sprite

var available_action := "drill"
var captured := false
func _physics_process(delta):
	if is_within_range():
		sprite.modulate = Color.green
	else:
		sprite.modulate = Color.red
	
	if !captured:
		if drill.has_ground():
			available_action = "drill"
		else:
			available_action = "bag"

func is_within_range() -> bool:
	return range_detect.get_overlapping_areas().size()

