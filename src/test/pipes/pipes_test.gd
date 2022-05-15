extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_child_count()-1:
		var pipe : Pipe = get_children()[i]
		pipe.add_next(get_children()[i+1])
	get_children()[0].anim.play("fill")
	
