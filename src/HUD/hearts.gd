extends HBoxContainer


func _ready():
	var player = Group.get_one("player")
	player.connect("max_hitpoints_changed", self, "_on_max_hitpoints_changed")
	player.connect("hitpoints_changed", self, "_on_hitpoints_changed")
	_on_hitpoints_changed(player.hitpoints)
	_on_max_hitpoints_changed(player.max_hitpoints)
func _on_max_hitpoints_changed(val):
	while get_child_count() < val:
		add_child(Factory.instance("heart"))
	while get_child_count() > val:
		remove_child(get_child(-1))

func _on_hitpoints_changed(val):
	for i in get_child_count():
		get_child(i).set_full(i<val)
