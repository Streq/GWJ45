extends Area2D

export var item_name : String
var selected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if selected:
		follow_mouse()
	$highlight.visible = selected

func _on_pick_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				for pickable in get_tree().get_nodes_in_group("pickable"):
					pickable.selected = false
			selected = event.pressed
			
		elif selected:
			var owner : Node2D = self.owner
			if event.button_index == BUTTON_RIGHT and event.pressed:
				owner.global_transform = owner.global_transform.scaled(Vector2(-1.0, 1.0))
			elif event.button_index == BUTTON_WHEEL_DOWN and event.pressed:
				owner.global_rotation_degrees += 90
			elif event.button_index == BUTTON_WHEEL_UP and event.pressed:
				owner.global_rotation_degrees -= 90

func follow_mouse():
	var mouse = get_global_mouse_position()
	owner.global_position.x = stepify(mouse.x-8.0, 16.0)+8.0
	owner.global_position.y = stepify(mouse.y-8.0, 16.0)+8.0
	
	
