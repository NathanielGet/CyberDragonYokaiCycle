extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal port_hovered(port)
export var nodeColor = "default"
export var nodeRing = "inner"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("mouse_entered", self, "send_port")
	connect("mouse_exited", get_node("../Wire"), "exited")
	connect("port_hovered", get_node("../Wire"), "entered")



func send_port():
	emit_signal("port_hovered", self)


func deactivate():
	$Sprite.set_animation("deactivated")

func activate():
	$Sprite.set_animation("default")

func sync_frame():
	$Sprite.frame = 0
