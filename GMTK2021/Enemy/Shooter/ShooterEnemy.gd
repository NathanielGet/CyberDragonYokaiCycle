extends "../GeneralEnemy.gd"

var projectile = preload("res://../Projectile/Projectile.tscn")
export var fire_rate = 60
var counter = 0

func _ready():
	health = 2

func _process(delta):
	if counter % fire_rate == 0:
		fire()
		counter = 0
	counter += 1

func fire():
	var proj = projectile.instance()
	get_node("/root/MainGame").add_child(proj)
	proj.setup(0)
	proj.position = Vector2(position.x - 50, position.y)
	proj.linear_velocity = -Vector2(projectile_speed + velocity.x, velocity.y)
