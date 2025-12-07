extends Node

var timeElapsed : float = 0.0

func sine(time, amp):
	return sin(time) * amp

func _process(delta: float) -> void:
	timeElapsed += delta

func Vector3Randf(min,max) -> Vector3:
	return Vector3(randf_range(min,max),randf_range(min,max),randf_range(min,max))
