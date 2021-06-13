extends "../GeneralEnemy.gd"

export var fire_rate = 1
var can_fire = true
var counter = 0

func _ready():
	health = 2

func _process(delta):
	if b_is_moving && can_fire:
		fire()

func fire():
	can_fire = false
	var proj = projectile.instance()
	get_node("/root/MainGame").add_child(proj)
	proj.setup(0)
	proj.position = Vector2(position.x - 50, position.y)
	proj.linear_velocity = -Vector2(projectile_speed, 0)
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_fire = true
