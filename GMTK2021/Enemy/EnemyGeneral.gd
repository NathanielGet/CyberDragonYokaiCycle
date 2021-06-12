extends KinematicBody2D

const MOVE_SPEED = 50
onready var detection = $Detection
onready var hitbox = $Hitbox
onready var animation = $AnimatedSprite
onready var audio = $AudioStreamPlayer
#signal enemy_defeated(points)
#signal screen_shake(length, power, priority)
var score = 1000
var center_screen;
var spawn_up_time = 0
var original_col_mask = collision_mask
var death_sound

var rng = RandomNumberGenerator.new()
func _ready():
	rng.randomize()
	center_screen = Vector2(rng.randi_range(-1440,1440), rng.randi_range(-720,720))
#	death_sound = preload("res://Enemy/Enemy Defeated.wav")
	add_to_group("enemies")
#	self.connect("enemy_defeated", $"../../HUD", "_on_Enemy_enemy_defeated")

onready var player = $"../../Player"
var velocity = Vector2.ZERO
var detected = false
var charge_up_time = 0

#Hurt Player
func damage():
	if player and hitbox.overlaps_body(player):
		var shake = get_tree().get_root().get_node("Main/GameScreen/ScreenShake")
		shake.screen_shake(2,11,101)
		player.kill()
		queue_free()
			
func hit():
	hitbox.set_collision_mask(0)
#	$AudioStreamPlayer.stream=death_sound
#	$AudioStreamPlayer.play()
	emit_signal("enemy_defeated", score)
#	var shake = get_tree().get_root().get_node("Main/GameScreen/ScreenShake")
#	shake.screen_shake(1,10,100)
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
