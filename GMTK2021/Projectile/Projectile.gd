extends RigidBody2D

onready var type = $"/root/ProjectileTypes".attack_type.RED

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

#func _process(delta):
#	pass

func setup(ptype : int):
	type = ptype
	
	if ptype == $"/root/ProjectileTypes".attack_type.RED:
		$Particles2D.process_material.color_ramp.gradient.colors[0] =  Color(0.9647,0.0039,0.2078,1)
		$Particles2D.process_material.color_ramp.gradient.colors[1] =  Color(0.3960,0.0823,0.6078,1)
	elif ptype == $"/root/ProjectileTypes".attack_type.GREEN:
		$Particles2D.process_material.color_ramp.gradient.colors[0] =  Color(0.2667,0.5372,0.0235,1)
		$Particles2D.process_material.color_ramp.gradient.colors[1] =  Color(0.8203,0.7698,0.4422,1)
		
	else:
		$Particles2D.process_material.color_ramp.gradient.colors[0] =  Color(0.0666,0.7176,0.9450,1)
		$Particles2D.process_material.color_ramp.gradient.colors[1] =  Color(0.0078,0.3803,0.9450,1)
		
	$AnimatedSprite.play("%d"%[type])

func _on_VisibilityNotifier2D_screen_exited():
#	print_debug("Projectile Free")
	queue_free()

func destroy():
	linear_velocity = Vector2()
	#Play animation
	$AnimatedSprite.play("death")

func _on_Projectile_body_entered(_body):
	print_debug("Projectile Hit")
	queue_free()
