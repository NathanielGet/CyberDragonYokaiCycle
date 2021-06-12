extends Line2D


# Declare member variables here.
var mouseOver = false
var lineStarted = false
var visitedNodes = ["start", "end", "stage2"]
var lastNodeEntered
var validConnection = false
var connectionStage = 1
var scaleOffset
# Called when the node enters the scene tree for the first time.
func _ready():
	clear_points()
	scaleOffset = get_node("..").scale
	


func _process(_delta):
	#print(mouseOver)
	if connectionStage == 1:
		
		if lineStarted:
#			print(get_global_mouse_position())
			add_point(get_global_mouse_position() / scaleOffset)
#			print(get_point_position(0))
			if self.points.size() > 2:
				remove_point(1)
		elif Input.is_action_pressed("click") and mouseOver == true:
			visitedNodes[0] = lastNodeEntered
			if lastNodeEntered.nodeRing == "center":
				lineStarted = true
			
			#while get_point_count() > length:
			#	remove_point(0)
		
		if Input.is_action_just_released("click"):
			lineStarted = false
			if mouseOver == true:
				visitedNodes[1] = lastNodeEntered
				checkConnection()
			else:
				clear_points()
				#print(visitedNodes)
	elif connectionStage == 2:
		if lineStarted:
			add_point(get_global_mouse_position() / scaleOffset)
			if self.points.size() > 3:
				remove_point(2)
		elif Input.is_action_pressed("click") and mouseOver == true:
			if visitedNodes[1] == lastNodeEntered:
				lineStarted = true
				validConnection = false
			elif visitedNodes[0] == lastNodeEntered:
				connectionStage = 1
			
			#while get_point_count() > length:
			#	remove_point(0)
		
		if lineStarted and Input.is_action_just_released("click"):
			lineStarted = false
			if mouseOver == true:
				visitedNodes[2] = lastNodeEntered
				checkConnection()
			else:
				remove_point(2)
		
		
		
func entered(node):
	lastNodeEntered = node
	mouseOver = true
	#print(port)
	#print("Moused Over")
	
func exited():
	mouseOver = false
	#print("Exited")

func checkConnection():
	if connectionStage == 1:
		if visitedNodes[0].nodeRing == "center" and visitedNodes[1].nodeRing == "inner":
			clear_points()
			#GET COORDS FOR PORTS
			add_point(visitedNodes[0].position)
			add_point(visitedNodes[1].position)
			connectionStage = 2
			spinOuter()
		else:
			clear_points()
	elif connectionStage == 2:
		if visitedNodes[2].nodeRing == "outer" and visitedNodes[1].nodeColor == visitedNodes[2].nodeColor:
			clear_points()
			#GET COORDS FOR PORTS
			add_point(visitedNodes[0].position)
			add_point(visitedNodes[1].position)
			add_point(visitedNodes[2].position)
			connectionStage = 1
		else:
			remove_point(2)

func spinOuter():
	var outerNodes = get_tree().get_nodes_in_group("outerNodes")
	var nodePositions = []
	for i in range(0, outerNodes.size()):
		nodePositions.append(outerNodes[i].position)
	randomize()
	nodePositions.shuffle()
	for i in range(0, outerNodes.size()):
		outerNodes[i].position = nodePositions[i]

