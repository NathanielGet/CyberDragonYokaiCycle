extends RigidBody2D

onready var type = $"/root/ProjectileTypes".attack_type.RED

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

#func _process(delta):
#	pass

func setup(ptype : int):
	type = ptype
	$AnimatedSprite.play("%d"%[type])

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func destroy():
	linear_velocity = Vector2()
	#Play animation
	$AnimatedSprite.play("death")

func _on_Projectile_body_entered(_body):
	print_debug("Projectile Hit")
	queue_free()
