extends Node2D
onready var range_detect = $range_detect

onready var drill = $drill
onready var bag = $bag

var available_action := "drill"

func _physics_process(delta):
	if is_within_range():
		modulate = Color.green
	else:
		modulate = Color.red
	
	if drill.has_ground():
		available_action = "drill"
	else:
		available_action = "bag"

func is_within_range() -> bool:
	return range_detect.get_overlapping_areas().size()

