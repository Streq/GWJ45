extends Node


var items = {}

func _ready():
	for item in get_children():
		items[item.name] = item

func instance(name):
	return items[name].scene.instance()
