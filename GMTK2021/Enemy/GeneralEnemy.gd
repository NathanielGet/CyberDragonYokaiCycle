extends KinematicBody2D

signal update_score(score, this_enemy) # also notifies about death
var projectile = preload("res://../Projectile/Projectile.tscn")

export var projectile_speed = 750
export var default_speed = 80
export var max_speed = 400

export var health = 3
export var score = 1000
var screen_size

var b_is_moving = false
var velocity = Vector2()
var progress = 0
var cur_spd = 40

signal unjam()

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size #TODO update this to play area
	$Area2D.connect("body_entered", self, "_on_Area2D_body_entered")
	connect("unjam", get_node("../../../../Minigame"), "disableJammer")
	connect("update_score", get_node("../../../../HUD"), "displayScore")

func _physics_process(delta):
	if !b_is_moving:
		return
	
	if cur_spd < max_speed:
		cur_spd += 5
		
	var target = get_parent().curve.interpolate_baked(cur_spd * delta + progress)
	
	if cur_spd > (target-position).length():
		velocity = (target-position) * 4
	else:
		velocity = (target-position).normalized() * cur_spd
		
	velocity = move_and_slide(velocity)
	progress += cur_spd * delta
	
	if ((target-position).length() < 1) and (progress > 100):
		b_is_moving = false

func _on_Area2D_body_entered(body):
	#Apply the damage, and alert UI
	
	if(body.name.find("PlayerProjectile") != -1):
		take_damage(body.type)
		body.queue_free()
	
	# Check if dead
	if health < 1:
		#clean up with death function
		die()
		# Send death signal
		emit_signal("update_score", score, self)

func move():
	b_is_moving = true
#	print_debug("%s move called on %s"%[self.name, get_parent().name])
	cur_spd = default_speed
	progress = 0

func die():
	$CollisionShape2D.disabled = true
	$Area2D/CollisionShape2D.disabled = true
	emit_signal("unjam")

func take_damage(_type):
	health -= 1
