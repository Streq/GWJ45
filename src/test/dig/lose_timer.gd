extends Timer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("timeout", get_tree(), "reload_current_scene")
	for goal in Group.get_all("goal_pipe"):
		goal.connect("goal", self, "set_paused", [true])
