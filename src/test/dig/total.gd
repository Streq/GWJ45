extends Label


func _ready():
	var bag = Group.get_one("player").get_node("bag")
	
	bag.connect("total_changed", self, "_on_total_changed")
	bag.connect("hit_limit", self, "_on_hit_limit")
	_on_total_changed(bag.get_count(), bag.limit)


func _on_total_changed(total, limit):
	text = "%2d" % total + "/" + "%2d" % limit
var playing = false
func _on_hit_limit():
	if !playing:
		playing = true
		for i in 2:
			modulate = Color.red
			yield(get_tree().create_timer(0.2), "timeout")
			modulate = Color.white
			yield(get_tree().create_timer(0.2), "timeout")
		playing = false
