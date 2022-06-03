extends Area2D

signal picked_up(item_name, current_amount)
signal current_changed(item_name)
signal pipe_transform_changed(item_name)
signal total_changed(total,limit)
signal hit_limit()

export var limit := 5

onready var shape : CollisionShape2D = $CollisionShape2D
onready var put_sound = $put_sound
onready var rotate_sound = $rotate_sound
onready var full_bag_sound = $full_bag_sound
onready var put_detect = $put_detect
var enabled = true
var pipes = {"line_pipe":0,"angle_pipe":0,"ladder":0}
var cursors = {}


var current = "line_pipe" setget set_current
var putting = false
var in_hand = null
var pipe_transform := Transform2D.IDENTITY setget set_pipe_transform



# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("current_changed", current)
		
func _enter_tree():
	for pipe in pipes.keys():
		cursors[pipe] = Factory.items[pipe].put_cursor.instance()
		var cursor = cursors[pipe]
		cursor.cursor = get_parent()
		get_tree().current_scene.call_deferred("add_child", cursor)
		cursor.visible = false
#		cursor.owner = self
func _exit_tree():
	for pipe in pipes.keys():
		cursors[pipe].queue_free()

func set_pipe_transform(val):
	pipe_transform = val
	emit_signal("pipe_transform_changed", pipe_transform)

func _physics_process(delta):
	var input = owner.input
	
	if input.is_action_just_released("rotate"):
		self.pipe_transform = pipe_transform.rotated(PI/2.0)
		rotate_sound.play()
	
	if input.is_action_just_released("rotate_down"):
		self.pipe_transform = pipe_transform.rotated(-PI/2.0)
		rotate_sound.play()
	
	if input.is_action_just_pressed("next_pipe"):
		var items = pipes.keys()
		var index = (items.find(current) + 1)%items.size()
		self.current = items[index]
	
	if input.is_action_just_pressed("prev_pipe"):
		var items = pipes.keys()
		var index = (items.find(current) - 1)%items.size()
		self.current = items[index]
	
	if (input.is_action_just_pressed("bag") 
		and enabled
		and owner.cursor.available_action == "bag"):
			var areas = put_detect.get_overlapping_areas()
			if areas.size() and owner.cursor.is_within_range():
				_on_bag_area_entered(areas[-1])
			else: 
				putting = true
		
	
	
	var current_cursor = cursors[current]
	
	if putting:
		current_cursor.transform = pipe_transform
		var cursor_pos = global_position
		cursor_pos.x = stepify(cursor_pos.x-8.0, 16.0)+8.0
		cursor_pos.y = stepify(cursor_pos.y-8.0, 16.0)+8.0
		current_cursor.global_position = cursor_pos
		if pipes[current] <= 0: 
			current_cursor.modulate.a = 0.5
		else:
			current_cursor.modulate.a = 1.0
	current_cursor.visible = putting
	owner.cursor.captured = putting

func _process(delta):
	var input = owner.input
	var current_cursor = cursors[current]
	if owner.cursor.available_action == "bag":
		if (putting 
			and input.is_action_just_released("bag")):
				putting = false
				if (enabled 
					and pipes.has(current) 
					and pipes[current] 
					and !PhysicsUtils.anything_overlaps(put_detect)
					and owner.cursor.is_within_range()):
						var pipe = Factory.items[current].scene.instance()
						pipe.transform = pipe_transform
						pipes[current] -= 1
						_on_picked_up(current, pipes[current])
						owner.owner.add_child(pipe)
						pipe.global_position = current_cursor.global_position
						emit_signal("total_changed", get_count(), limit)
	else:
		putting = false
func _on_bag_area_entered(area: Area2D):
	var item = area.item_name
	if get_count() < limit:
		if !pipes.has(item):
			pipes[item] = 0
		pipes[item] += 1
		area.owner.queue_free()
		_on_picked_up(item, pipes[item])
		emit_signal("total_changed", get_count(), limit)
	else:
		_on_hit_limit()

func set_current(val):
	current = val
	emit_signal("current_changed", current)
	for cursor in cursors.values():
		cursor.visible = false
func get_count():
	var ret := 0
	for value in pipes.values():
		ret += value
	return ret

func _on_picked_up(item_name, current_amount):
	emit_signal("picked_up", item_name, current_amount)
	put_sound.play()

func _on_hit_limit():
	emit_signal("hit_limit")
	full_bag_sound.play()
