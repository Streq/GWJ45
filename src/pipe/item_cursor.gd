extends Node2D

var can_put := true setget set_can_put

func can_put(where: Area2D):
	# initialize parameters for query
	var params = Physics2DShapeQueryParameters.new()
	var shape = where.shape_owner_get_shape(0,0)
	var shape_owner = where.shape_owner_get_owner(0)
	params.set_shape(shape) 
	params.transform = shape_owner.global_transform
	params.collision_layer = where.collision_mask
	params.collide_with_bodies = true
	params.collide_with_areas = true

	# do query
	var space_state = get_world_2d().direct_space_state
	var query_results = space_state.intersect_shape(params)
	return query_results.size()==0
	
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
	set_can_put(has_needed and !has_blacklisted)  
	
