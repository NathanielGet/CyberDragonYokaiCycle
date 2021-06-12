extends Line2D


# Declare member variables here.
var mouseOver = false
var lineStarted = false
var visitedNodes = ["start", "end"]
var lastNodeEntered

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(delta):
	#print(mouseOver)
	if lineStarted:
		add_point(get_global_mouse_position())
		if self.points.size() > 2:
			remove_point(1)
	elif Input.is_action_pressed("click") and mouseOver == true:
		lineStarted = true
		visitedNodes[0] = lastNodeEntered
		
		#while get_point_count() > length:
		#	remove_point(0)
	
	if Input.is_action_just_released("click"):
		lineStarted = false
		clear_points()
		if mouseOver == true:
			visitedNodes[1] = lastNodeEntered
			print(visitedNodes)
	
		
func entered(nodeColor):
	lastNodeEntered = nodeColor
	mouseOver = true
	#print(port)
	#print("Moused Over")
	
func exited():
	mouseOver = false
	#print("Exited")
