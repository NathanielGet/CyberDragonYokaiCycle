extends KinematicBody2D

signal update_score(score, this_enemy) # also notifies about death


export var projectile_speed = 1500
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
		print_debug("Enemy origin (%f, %f)"%[position.x, position.y])

func _on_Area2D_body_entered(_body):
	#Apply the damage, and alert UI
	print_debug("here")
	health -= 1
#	emit_signal("update_health", health)
	
	# Check if dead
	if health < 1:
		#clean up with death function
		die()
		# Send death signal
		emit_signal("update_score", score, self)

	else:
		return
		
		# Play hurt sound
		#TODO

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func move():
	b_is_moving = true
#	print_debug("%s move called on %s"%[self.name, get_parent().name])
	cur_spd = default_speed
	progress = 0

func die():
	emit_signal("unjam")
