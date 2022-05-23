extends Area2D


onready var shape :CollisionShape2D = $CollisionShape2D
onready var anim :AnimationPlayer = $AnimationPlayer
onready var ground_sound := $ground_sound
onready var rock_sound := $rock_sound
var enabled = true

func has_ground() -> bool:
	return get_overlapping_bodies().size()>0

func _physics_process(delta):
	
	var input = owner.input
	if input.is_action_pressed("drill") \
		and owner.cursor.is_within_range() \
		and owner.cursor.available_action == "drill":
			for body in get_overlapping_bodies():
				_on_drill_body_entered(body)
			rotation = (global_position-owner.global_position).angle()
			visible = true
	else:
		visible = false
	
	
	if visible:
		anim.play("drill")
	else:
		anim.stop()

func _on_drill_body_entered(body):
	
	if body is TileMap:
		var input = owner.input
		if input.is_action_pressed("drill"):
			var tm : TileMap = body
			var rect :RectangleShape2D = shape.shape
			var rock = Group.get_one("rock")
			var top_left : Vector2 = tm.world_to_map(tm.to_local(shape.global_position-rect.extents))
			var bot_right : Vector2 = tm.world_to_map(tm.to_local(shape.global_position+rect.extents))
		
			for j in range(top_left.y, bot_right.y+1):
				for i in range(top_left.x, bot_right.x+1):
					var tile = Vector2(i,j)
					if !tm.is_in_group("rock") and rock.get_cellv(tile)==-1:
						tm.drill_tile(tile)
						if !ground_sound.playing or ground_sound.get_playback_position() > 0.1:
							ground_sound.play()
						var aux = position
						position = position+Vector2(1,1)
						position = aux
					else:
						if !rock_sound.playing:
							rock_sound.play()

