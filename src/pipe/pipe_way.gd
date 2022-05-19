extends Area2D
class_name PipeEntry


var a : PipeEntry = null
var b : PipeEntry = null

enum Tide {
	TOWARDS_A = -1,
	STATIC = 0,
	TOWARDS_B = 1
}

var tide : int

func _physics_process(delta):
	tide = Tide.STATIC

func _add_tide(coming_from: PipeEntry, val: int):
	if coming_from == a:
		if is_instance_valid(b):
			b._add_tide(self, val)
		tide += val*Tide.TOWARDS_B
	elif coming_from == b:
		if is_instance_valid(a):
			a._add_tide(self, val)
		tide += val*Tide.TOWARDS_A
	else:
		push_error("the provided PipeEntry isn't an entry")
	
	
func get_opposite(of: PipeEntry):
	if of == a:
		return b;
	elif of == b:
		return a;
	else:
		push_error("the provided PipeEntry isn't an entry")


func _on_area_entered(area: PipeEntry):
	if get_global_direction().is_equal_approx(-area.get_global_direction()):
		if !is_instance_valid(a):
			a = area
		elif !is_instance_valid(b):
			b = area
			
func get_global_direction():
	return to_global(Vector2.RIGHT)-global_position


func _on_area_exited(area):
	if area == a:
		a = null
	elif area == b:
		b = null

func get_tide_velocity() -> Vector2:
	if !tide:
		return Vector2.ZERO
	else:
		var target
		if tide < 0:
			target = a.global_position if a else to_global(Vector2.RIGHT)
		else:
			target = b.global_position if b else to_global(Vector2.RIGHT)
		return (target - global_position).normalized()*abs(tide)*10.0
	

func get_tide_next() -> PipeEntry:
	if tide < 0:
		return a
	elif tide > 0 :
		return b
	else:
		return null

func is_sucking():
	return tide<0 and b == null or tide>0 and a == null
