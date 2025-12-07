extends Camera3D
@export var poop : Node3D
func _process(delta: float) -> void:
	look_at(poop.global_position + Vector3(0,0.9,0))
