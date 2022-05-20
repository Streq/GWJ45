extends Control

var items = {}

func _ready():
	for item in $items.get_children():
		items[item.name] = item
	
	var bag = Group.get_one("player").get_node("bag")
	
	bag.connect("picked_up", self, "_on_item_amount_changed")
	bag.connect("current_changed", self, "_on_current_changed")
	bag.connect("pipe_transform_changed", self, "_on_pipe_transform_changed")
	_on_current_changed(bag.current)

func _on_item_amount_changed(item_name, current_amount):
	items[item_name].get_node("amount").text = "%2d" % current_amount
	
func _on_current_changed(item_name):
	for value in items.values():
		value.modulate = Color(0.4,0.4,0.4)
	items[item_name].modulate = Color.white

func _on_pipe_transform_changed(pipe_transform):
	for value in items.values():
		value.get_node("display/Sprite").transform = pipe_transform

