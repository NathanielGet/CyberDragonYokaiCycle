extends KinematicBody2D

export var max_speed = 400

var cur_spd = 40
var b_is_moving = false
var velocity = Vector2()
var progress = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	
	if (target-position).length() < 1:
		b_is_moving = false
		print_debug("here")

func move():
	b_is_moving = true
	cur_spd = 80
	progress = 0
