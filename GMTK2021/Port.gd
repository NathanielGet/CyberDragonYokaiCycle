extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal port_hovered(port)

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("mouse_entered", self, "send_port")
	connect("mouse_exited", get_node("../Line2D"), "exited")
	connect("port_hovered", get_node("../Line2D"), "entered")

func _on_Area2D_input_event(viewport, event, shape_idx ):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		print("Clicked")

func send_port():
	emit_signal("port_hovered", self)
