extends Node2D

var can_put := true setget set_can_put

var cursor


	
func _enter_tree():
	modulate = Color(0,1,0,1)

func set_can_put(val):
	if can_put != val:
		if val:
			modulate = Color(0,1,0,1)
		else:
			modulate = Color(1,0,0,1)
	can_put = val
	

func _physics_process(delta):
	var has_needed = true
	for detector in $needed_detectors.get_children():
		if detector.get_overlapping_areas().size()==0 and detector.get_overlapping_bodies().size()==0:
			has_needed = false
			break
	var has_blacklisted = false
	for detector in $blacklist_detectors.get_children():
		if detector.get_overlapping_areas().size()>0 or detector.get_overlapping_bodies().size()>0:
			has_blacklisted = true
			break
	set_can_put(has_needed and !has_blacklisted and cursor.is_within_range())  
	
