class_name InputUtils

static func get_input_dir() -> Vector2:
	return Vector2(
		float(Input.is_action_pressed("right")) - float(Input.is_action_pressed("left")),
		float(Input.is_action_pressed("down")) - float(Input.is_action_pressed("up"))
	)

static func get_dist_to_mouse(node:CanvasItem) -> Vector2:
	var mouse_viewport_position := node.get_viewport().get_mouse_position()
	var node_viewport_position := node.get_global_transform_with_canvas().origin
	return mouse_viewport_position-node_viewport_position
