extends Line2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var makeLine = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var length = 5

func _process(delta):
	if Input.is_action_pressed("click"):
		add_point(get_global_mouse_position())
		#while get_point_count() > length:
		#	remove_point(0)
	if Input.is_action_just_released("click"):
		clear_points()
