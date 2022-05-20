extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var i = 0
func _physics_process(delta):
	set_cell(0,0,i)
	if i:
		i = 0
	else:
		i = 1
	if Input.is_action_just_pressed("ui_accept"):
		position = position+Vector2.RIGHT
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	print("entered")

func _on_Area2D_body_exited(body):
	print("exited")
