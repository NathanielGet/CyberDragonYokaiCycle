extends RigidBody2D

enum proj_type{Red, Blue, Enemy}

var type = proj_type.Red

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

#func _process(delta):
#	pass

func setup(ptype : int):
	type = ptype
	$AnimatedSprite.play("default")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func destroy():
	linear_velocity = Vector2()
	#Play animation
	$AnimatedSprite.play("death")
	
