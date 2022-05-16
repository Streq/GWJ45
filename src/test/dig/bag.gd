extends Area2D


onready var shape :CollisionShape2D = $CollisionShape2D
var pipes = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if Input.is_action_just_pressed("bag"):
		var areas = get_overlapping_areas()
		if areas.size():
			for area in areas:
				_on_bag_area_entered(area)
		elif pipes.size():
			var pipe = pipes.pop_back()
			owner.owner.add_child(pipe)
			var dest = global_position
			dest.x = stepify(dest.x-8.0, 16.0)+8.0
			dest.y = stepify(dest.y-8.0, 16.0)+8.0
			pipe.global_position = dest
func _on_bag_area_entered(area: Area2D):
	pipes.append(area.owner)
	area.owner.get_parent().remove_child(area.owner)
