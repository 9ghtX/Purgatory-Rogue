extends CenterContainer

@export var DOT_RADIUS : float = 1.0
@export var CIRCLE_RADIUS : float = 10.0
@export var DOT_COLOR : Color = Color.GOLDENROD
@export var DOT_BORDER_COLOR : Color = Color.DIM_GRAY


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _draw():
	draw_arc(Vector2(0, 0), CIRCLE_RADIUS + 1.5, 0, 360, 36, DOT_BORDER_COLOR, 0.5, true)
	draw_arc(Vector2(0, 0), CIRCLE_RADIUS, 0, 360, 36, DOT_COLOR, 0.5, true)
	draw_arc(Vector2(0, 0), CIRCLE_RADIUS - 1.5, 0, 360, 36, DOT_BORDER_COLOR, 0.5, true)
