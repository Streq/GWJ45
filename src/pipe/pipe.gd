extends Node2D
class_name Pipe

onready var points = $points
onready var entries = points.get_children()

func _ready():
	for entry in entries.size():
		var e : PipeEntry = entries[entry]
		if entry != 0:
			e.a = entries[entry-1]
		if entry != entries.size()-1:
			e.b = entries[entry+1]
		
