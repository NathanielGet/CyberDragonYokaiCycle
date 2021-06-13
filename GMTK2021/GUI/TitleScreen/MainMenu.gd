extends Node

signal start_game
signal how_to_play

# Called when the node enters the scene tree for the first time.
func _ready():
#	connect("start_game", get_parent(), "_on_TitleScreen_start_game")
#	connect("how_to_play", get_parent(), "_on_TitleScreen_how_to_play")
	get_node("GMTK2021").play()
	
func _on_Play_pressed():
#	emit_signal("start_game")
	get_tree().change_scene("res://MainGame/MainGame.tscn")


func _on_Instructions_pressed():
#	emit_signal("how_to_play")
	get_tree().change_scene("res://Instructions.tscn")
