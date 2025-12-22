extends CharacterBody3D

var movement_speed = 4
var moving : bool = false
var mouse_mov : Vector2
@export var sensitivity: float = 0.5
@export var head : Node3D
@export var hands : Node3D
@export var camera : Node3D
@export var procanim_handler : Node3D
@export var torso :Node3D
@export var arji : Vector3

var animating_cam : bool = false

@export var direction = Vector3.ZERO

func _enter_tree() -> void:
	set_multiplayer_authority(str(name).to_int())

func _input(event):
	if is_multiplayer_authority():
		if event is InputEventMouseMotion:
			mouse_mov = -event.relative

func _ready() -> void:
	if is_multiplayer_authority():
		camera.current = true
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func animate_cam():
	animating_cam = true
	var t = create_tween()
	t.tween_property(camera, "rotation:z", -PI / 512 * velocity.length() / movement_speed * 2, 0.3).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	await get_tree().create_timer(0.4).timeout
	t = create_tween()
	t.tween_property(camera, "rotation:z", PI / 512 * velocity.length() / movement_speed * 2, 0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	await get_tree().create_timer(0.4).timeout
	animating_cam = false
func _physics_process(delta: float) -> void:
	if not is_multiplayer_authority(): return
	arji = velocity
	
	camera.make_current()
	
	if Input.is_action_just_pressed("unlock mouse"): 
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		mouse_mov = Vector2.ZERO
	
	
	mouse_mov = lerp(mouse_mov, Vector2.ZERO, 10 * delta)
	head.rotation_degrees = lerp(head.rotation_degrees, Vector3(head.rotation_degrees.x + sensitivity * mouse_mov.y, 0, 0), 10 * delta)
	rotation_degrees = lerp(rotation_degrees, Vector3(0, self.rotation_degrees.y + sensitivity * mouse_mov.x, 0), 10 * delta)
	
	head.rotation_degrees.z = lerpf(head.rotation_degrees.z, mouse_mov.x, 5 * delta)
	direction = Vector3.ZERO
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = 2.5
	head.rotation_degrees.x = clampf(head.rotation_degrees.x, -70, 80)

	if Input.is_action_pressed("forward"):
		direction.z -= 1.0
	if Input.is_action_pressed("backward"):
		direction.z += 1.0
	if Input.is_action_pressed("left"):
		direction.x -= 1.0
	if Input.is_action_pressed("right"):
		direction.x += 1.0
		
	# Currently, the vector's length is greater than 1 while trying to move diagonally
	# This means the player moves faster in diagonals than when going in cardinal directions
	# (which is not very good)
	# Normalizing the vector ensures the length will always be 1, and the movement speed
	# will be the same regardless of if the player is moving diagonally or not
	direction = direction.normalized()

	# Because we aren't using the transforms for the direction anymore, we need to rotate
	# the vector using our yaw so movement is aligned with it
	direction = direction.rotated(Vector3(0, 1, 0), rotation.y)
	
	velocity.x = lerpf(velocity.x, direction.x * movement_speed, delta)
	velocity.z = lerpf(velocity.z, direction.z * movement_speed, delta)
	
	if velocity.length() >= 1:
		moving = true
	else:
		moving = false
	
	procanim_handler.moving = moving
	camera.position = ((sin(proc.timeElapsed * 8) * velocity.length() / 100) + 0.25) * camera.transform.basis.y
	camera.position = Vector3(camera.position.x, camera.position.y, -0.25)

	hands.rotation = lerp(hands.rotation, -Vector3(mouse_mov.y, mouse_mov.x, 0) / 20, 10 * delta)
	
	if not animating_cam and velocity.length() >= 2:
		animate_cam()
	else:
		camera.rotation.z = lerpf(camera.rotation.z, 0.0, 5 * delta)

	torso.rotation.x = head.rotation.x / 2
	
	velocity.y -= 9.81 * delta
	move_and_slide()
