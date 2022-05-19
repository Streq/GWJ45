class_name NodeUtils

static func reparent(node: Node, to: Node)->void:
	node.get_parent().remove_child(node)
	to.add_child(node)

static func reparent_keep_transform(node: Node2D, to: Node2D)->void:
	var aux_t = node.global_transform
	reparent(node,to)
	node.global_transform = aux_t
