extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var AMMO_GREEN = $"/root/ProjectileTypes".attack_type.GREEN
onready var AMMO_BLUE = $"/root/ProjectileTypes".attack_type.BLUE
onready var AMMO_RED = $"/root/ProjectileTypes".attack_type.RED

onready var ammo_label = $UI/Ammo

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func displayHealth(health):
	print("OUCH!")
	if health == 1:
		pass
	elif health == 2:
		pass
	elif health == 3:
		pass

func displayAmmo(ammo, type):
	var ammo_type
	match(type):
		AMMO_GREEN:
			ammo_type = "green"
		AMMO_BLUE:
			ammo_type = "blue"
		AMMO_RED:
			ammo_type = "red"
	
	ammo_label.text = "Ammo: " + ammo_type + " " + str(ammo)
