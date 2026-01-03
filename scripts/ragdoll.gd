extends Node3D

@rpc("call_local")
func rag() -> void:
	$Node3D/rrobloxrig_torso/RigidBody3D.apply_force(proc.Vector3Randf(-5000,5000))
