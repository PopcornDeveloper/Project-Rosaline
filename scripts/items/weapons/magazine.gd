extends Node
class_name Magazine

@export var full_size : int = 30
@export var current_size : int = 30
@export var is_in_gun : bool = false
@export var type : int = 1

@export var player : Player

func _process(delta: float) -> void:
	print(str(get_parent().name) + str(current_size))
	if not is_in_gun:
		if Input.is_action_just_pressed("reload"):
			if get_parent().get_parent() == player.LeftHand:
				if player.RightHand.get_child_count() > 0:
					if player.RightHand.get_child(0) is Gun:
						if player.RightHand.get_child(0).magazine.type == type:
							player.RightHand.get_child(0).magazine.current_size = current_size
							get_parent().queue_free()
