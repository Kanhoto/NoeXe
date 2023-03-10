extends CharacterBody3D

# Const variables
const speed_m = 10
const jump_velocity_m = 4
const gravity_multiplier_m = 1

# Variables
@onready var pivot := $Pivot
@onready var camera := $Pivot/Camera3D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _unhandled_input(event):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED :
		if event is InputEventMouseMotion :
			pivot.rotate_y(-event.relative.x * 0.01)
			camera.rotate_x(-event.relative.y * 0.01)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-30), deg_to_rad(60))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * gravity_multiplier_m * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity_m

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed_m
		velocity.z = direction.z * speed_m
	else:
		velocity.x = move_toward(velocity.x, 0, speed_m)
		velocity.z = move_toward(velocity.z, 0, speed_m)

	move_and_slide()
