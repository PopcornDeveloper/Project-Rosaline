extends Node3D

var idle = true
var moving = true
var animating_legs = false
var animating_arms = false
@export var player : CharacterBody3D
@export var RightLeg : Node3D
@export var LeftLeg : Node3D
@export var RightArm : Node3D
@export var LeftArm : Node3D
@export var LegHolder : Node3D

@export var LeftHand : Node3D
@export var RightHand : Node3D

var time
#
#func animate_arm(arm : Node3D):
	#animating_arms = true
	#arm.rotation.x = proc.sine(proc.timeElapsed * 6, PI / 16)
	#arm.rotation.y = proc.sine(proc.timeElapsed * 3, PI / 32)
	#arm.rotation_degrees.x += 90.0
	#arm.rotation_degrees.y += 180.0
	#animating_arms = false
#func _process(delta: float) -> void:
	#if LeftHand.get_child_count() <= 0:
		#LeftArm.rotation = Vector3.ZERO + Vector3(PI / 2, 0, 0)
		#LeftArm.position = Vector3(2.6,0,0)
		#if player.arji.length() > 1:
			#animate_arm(LeftArm.get_child(0))
#
	#elif RightHand.get_child_count() <= 0:
		#RightArm.position = Vector3(-2.6,0,0)
		#RightArm.rotation = Vector3.ZERO + Vector3(PI / 2, 0, 0)
		#if player.arji.length() > 1:
			#animate_arm(RightArm.get_child(0))
#
	#if animating_arms == false and RightHand.get_child_count() <= 0:
		#RightArm.get_child(0).rotation_degrees = lerp(RightArm.get_child(0).rotation_degrees, Vector3(90,180,0), 5 * delta)
	#if animating_arms == false and LeftHand.get_child_count() <= 0:
		#LeftArm.get_child(0).rotation_degrees = lerp(LeftArm.get_child(0).rotation_degrees, Vector3(90,180,0), 5 * delta)
