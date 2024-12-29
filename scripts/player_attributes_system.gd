extends Node

var PLAYER

@export_range(1, 20, 1) var ST : int = 10
@export_range(1, 20, 1) var DX : int = 10
@export_range(1, 20, 1) var IQ : int = 10
@export_range(1, 20, 1) var HT : int = 10
@export_range(1, 20, 1) var WS : int = 10
@export_range(1, 20, 1) var PR : int = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await owner.ready
	PLAYER = owner as Player
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Global.debug.add_property("ST", ST, 10)
	Global.debug.add_property("DX", DX, 11)
	Global.debug.add_property("IQ", IQ, 12)
	Global.debug.add_property("HT", HT, 13)
	Global.debug.add_property("WS", WS, 14)
	Global.debug.add_property("PR", PR, 15)
	
	pass


func _physics_process(delta: float) -> void:
	pass
