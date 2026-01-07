extends Marker3D

@export var step_target: Node3D
@export var step_distance: float = 0.5

@export var adjacent_target: Node3D

var is_stepping := false

func _process(delta):
	if !is_stepping && !adjacent_target.is_stepping && abs(global_position.distance_to(step_target.global_position)) > step_distance:
		step()

func step():
	var target_pos = step_target.global_position
	var half_way = (global_position + step_target.global_position) / 2
	is_stepping = true
	
	print(str(get_parent().name))
	var t = get_tree().create_tween()
	t.tween_property(self, "global_position", half_way + (get_parent().transform.basis.y * 0.75), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	t.tween_property(self, "global_position", Vector3(target_pos.x + (get_parent().arji.x * 0.4), target_pos.y, target_pos.z + (get_parent().arji.z * 0.4)) , 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	t.tween_callback(func(): is_stepping = false)
