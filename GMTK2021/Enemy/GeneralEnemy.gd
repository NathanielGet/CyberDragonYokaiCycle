extends Area2D

signal update_score(score)

export var projectile_speed = 1500
export var acceleration = 1200
export var friction = 600
export var max_speed = 500
export (PackedScene) var Projectile_Scene

export var health = 3
export var score = 1000
var screen_size
var momentum = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size #TODO update this to play area


func _process(delta):
	var velocity = Vector2()
	
#	velocity.x -= 0.5

	if velocity.length() > 0:
		velocity = velocity.normalized() * acceleration * delta
		momentum += velocity
	elif momentum.length() < 10:
		momentum = Vector2()
		
	momentum -= momentum.normalized() * friction * delta
	momentum = momentum.clamped(max_speed)
	
	position += momentum * delta
	
	#TODO change these to the play area, not the screen size
#	position.x = clamp(position.x, 0, screen_size.x)
#	position.y = clamp(position.y, 0, screen_size.y)
	
	# Add animation stuffs here

func _on_EnemyCharacter_body_entered(_body):
	#Apply the damage, and alert UI
	health -= 1
#	emit_signal("update_health", health)
	
	# Check if dead
	if health < 1:
		# Play death animation
		# TODO
		
		# Send death signal
		emit_signal("update_score", score)
		
		# Play death sound
		#TODO
		
		# Call death function?
		queue_free()
	else:
		return
		
		# Play hurt sound
		#TODO

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()



