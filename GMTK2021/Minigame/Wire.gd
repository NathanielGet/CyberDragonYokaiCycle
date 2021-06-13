extends Line2D


# Declare member variables here.
var mouseOver = false
var lineStarted = false
var visitedNodes = ["start", "end", "stage2"]
var lastNodeEntered
var validConnection = false
var connectionStage = 1
var scaleOffset
var newWire = true

signal load_ammo(ammo_type)

# Called when the node enters the scene tree for the first time.
func _ready():
	clear_points()
	scaleOffset = get_node("..").scale
	connect("load_ammo", self, "testAmmoSignal")
	get_tree().call_group("outerNodes", "deactivate")
	


func _process(_delta):
	if connectionStage == 1:
		# Check if line is currently being drawn
		if lineStarted:
			# Draw line
			add_point(get_global_mouse_position() / scaleOffset)
			
			# Prevent line from being larger than two points
			if self.points.size() > 2:
				remove_point(1)
		
		# If the line hasn't been drawn, check for mouse click on a node
		elif Input.is_action_pressed("click") and mouseOver == true and newWire:
			# If we're breaking a connection, shuffle the inner ring ports
			if validConnection and newWire:
				spinInner()
				get_tree().call_group_flags(2, "outerNodes", "deactivate")
				get_tree().call_group_flags(2, "innerNodes", "activate")
				get_tree().call_group_flags(2, "innerNodes", "sync_frame")
				validConnection = false
				newWire = false
				clear_points()
			
			# Regardless, add the node we just hovered over to visitedNodes
			visitedNodes[0] = lastNodeEntered
			
			# Make sure the starting point is the center port
			if lastNodeEntered.nodeRing == "center":
				lineStarted = true
		
		# Check to see if connection should be formed when mouse is released
		if lineStarted and mouseOver:
			# Register node hovered over
			visitedNodes[1] = lastNodeEntered
			
			# If the new node isn't the same as the registered node, try to establish connection
			if visitedNodes[0] != visitedNodes[1]:
				checkConnection()

				
	elif connectionStage == 2:
		# Check if line is currently being drawn		
		if lineStarted:
			# Draw line
			add_point(get_global_mouse_position() / scaleOffset)
			
			# Prevent line from being larger than two points
			if self.points.size() > 3:
				remove_point(2)
			
			# If you hover over a node, try to connect
			if mouseOver:
				# Register new node
				visitedNodes[2] = lastNodeEntered;
				
				# Check that you're not hovering same nodes already visited
				if visitedNodes[0] != lastNodeEntered and visitedNodes[1] != lastNodeEntered:
					checkConnection()
		
		# Check to see if connection should be formed when mouse is released
		if lineStarted and validConnection:
			# Stop drawing line
			lineStarted = false
			newWire = false
		

	if Input.is_action_just_released("click"):
		lineStarted = false
		connectionStage = 1
		newWire = true
		
		if !validConnection:
			get_tree().call_group_flags(2, "outerNodes", "deactivate")
			get_tree().call_group_flags(2, "innerNodes", "activate")
			get_tree().call_group_flags(2, "innerNodes", "sync_frame")
			clear_points()

# Socket function for signal when mouse hovers over port
func entered(node):
	lastNodeEntered = node
	mouseOver = true
	print(node.nodeColor, node.nodeRing)
	#print("Moused Over")

# Socket function for signal when mouse moves away from port
func exited():
	mouseOver = false
	#print("Exited")

# Checks connection, adding or removing points to line as necessary
func checkConnection():
	if connectionStage == 1:
		# Check if the wire starts from the center to an inner ring node
		if visitedNodes[0].nodeRing == "center" and visitedNodes[1].nodeRing == "inner":
			# Clear the points from the line, then update with the port center coordinates
			clear_points()
			#GET COORDS FOR PORTS
			add_point(visitedNodes[0].position)
			add_point(visitedNodes[1].position)
			
			# Connection formed, advance to second-stage connection
			connectionStage = 2
			
			# Shuffle the outer ring ports
			spinOuter()
			get_tree().call_group_flags(2, "outerNodes", "activate")
			get_tree().call_group_flags(2, "innerNodes", "deactivate")
			visitedNodes[1].activate()
			visitedNodes[1].sync_frame()
			get_tree().call_group_flags(2, "outerNodes", "sync_frame")
			
			
	elif connectionStage == 2:
		# Check if the wire ends on an outer ring and that the colors match
		if visitedNodes[2].nodeRing == "outer" and visitedNodes[1].nodeColor == visitedNodes[2].nodeColor:
			# Clear the points from the line, then update with the port center coordinates
			clear_points()
			#GET COORDS FOR PORTS
			add_point(visitedNodes[0].position)
			add_point(visitedNodes[1].position)
			add_point(visitedNodes[2].position)
			
			# Connection complete, prep for reset to first stage on next click
			connectionStage = 1
			validConnection = true
			get_tree().call_group_flags(2, "outerNodes", "deactivate")
			visitedNodes[2].activate()
			visitedNodes[1].sync_frame()
			visitedNodes[2].sync_frame()
			emit_signal("load_ammo", visitedNodes[1].nodeColor)
		elif visitedNodes[2].nodeRing != "inner":
			# If not a valid connection, erase the last point
			clear_points()
			connectionStage = 1
			lineStarted = false
			get_tree().call_group_flags(2, "outerNodes", "deactivate")
			get_tree().call_group_flags(2, "innerNodes", "activate")
			get_tree().call_group_flags(2, "innerNodes", "sync_frame")

# Shuffles positions of outer ports
func spinOuter():
	var outerNodes = get_tree().get_nodes_in_group("outerNodes")
	var nodePositions = []
	for i in range(0, outerNodes.size()):
		nodePositions.append(outerNodes[i].position)
	randomize()
	nodePositions.shuffle()
	for i in range(0, outerNodes.size()):
		outerNodes[i].position = nodePositions[i]

# Shuffles positions of inner ports
func spinInner():
	var innerNodes = get_tree().get_nodes_in_group("innerNodes")
	var nodePositions = []
	for i in range(0, innerNodes.size()):
		nodePositions.append(innerNodes[i].position)
	randomize()
	nodePositions.shuffle()
	for i in range(0, innerNodes.size()):
		innerNodes[i].position = nodePositions[i]

# Test function for ammo signal
func testAmmoSignal(ammo):
	print("Loaded ammo type: ", ammo)
