extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var score_list = [0,0,0,0,0]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func receive_score(new_score):
	var load_score = new_score
	var temp
	for i in range(0, score_list.size()):
		if load_score > score_list[i]:
			temp = load_score
			score_list[i] = temp
			load_score = score_list[i]
			
	print(score_list)
