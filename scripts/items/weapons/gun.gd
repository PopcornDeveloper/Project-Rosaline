extends Item
class_name Gun

@onready var muzzle_flash = $muzzleflash
@export var slide : Node3D
@export var slide_z_position_start = 2.25
@export var slide_z_position_end = 1.408

@export var recoil_up : float
@export var recoil_side : float
@export var recoil_back : float
@export var recoil_rotation : Vector3

func recoil():
	get_parent().position += transform.basis.y * recoil_up + (transform.basis.y * randf_range(-recoil_up / 5, recoil_up / 5))
	get_parent().position += transform.basis.z * recoil_back + (transform.basis.z * randf_range(-recoil_back / 5, recoil_back / 5))
	get_parent().position += transform.basis.x * (recoil_side * randi_range(-1,1))
	get_parent().rotate_object_local(Vector3.RIGHT,recoil_rotation.x + randf_range(-0.05, 0.05))
	get_parent().rotate_object_local(Vector3.UP,recoil_rotation.y + randf_range(-0.05, 0.05))
	get_parent().rotate_object_local(Vector3.FORWARD,recoil_rotation.z + randf_range(-0.05, 0.05))

func _enter_tree():
	set_multiplayer_authority(str(player.name).to_int())

func _use():
	if not is_multiplayer_authority():
		return
	if can_use:
		can_use = false
	
		shoot_effects.rpc()
		
		await get_tree().create_timer(use_cooldown).timeout
		can_use = true

@rpc("call_local")
func shoot_effects():
	$shoot.play()
	
	var t = get_tree().create_tween()
	t.tween_property(slide, "position:z", slide_z_position_end, 0.03).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	t.tween_property(slide,"position:z",slide_z_position_start, 0.03).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)
	

	for i in muzzle_flash.get_children():
		i.restart()
		i.emitting = true
	await get_tree().create_timer(0.06).timeout
	recoil()
