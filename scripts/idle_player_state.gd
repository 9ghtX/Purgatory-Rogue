class_name IdlePlayerState extends PlayerMovementState

@export var SPEED : float = 5.0
@export var ACCELERATION : float = 0.1
@export var DECELERATION : float = 0.25


func enter(previous_state) -> void:
	ANIMATION.pause()


func update(delta):	
	PLAYER.update_gravity(delta)
	if PLAYER.is_on_floor():
		PLAYER.update_input(SPEED, ACCELERATION, DECELERATION)
	PLAYER.update_velocity()
	
	if Input.is_action_just_pressed("crouch"):
		transition.emit("CrouchingPlayerState")
	
	if PLAYER.velocity.length() > 0.1 and Global.player.is_on_floor():
		transition.emit("WalkingPlayerState")
	
	if Input.is_action_just_pressed("jump") and PLAYER.is_on_floor():
		transition.emit("JumpingPlayerState")
