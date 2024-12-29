class_name JumpingPlayerState extends PlayerMovementState

@export var SPEED : float
@export var ACCELERATION : float = 0.1
@export var DECELERATION : float = 0.25
@export var JUMP_VELOCITY : float = 4.5


func enter(previous_state) -> void:
	SPEED = previous_state.SPEED
	PLAYER.velocity.y += JUMP_VELOCITY
	ANIMATION.pause()


func update(delta):	
	#TODO: надо узнать, как снизить управляемость в полете, но сохранить инерцию
	
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED, ACCELERATION, DECELERATION)
	PLAYER.update_velocity()
	
	if Input.is_action_pressed("crouch"):
			transition.emit("CrouchingPlayerState")
	elif PLAYER.is_on_floor():		
		transition.emit("IdlePlayerState")	
