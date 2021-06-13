extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal new_game

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("new_game", get_node(".."), "restart")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	emit_signal("new_game")
	queue_free()


func _on_Button2_pressed():
	get_tree().change_scene("res://GUI/TitleScreen/MainMenu.tscn")
