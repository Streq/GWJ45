extends Area2D


onready var shape :CollisionShape2D = $CollisionShape2D
onready var anim :AnimationPlayer = $AnimationPlayer
var enabled = true

func _physics_process(delta):
	var input = owner.input
	for body in get_overlapping_bodies():
		_on_drill_body_entered(body)
	visible = input.is_action_pressed("drill") and input.dir
	if visible:
		anim.play("drill")
	else:
		anim.stop()

func _on_drill_body_entered(body):
	if body is TileMap:
		var input = owner.input
		var tm : TileMap = body
		var rect :RectangleShape2D = shape.shape
		var rock = Group.get_one("rock")
		if input.is_action_pressed("drill"):
			var top_left : Vector2 = tm.world_to_map(shape.global_position-rect.extents)
			var bot_right : Vector2 = tm.world_to_map(shape.global_position+rect.extents)
		
			for j in range(top_left.y, bot_right.y+1):
				for i in range(top_left.x, bot_right.x+1):
					var tile = Vector2(i,j)
					if rock.get_cellv(tile)==-1:
						tm.drill_tile(tile)
						var aux = position
						position = position+Vector2(1,1)
						position = aux
