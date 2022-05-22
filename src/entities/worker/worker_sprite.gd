extends Sprite

onready var sprites = [
	preload("res://assets/texture/worker0.png"),
	preload("res://assets/texture/worker1.png"),
	preload("res://assets/texture/worker2.png")
]

func _ready():
	
	texture = sprites[Global.worker_index%sprites.size()]
	
	pass
