extends Node3D
class_name Item

func _use():
	pass



@export var LeftHand_ArmLeftDesiredPosition : Vector3
@export var RightHand_ArmLeftDesiredPosition : Vector3
@export var LeftHand_ArmRightDesiredPosition : Vector3
@export var RightHand_ArmRightDesiredPosition : Vector3

@export var pos_in_left_hand : Vector3
@export var pos_in_right_hand : Vector3

@export var LeftHand : Node3D
@export var RightHand : Node3D
@export var LeftHandTarget : Marker3D
@export var RightHandTarget : Marker3D
@export var LeftArmHandNode : Node3D
@export var RightArmHandNode : Node3D
@export var RightArm : Node3D
@export var LeftArm : Node3D 
@export var two_handed : bool
@export var HandleLeft : Marker3D
@export var HandleRight : Marker3D

var is_two_handed : bool
var mouse_mov : Vector2

func _input(event: InputEvent) -> void: 
	if event is InputEventMouseMotion:
		mouse_mov = event.relative 

func is_one_handed():
	var counter : int = 0
	for i in LeftHand.get_parent().get_children():
		for i_2 in i.get_children():
			if i_2.get_child_count() > 0:
				counter += 1
	if counter == 2:
		return true
	elif counter == 1:
		return false
	else:
		push_error("yuor code suks!!! counter count exceeded 2!!!. Counter count: " + str(counter))
var current : bool = false

func _process(delta: float) -> void:

	mouse_mov.lerp(Vector2.ZERO, 2.5 * delta)

	var movtween = create_tween()
	movtween.tween_property(get_parent().get_parent(), "rotation_degrees", Vector3(mouse_mov.y , mouse_mov.x, 0), 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)

	if two_handed:
		if get_parent() == LeftHand:
			var t = get_tree().create_tween()

			#t.tween_property(LeftArm, "position", LeftHand_ArmLeftDesiredPosition, 0.05).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
			#t.tween_property(RightArm, "position", LeftHand_ArmRightDesiredPosition, 0.05).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
			
			RightHandTarget.global_position = lerp(RightHandTarget.global_position,HandleLeft.global_position, 5 * delta)
			LeftHandTarget.global_position = lerp(LeftHandTarget.global_position,HandleRight.global_position, 5 * delta)
			
			LeftArm.mesh.position.z = lerp(LeftArm.mesh.position.z, -LeftArmHandNode.global_position.distance_to(RightHandTarget.global_position) * 0.2, 10 * delta)
			RightArm.mesh.position.z = lerp(RightArm.mesh.position.z, RightArmHandNode.global_position.distance_to(LeftHandTarget.global_position) * 1, 10 * delta)
		else:
			var t = get_tree().create_tween()

			t.tween_property(LeftArm, "position", RightHand_ArmLeftDesiredPosition, 0.05).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
			t.tween_property(RightArm, "position", RightHand_ArmRightDesiredPosition, 0.05).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
			
			RightHandTarget.global_position = lerp(RightHandTarget.global_position,HandleRight.global_position, 5 * delta)
			LeftHandTarget.global_position = lerp(LeftHandTarget.global_position,HandleLeft.global_position, 5 * delta)

		
	if current:
		if Input.is_action_pressed("use"):
			_use()
