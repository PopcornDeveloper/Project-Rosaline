@tool
extends Marker3D

### this code is implemented from Crigz vs Game Dev's guide

@export var step_target : Node3D
@export var step_distance: float = 0.5
@export var adjacent_target : Node3D
@export var player : CharacterBody3D
@export var leg : Node3D

var is_stepping : bool = false

func _process(delta: float) -> void:
	if (!is_stepping and !adjacent_target.is_stepping and abs(global_position.distance_to(step_target.global_position)) > step_distance):
		step()

func step():
	#is_stepping = true
	#var target_position = step_target.global_position
	#var half_way = (global_position + step_target.global_position) / 2
	#var prevlegy = -0.714 ## don't ask why this is a variable
	#var step_tween2 = get_tree().create_tween()
	#
	#step_tween2.tween_property(leg.mesh, "position:z", prevlegy + 1, 0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	#
	#step_tween2.tween_property(self, "global_position", target_position + player.arji * 0.4, 0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	#step_tween2.tween_property(leg.mesh,"position:z", prevlegy, 0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	#
	#step_tween2 = get_tree().create_tween()
	#
	#is_stepping = false
	#await get_tree.create_timer(0.3).timeou
	var target_pos = step_target.global_position
	var half_way = (global_position + step_target.global_position) / 2
	var prevlegy = -0.714
	is_stepping = true
	
	
	var t = get_tree().create_tween()
	
	t.tween_property(leg.mesh, "position:z", prevlegy + 1, 0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	t.tween_property(self, "global_position", target_pos + (Vector3(player.arji.x * 0.3,0,player.arji.z * 0.3)), 0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	t.tween_callback(func():
		var t2 = get_tree().create_tween()
		t2.tween_property(leg.mesh, "position:z", prevlegy, 0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
		t2.tween_callback(func(): is_stepping = false)
	)
	
	
	
