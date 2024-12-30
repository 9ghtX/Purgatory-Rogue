class_name Player extends CharacterBody3D

@export var CAMERA_CONTROLLER : Node3D
@export var ANIMATIONPLAYER : AnimationPlayer
@export var CROUCH_SHAPECAST : ShapeCast3D

@export var MOUSE_SENSITIVITY : float = 0.17
@export var TILT_LOWER_LIMIT := deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90.0)

var _speed : float
var _mouse_input : bool = false
var _rotation_input : float
var _tilt_input : float
var _mouse_rotation : Vector3
var _player_rotation : Vector3
var _camera_rotation : Vector3

var _speed_mod : float
var _accel_mod : float

var _current_rotation : float

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var gravity = 12


func _unhandled_input(event: InputEvent) -> void:
	_mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x * MOUSE_SENSITIVITY
		_tilt_input = -event.relative.y * MOUSE_SENSITIVITY


func _input(event):
	if event.is_action_pressed("exit"):
		get_tree().quit()


func _update_camera(delta):
	_current_rotation = _rotation_input
	# Rotates camera using euler rotation
	_mouse_rotation.x += _tilt_input * delta
	_mouse_rotation.x = clamp(_mouse_rotation.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)
	_mouse_rotation.y += _rotation_input * delta
	
	_player_rotation = Vector3(0.0,_mouse_rotation.y,0.0)
	_camera_rotation = Vector3(_mouse_rotation.x,0.0,0.0)

	CAMERA_CONTROLLER.transform.basis = Basis.from_euler(_camera_rotation)
	global_transform.basis = Basis.from_euler(_player_rotation)
	
	CAMERA_CONTROLLER.rotation.z = 0.0

	_rotation_input = 0.0
	_tilt_input = 0.0
	
	
func _ready():
	Global.player = self
	
	# Get mouse input
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	CROUCH_SHAPECAST.add_exception($".")


func _process(delta: float) -> void:
	# Update camera movement based on mouse movement
	_update_camera(delta)


func _physics_process(delta):
	pass


func update_gravity(delta) -> void:
	velocity.y -= gravity * delta


func update_input(speed: float, acceleration: float, deceleration: float) -> void:
	Global.debug.add_property("Target movement speed", speed, 0)
	
	apply_attributes_mods()
	
	var modded_speed = speed  * (1 + _speed_mod) 
	var modded_accel = acceleration  * (1 + _accel_mod) 
	
	Global.debug.add_property("Modded movement speed", modded_speed, 1)
	
	#if !is_on_floor():
		#deceleration = 0.05
	
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = lerp(velocity.x, direction.x * modded_speed, modded_accel)
		velocity.z = lerp(velocity.z, direction.z * modded_speed, modded_accel)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)
	
	Global.debug.add_property("Current movement speed", abs(velocity.x) + abs(velocity.z), 1)


func apply_attributes_mods():
	_speed_mod = ($PlayerAttributesSystem.DX - 10) * 0.1
	_accel_mod = ($PlayerAttributesSystem.DX - 10) * 0.05


func update_velocity() -> void:
	move_and_slide()
