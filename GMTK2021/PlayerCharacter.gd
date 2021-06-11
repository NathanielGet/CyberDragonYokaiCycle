extends Area2D

signal update_health(health)
signal death

export var acceleration = 1200
export var friction = 600
export var max_speed = 500

var health = 3
var screen_size
var momentum = Vector2()

var invuln = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size #TODO update this to play area


func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * acceleration * delta
		momentum += velocity
		
	momentum -= momentum.normalized() * friction * delta
	momentum = momentum.clamped(max_speed)
	
	position += momentum * delta
	
	#TODO change these to the play area, not the screen size
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	# Add animation stuffs here



func _on_PlayerCharacter_body_entered(_body):
	# If we are invulnerable, do nothing
	if invuln:
		return
	
	
	#Apply the damage, and alert UI
	health -= 1
	emit_signal("update_health", health)
	
	# Check if dead
	if health < 1:
		# Play death animation
		# TODO
		
		# Send death signal
		emit_signal("death")
		
		# Play death sound
		#TODO
		
		# Call death function?
		
	else:
		# Set a timer for invincibility and set invuln status
		$InvulnTimer.start()
		invuln = true
		
		# Play hurt sound
		#TODO
		
		
		
		
func _on_InvulnTimer_timeout():
	invuln = false
	
	#Potentially change animation state here?
