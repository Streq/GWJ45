class_name PhysicsUtils

static func anything_overlaps(where: Area2D):
	var query_results = query_overlaps(where)
	return query_results.size()!=0
	
static func query_overlaps(where: Area2D):
	# initialize parameters for query
	var params = Physics2DShapeQueryParameters.new()
	#assuming single shape area
	var shape = where.shape_owner_get_shape(0,0)
	var shape_owner = where.shape_owner_get_owner(0)
	params.set_shape(shape) 
	params.transform = shape_owner.global_transform
	params.collision_layer = where.collision_mask
	params.collide_with_bodies = true
	params.collide_with_areas = true

	# do query
	var space_state = where.get_world_2d().direct_space_state
	var query_results = space_state.intersect_shape(params)
	return query_results
