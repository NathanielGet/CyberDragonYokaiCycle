extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Right_pressed():
	get_tree().change_scene("res://GUI/Instruction/Instruction_Enemy.tscn")


func _on_Menu_pressed():
	get_tree().change_scene("res://GUI/TitleScreen/MainMenu.tscn")


func _on_Left_pressed():
	get_tree().change_scene("res://GUI/Instruction/Instruction_Control.tscn")
