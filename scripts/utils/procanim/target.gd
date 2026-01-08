extends Marker3D

@export var step_target: Node3D
@export var step_distance: float = 0.75
@export var skeleton_ik : SkeletonIK3D

@export var adjacent_target: Node3D
@export var desired_rotation_degrees : Vector3

var is_stepping := false

func _process(delta):
	rotation_degrees = get_parent().rotation_degrees + Vector3(0, -90,95.5) + desired_rotation_degrees
	if !is_stepping && !adjacent_target.is_stepping && abs(global_position.distance_to(step_target.global_position)) > step_distance:
		step()

func step():
	var target_pos = step_target.global_position
	var half_way = (global_position + step_target.global_position) / 2
	is_stepping = true
	
	print(str(get_parent().name))
	var t = get_tree().create_tween()
	var t2 = get_tree().create_tween()
	
	
	t.tween_property(self, "global_position", half_way + (get_parent().transform.basis.y * 0.75), 0.1)
	t2.tween_property(self, "desired_rotation_degrees", Vector3(0,0,0), 0.1)
	t.tween_property(self, "global_position", Vector3(target_pos.x + (get_parent().arji.x * 0.3), target_pos.y, target_pos.z + (get_parent().arji.z * 0.3)) , 0.1)
	t2.tween_property(self, "desired_rotation_degrees", Vector3(0,0,-45), 0.1)
	t2.tween_property(self, "desired_rotation_degrees", Vector3(0,0,0), 0.1)
	t.tween_callback(func(): is_stepping = false)
