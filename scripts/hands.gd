extends Node3D

func _enter_tree() -> void:
	set_multiplayer_authority(str(player.name).to_int())
@export var player : Player
 
func switch_hand(hand, other_hand):
	hand.get_child(0).reparent(other_hand)

func _process(delta : float):
	if not is_multiplayer_authority():
		return
	var L_haschild = false
	var R_haschild = false
	if Input.is_action_just_pressed("switch hands"):

		if player.LeftHand.get_child_count() > 0:
			L_haschild = true
		if player.RightHand.get_child_count() > 0:
			R_haschild = true
		if L_haschild == true:
			if R_haschild == false:
				switch_hand(player.LeftHand,player.RightHand)
			elif R_haschild:
				switch_hand(player.LeftHand,player.RightHand)
				switch_hand(player.RightHand,player.LeftHand)
			return
		if R_haschild == true:
			if L_haschild == false:
				switch_hand(player.RightHand,player.LeftHand)
			elif L_haschild:
				switch_hand(player.LeftHand,player.RightHand)
				switch_hand(player.RightHand,player.LeftHand)
			return
	if Input.is_action_pressed("other_hand_current"):
		if L_haschild:
			player.LeftHand.get_child(0).current = true
		if R_haschild:
			player.RightHand.get_child(0).current = false
	elif Input.is_action_pressed("both_hands_current"):
		if L_haschild:
			player.LeftHand.get_child(0).current = true
		if R_haschild:
			player.RightHand.get_child(0).current = true
	else:
		if L_haschild:
			player.LeftHand.get_child(0).current = false
		if R_haschild:
			player.RightHand.get_child(0).current = true
	
