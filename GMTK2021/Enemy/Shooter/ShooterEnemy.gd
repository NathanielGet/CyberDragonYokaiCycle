extends "../GeneralEnemy.gd"

export var fire_rate = 1
var can_fire = true
var counter = 0

enum shooter_type {RED, GREEN, BLUE}
var my_type = shooter_type.RED

func _ready():
	health = 2
	my_type = randi()%3 # Number of shooter types
	$AnimatedSprite.play("%d"%my_type)

func _process(delta):
	if b_is_moving && can_fire:
		fire()

# TODO Add arc of aim
func fire():
	can_fire = false
	var proj = projectile.instance()
	get_node("/root/MainGame").add_child(proj)
	proj.setup(my_type)
	proj.position = Vector2(position.x - 50, position.y)
	proj.linear_velocity = -Vector2(projectile_speed, 0)
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_fire = true

func take_damage(type):
	print_debug("Damage type %d"%type)
	if type == my_type:
		.take_damage(type)
