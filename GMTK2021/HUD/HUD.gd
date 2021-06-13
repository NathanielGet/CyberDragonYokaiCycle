extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lives3
var lives2
var lives1
var lives0
var lifeBar
var score = 0

onready var AMMO_GREEN = $"/root/ProjectileTypes".attack_type.GREEN
onready var AMMO_BLUE = $"/root/ProjectileTypes".attack_type.BLUE
onready var AMMO_RED = $"/root/ProjectileTypes".attack_type.RED

onready var ammo_label = $AmmoCount
onready var ammo_sprite = $AmmoType
onready var score_label = $Score

# Called when the node enters the scene tree for the first time.
func _ready():
	lives3 = preload("res://assets/Lives3.png")
	lives2 = preload("res://assets/Lives2.png")
	lives1 = preload("res://assets/Lives1.png")
	lives0 = preload("res://assets/Lives0.png")
	
	lifeBar = $lifeBar

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func displayHealth(health):
	#print("OUCH!")
	match health:
		3:
			lifeBar.set_texture(lives3)
		2:
			lifeBar.set_texture(lives2)
		1:
			lifeBar.set_texture(lives1)
		0:
			lifeBar.set_texture(lives0)

func displayAmmo(ammo, type):
	match(type):
		AMMO_GREEN:
			ammo_sprite.set_animation("green")
		AMMO_BLUE:
			ammo_sprite.set_animation("blue")
		AMMO_RED:
			ammo_sprite.set_animation("red")
	
	ammo_label.text = str(ammo)

func displayScore(score, enemy):
	self.score += score
	score_label.text = str(self.score).pad_zeros(9)
