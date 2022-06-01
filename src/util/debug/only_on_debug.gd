extends Node

func _ready():
	if !OS.is_debug_build():
		owner.queue_free()
