extends Timer


func _ready():
	connect("timeout", self, "_win")
	
func _win():
	Levels.next_level()


func _on_goal():
	start()
