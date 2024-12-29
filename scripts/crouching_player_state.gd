class_name CrouchingPlayerState extends PlayerMovementState

@export var SPEED : float = 2.5
@export var ACCELERATION : float = 0.1
@export var DECELERATION : float = 0.25
@export_range(1, 10, 0.1) var ANIMATION_SPEED : float = 10.0

@onready var CROUCH_SHAPECAST : ShapeCast3D = %ShapeCast3D

var RELEASED : bool = false

func enter(previous_state) -> void:
	ANIMATION.speed_scale = 1.0
	
	if previous_state.name == "SlidingPlayerState":
		ANIMATION.current_animation = "Crouch"
		ANIMATION.seek(1.0, true)
	elif previous_state.name == "JumpingPlayerState":
		ANIMATION.current_animation = "Crouch"
		ANIMATION.seek(1.0, true)
	else:
		ANIMATION.play("Crouch", -1.0, ANIMATION_SPEED)


func exit() -> void:
	RELEASED = false


func update(delta): 
	PLAYER.update_gravity(delta)
	if PLAYER.is_on_floor():
		PLAYER.update_input(SPEED, ACCELERATION, DECELERATION)
	PLAYER.update_velocity()
	
	if Input.is_action_just_pressed("jump") and PLAYER.is_on_floor():
		transition.emit("JumpingPlayerState")
	
	if Input.is_action_just_released("crouch"):
		uncrouch()
	elif Input.is_action_pressed("crouch") == false and RELEASED == false:
		RELEASED = true
		uncrouch()


func uncrouch():
	if CROUCH_SHAPECAST.is_colliding() == false:
		ANIMATION.play("Crouch", -1.0, -ANIMATION_SPEED, true)
		await ANIMATION.animation_finished
		if PLAYER.velocity.length() == 0:
			transition.emit("IdlePlayerState")
		else:
			transition.emit("WalkingPlayerState")
	elif CROUCH_SHAPECAST.is_colliding() == true:
		await get_tree().create_timer(0.1).timeout
		uncrouch()
