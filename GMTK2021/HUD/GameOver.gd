extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal new_game

var fadeIn = true

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("new_game", get_node(".."), "restart")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fadeIn:
		fadeIn = false
		$Tween.interpolate_property(self, "module", Color(1,1,1,0), Color(1,1,1,1), 5, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Tween.start()


func _on_Button_pressed():
	emit_signal("new_game")
	queue_free()


func _on_Button2_pressed():
	get_tree().change_scene("res://GUI/TitleScreen/MainMenu.tscn")
