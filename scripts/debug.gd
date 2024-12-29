class_name DebugPanel extends PanelContainer

@onready var property_container = %VBoxContainer

var frames_per_second : String


func _ready():
	Global.debug = self
	
	visible = false


func _process(delta):
	pass


func _input(event):
	if event.is_action_pressed("debug"):
		visible = !visible


func add_property(title: String, value, order):
	var target
	target = property_container.find_child(title, true, false)
	if !target:
		target = Label.new()
		property_container.add_child(target)
		target.name = title
		target.text = target.name + ": " + str(value)
	elif visible:
		target.text = target.name + ": " + str(value)
		property_container.move_child(target, order)
