extends Node3D
class_name Item

func _use():
	pass

@export var use_cooldown : float = 0.1
var can_use : bool = true

@export var automatic : bool = false
var aimable : bool = true
@export var aiming : bool = false
var player_aiming_speed = 1.5
@export var heftiness_lerp = 10.0

@export var aiming_position : Vector3
@export var aiming_rotation : Vector3

var DefaultPosition : Vector3
var RightArmDefaultPosition : Vector3
var LeftArmDefaultPosition : Vector3

@export var player : CharacterBody3D

@export var two_handed : bool
@export var HandleLeft : Marker3D
@export var HandleRight : Marker3D

var is_two_handed : bool
var mouse_mov : Vector2

func _ready():
	DefaultPosition = position
	RightArmDefaultPosition = player.RightArm.position
	LeftArmDefaultPosition = player.LeftArm.position

func is_one_handed():
	if get_parent() == player.LeftHand:
		return player.RightHand.get_child_count() > 0 or !is_two_handed
	elif get_parent() == player.RightHand:
		return player.LeftHand.get_child_count() > 0 or !is_two_handed
	else:
		print("Tried to check if is one-handed in another node besides the RightHand and LeftHand, parent is" + str(get_parent().name))
var current : bool = true

func _process(delta: float) -> void:
	rotation = lerp(rotation, -Vector3(player.mouse_mov.y, player.mouse_mov.x, 0) / 60, (heftiness_lerp / 2) * delta)
	
	if aiming:
		get_parent().position = lerp(get_parent().position, aiming_position,  heftiness_lerp * delta)
		get_parent().rotation = lerp(get_parent().rotation, aiming_rotation,  heftiness_lerp * delta)
		player.movement_speed = player_aiming_speed
	else:
		player.movement_speed = 4
		get_parent().rotation = lerp(get_parent().rotation, Vector3.ZERO,  heftiness_lerp * delta / 2)
	if is_one_handed():
		if get_parent() == player.LeftHand:
			player.LeftArm.look_at(player.LeftShoulder.global_position)
			player.LeftArm.global_position = lerp(player.LeftArm.global_position, HandleRight.global_position, heftiness_lerp * delta * 4)
			if not aiming:
				get_parent().position = lerp(get_parent().position, Vector3(-0.4,0,0), heftiness_lerp * delta * 2)
		else:
			player.RightArm.look_at(player.RightShoulder.global_position)
			player.RightArm.global_position = lerp(player.RightArm.global_position, HandleRight.global_position, heftiness_lerp * delta * 4)
			
			if not aiming:
				get_parent().position = lerp(get_parent().position, Vector3(0.4,0,0), heftiness_lerp * delta)
			
	else:
		if get_parent() == player.LeftHand:
			player.LeftArm.look_at(player.LeftShoulder.global_position)
			player.RightArm.look_at(player.RightShoulder.global_position)

			player.LeftArm.global_position = lerp(player.LeftArm.global_position, HandleRight.global_position, heftiness_lerp * delta* 4)
			player.RightArm.global_position = lerp(player.RightArm.global_position, HandleLeft.global_position, heftiness_lerp * delta* 4)
			
			if not aiming:
				get_parent().position = lerp(get_parent().position, Vector3(-0.4,0,0), heftiness_lerp * delta)
		else:
			player.LeftArm.look_at(player.LeftShoulder.global_position)
			player.RightArm.look_at(player.RightShoulder.global_position)

			player.LeftArm.global_position = HandleLeft.global_position
			player.RightArm.global_position = HandleRight.global_position
			if not aiming:
				get_parent().position = lerp(get_parent().position, Vector3(0.4,0,0), heftiness_lerp * delta)
	if current:
		if aimable:
			if Input.is_action_just_pressed("aim"):
				if not aiming: 
					aiming = true
				else: 
					aiming = false
		if automatic:
			if Input.is_action_pressed("use") and can_use:
				_use()
		else:
			if Input.is_action_just_pressed("use") and can_use:
				_use()
