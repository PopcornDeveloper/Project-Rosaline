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
