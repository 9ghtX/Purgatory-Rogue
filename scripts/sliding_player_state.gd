class_name SlidingPlayerState extends PlayerMovementState

@export var SPEED : float = 2.5
@export var ACCELERATION : float = 0.1
@export var DECELERATION : float = 0.25
@export var TILT_AMOUNT : float = 0.09
@export_range(1, 6, 0.1) var ANIMATION_SPEED : float = 4.0

@onready var CROUCH_SHAPECAST : ShapeCast3D = %ShapeCast3D

func enter(previous_state) -> void:
	ANIMATION.get_animation("Sliding").track_set_key_value(2, 0, PLAYER.velocity.length())
	ANIMATION.speed_scale = 1.0
	ANIMATION.play("Sliding", -1.0, ANIMATION_SPEED)


func update(delta): 
	PLAYER.update_gravity(delta)
	#PLAYER.update_input(SPEED, ACCELERATION, DECELERATION)
	PLAYER.update_velocity()
	
	if Input.is_action_just_pressed("jump") and PLAYER.is_on_floor():
		transition.emit("JumpingPlayerState")


func finish():
	transition.emit("CrouchingPlayerState")
