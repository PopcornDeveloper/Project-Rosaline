@tool
extends Node3D


@export var pointer : Node3D
@onready var node_point_to : Marker3D = Marker3D.new()
@export var desired_position : Vector3
@export var trans = Tween.TRANS_BACK
@export var ease = Tween.EASE_OUT
@onready var mesh = get_child(0)
@export_range(0,1, 0.05) var duration = 0.25
@export var leg_type : String = "left"

func _ready():
	add_child(node_point_to)
	node_point_to.transform = transform
	look_at(pointer.global_position)
	node_point_to.rotation_order = 0

func _process(delta: float) -> void:
	look_at(pointer.global_position)
	rotation_degrees.z = -90
