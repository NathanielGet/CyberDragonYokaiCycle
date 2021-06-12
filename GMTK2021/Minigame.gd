extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
