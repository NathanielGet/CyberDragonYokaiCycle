extends Line2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mouseOver
var lineStarted

# Called when the node enters the scene tree for the first time.
func _ready():
	mouseOver = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var length = 5

func _process(delta):
	#print(mouseOver)
	if Input.is_action_pressed("click") and mouseOver == true:
		lineStarted = true
		
		#while get_point_count() > length:
		#	remove_point(0)
	if lineStarted:
		add_point(get_global_mouse_position())
	if Input.is_action_just_released("click"):
		lineStarted = false
		clear_points()
		
func entered():
	mouseOver = true
	#print("Moused Over")
	
func exited():
	mouseOver = false
	#print("Exited")
