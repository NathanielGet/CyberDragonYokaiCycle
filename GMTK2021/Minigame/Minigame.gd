extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal testSignal1
signal testSignal2

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Background").play()
	get_node("whitePort/Sprite").play()
	get_node("redPort/Sprite").play()
	get_node("bluePort/Sprite").play()
	get_node("greenPort/Sprite").play()
	get_node("redPort2/Sprite").play()
	get_node("bluePort2/Sprite").play()
	get_node("greenPort2/Sprite").play()
	
	
	#connect("jam", self, "activateJammer")
	#connect("testSignal2", self, "disableJammer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if Input.is_action_pressed("fire"):
		#emit_signal("testSignal1")
			
func activateJammer():
	get_node("JammerOverlay").show()
	get_node("JammerOverlay").play()
	
func disableJammer():
	get_node("JammerOverlay").hide()
	get_node("JammerOverlay").stop()
