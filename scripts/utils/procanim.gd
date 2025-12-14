extends Node

var timeElapsed : float = 0.0

func sine(time, amp):
	return sin(time) * amp

func _process(delta: float) -> void:
	timeElapsed += delta

func Vector3Randf(min,max) -> Vector3:
	return Vector3(randf_range(min,max),randf_range(min,max),randf_range(min,max))

func Vector3Deg2Rad(vector : Vector3):
	return Vector3(deg_to_rad(vector.x), deg_to_rad(vector.y), deg_to_rad(vector.z))
