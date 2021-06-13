extends Area2D

signal update_health(health)
signal death
signal ammo_empty()
signal update_ammo(ammo, type)

export var projectile_speed = 1500
export var acceleration = 1200
export var friction = 600
export var max_speed = 500
export var rate_of_fire = 0.25

const MAX_AMMO = 5

export var health = 3
export var ammo = 0

var screen_size
var momentum = Vector2()

var projectile = preload("res://Projectile/PlayerProjectile.tscn")
var cool_down = false #Cooldown from shooting
var can_play_sound = true #Cooldown for empty click

onready var proj_type = $"/root/ProjectileTypes".attack_type.RED

var invuln = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#screen_size = get_viewport_rect().size #TODO update this to play area
	connect("ammo_empty", get_node("../Minigame/Wire"), "resetPanel")
	connect("update_health", get_node("../HUD"), "displayHealth")
	connect("update_ammo", get_node("../HUD"), "displayAmmo")
	connect("death", get_node(".."), "game_over")
	connect("death", get_node("../EnemyController"), "clear_enemies")


func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("fire"):
		if(!cool_down):
			fire()
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
	elif momentum.length() < 10:
		momentum = Vector2()
		
	momentum -= momentum.normalized() * friction * delta
	momentum = momentum.clamped(max_speed)
	
	position += momentum * delta
	
	#TODO change these to the play area, not the screen size
	position.x = clamp(position.x, 0, 1032)
	position.y = clamp(position.y, 232, 720)
	
	# Add animation stuffs here



func _on_PlayerCharacter_body_entered(body):
	# If we are invulnerable, do nothing
	#print_debug("Here")
	if invuln:
		return
	
	if(body.name.find("EnemyProjectile") != -1):
		body.queue_free()
		
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
		$Dead.play()
		
		# Call death function?
#		$DeathTimer.start()
		$Vanish.interpolate_property($AnimatedSprite, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Vanish.start()
		
	else:
		$Hit.play()
		# Set a timer for invincibility and set invuln status
		$InvulnTimer.start()
		invuln = true
		
		# Gray out when invincible
		$AnimatedSprite.modulate = Color(0.18, 0.31, 0.31);
		
		# Play hurt sound
		#TODO
		
		
		
		
func _on_InvulnTimer_timeout():
	invuln = false
	# Return back to original color
	$AnimatedSprite.modulate = Color(1,1,1);
	
	#Potentially change animation state here?

# Spawn and fire a projectile
func fire():
	if ammo > 0:
		var proj = projectile.instance()
		owner.add_child(proj)
		proj.setup(proj_type)
		proj.position = Vector2(position.x + 50, position.y)
		proj.linear_velocity = Vector2(projectile_speed + momentum.x, momentum.y )
		$Shoot.play()
		cool_down = true
		yield(get_tree().create_timer(rate_of_fire), "timeout")
		cool_down = false
		ammo -= 1
		emit_signal("update_ammo", ammo, proj_type)
		if ammo == 0:
			emit_signal("ammo_empty")			
	elif can_play_sound:
		$EmptyMag.play()
		can_play_sound = false
		yield(get_tree().create_timer(rate_of_fire), "timeout")
		can_play_sound = true

func reload(ammo_type):
	match ammo_type:
		"red":
			proj_type = $"/root/ProjectileTypes".attack_type.RED
		"blue":
			proj_type = $"/root/ProjectileTypes".attack_type.BLUE
		"green":
			proj_type = $"/root/ProjectileTypes".attack_type.GREEN
	
	ammo = MAX_AMMO
	cool_down = false
	emit_signal("update_ammo", ammo, proj_type)


func _on_DeathTimer_timeout():
	queue_free()


func _on_Vanish_tween_completed(object, key):
	queue_free()
