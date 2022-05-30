extends ParallaxLayer

func _physics_process(delta):
	motion_offset.x += delta*5*motion_scale.x
