extends "../GeneralEnemy.gd"

var projectile = preload("res://../Projectile/Projectile.tscn")
export var fire_rate = 60
var counter = 0

func _ready():
	._ready()
	health = 2

func _process(delta):
	._process(delta)
	
	if counter % fire_rate == 0:
		fire()
		counter = 0
	counter += 1
	
func _on_EnemyCharacter_body_entered(_body):
	._on_EnemyCharacter_body_entered(_body)
	print_debug("Test Shooter")

func fire():
	var proj = projectile.instance()
	owner.add_child(proj)
	proj.setup(0)
	proj.position = Vector2(position.x - 50, position.y)
	proj.linear_velocity = -Vector2(projectile_speed + momentum.x, momentum.y)
