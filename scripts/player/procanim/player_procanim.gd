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

func _process(delta):
	if moving:
		if LeftHand.get_child_count() == 0 and not (RightHand.get_child_count() == 1 and RightHand.get_child(0).two_handed):
			LeftArm.pointer.position.z = -0.055 + sin(proc.timeElapsed * -7) * player.velocity.length() / 2
		if RightHand.get_child_count() == 0 and not (LeftHand.get_child_count() == 1 and LeftHand.get_child(0).two_handed):
			RightArm.pointer.position.z = -0.055 + sin(-proc.timeElapsed * -7) * player.velocity.length() / 2
