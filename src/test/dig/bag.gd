extends Area2D

signal picked_up(item_name, current_amount)
signal current_changed(item_name)
signal pipe_transform_changed(item_name)
signal total_changed(total,limit)
signal hit_limit()

export var limit := 5

onready var shape :CollisionShape2D = $CollisionShape2D
var pipes = {"line_pipe":0,"angle_pipe":0,"ladder":0}

var current = "line_pipe" setget set_current
var putting = false
var in_hand = null
# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("current_changed", current)

var pipe_transform := Transform2D.IDENTITY setget set_pipe_transform

func set_pipe_transform(val):
	pipe_transform = val
	emit_signal("pipe_transform_changed", pipe_transform)

func _physics_process(delta):
#	if Input.is_action_just_pressed("flip_h"):
#		self.pipe_transform = pipe_transform.scaled(Vector2(-1.0,1.0))
#
#	if Input.is_action_just_pressed("flip_v"):
#		self.pipe_transform = pipe_transform.scaled(Vector2(1.0,-1.0))
#
	if Input.is_action_just_pressed("rotate"):
		self.pipe_transform = pipe_transform.rotated(PI/2.0)
	
	if Input.is_action_just_pressed("next_pipe"):
		var items = pipes.keys()
		var index = (items.find(current) + 1)%items.size()
		self.current = items[index]
	if Input.is_action_just_pressed("bag"):
		var areas = get_overlapping_areas()
		if areas.size():
			_on_bag_area_entered(areas[-1])
	putting = Input.is_action_pressed("put")
	if Input.is_action_just_released("put") and pipes.has(current) and pipes[current]:
		var areas = get_overlapping_areas()
		if !areas.size():
			var pipe = Factory.items[current].scene.instance()
			pipe.transform = pipe_transform
			pipes[current] -= 1
			emit_signal("picked_up", current, pipes[current])
			owner.owner.add_child(pipe)
			var dest = global_position
			dest.x = stepify(dest.x-8.0, 16.0)+8.0
			dest.y = stepify(dest.y-8.0, 16.0)+8.0
			pipe.global_position = dest
			emit_signal("total_changed", get_count(), limit)

func _on_bag_area_entered(area: Area2D):
	var item = area.item_name
	if get_count() < limit:
		if !pipes.has(item):
			pipes[item] = 0
		pipes[item] += 1
		area.owner.queue_free()
		emit_signal("picked_up", item, pipes[item])
		emit_signal("total_changed", get_count(), limit)
	else:
		emit_signal("hit_limit")

func set_current(val):
	current = val
	emit_signal("current_changed", current)
	
func get_count():
	var ret := 0
	for value in pipes.values():
		ret += value
	return ret
