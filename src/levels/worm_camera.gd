extends Camera2D

export var velocity := Vector2()

func _physics_process(delta):
	position += velocity * delta


func stop():
	set_physics_process(false)
	
func start():
	set_physics_process(true)
	
func _on_stop_detect_area_entered(area):
	stop()
