extends Node3D
class_name ITEM

func _use():
	pass


@export var OneHanded_LeftHandDesiredPosition :Vector3
@export var TwoHanded_LeftHandDesiredPosition :Vector3

@export var OneHanded_RightHandDesiredPosition :Vector3
@export var TwoHanded_RightHandDesiredPosition :Vector3

@export var MainArmForwardMovement : float = 0
@export var OtherArmForwardMovement : float = 3
@export var MainArmVerticalMovement : float = 0
@export var OtherArmVerticalMovement : float = 0

@export var HandlePositionY : float
@export var HandlePositionZ : float

@export var LeftHand : Node3D
@export var RightHand : Node3D
@export var RightArm : Node3D
@export var LeftArm : Node3D 
@export var two_handed : bool
@export var HandleLeft : Marker3D
@export var HandleRight : Marker3D

var is_two_handed : bool
var mouse_mov : Vector2

func _ready():
	await get_tree().create_timer(1).timeout
	equip(LeftArm, RightArm)

func is_one_handed():
	if get_parent() == LeftHand:
		return RightHand.get_child_count() > 0
	elif get_parent() == RightHand:
		return LeftHand.get_child_count() > 0
	else:
		print("Tried to check if is one-handed in another node besides the RightHand and LeftHand, parent is" + str(get_parent().name))
var current : bool = false

func equip(arm : Node3D, prev_arm: Node3D):
	arm.look_at(HandleRight.global_position)
	
	if not is_one_handed():
		var main_arm_tween = get_tree().create_tween()
		main_arm_tween.tween_property(arm, "position", arm.position - ((arm.transform.basis.z * MainArmForwardMovement) + (arm.transform.basis.y * MainArmVerticalMovement)), 0.1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)

		prev_arm.look_at(HandleLeft.global_position)
		
		var prev_arm_tween = get_tree().create_tween()
		prev_arm_tween.tween_property(prev_arm, "position", prev_arm.position - ((prev_arm.transform.basis.z * OtherArmForwardMovement) + (prev_arm.transform.basis.y * OtherArmVerticalMovement)), 0.1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	elif is_one_handed():
		var main_arm_tween = get_tree().create_tween()
		main_arm_tween.tween_property(arm, "position", arm.position - ((arm.transform.basis.z * MainArmForwardMovement) + (arm.transform.basis.y * MainArmVerticalMovement)), 0.1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)


	
	rotation_degrees.z = 0

func _process(delta: float) -> void:
	if current:
		if Input.is_action_pressed("use"):
			_use()
