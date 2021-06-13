extends Node

onready var ShooterType = preload("res://Enemy/Shooter/ShooterEnemy.tscn")
onready var JammerType = preload("res://Enemy/Jammer/JammerEnemy.tscn")
onready var DummyType = preload("res://Enemy/Dummy/TestEnemy.tscn")

var running_enemy_movement_timer = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$EnemyController.spawn_wave([ShooterType, JammerType, ShooterType, ShooterType])
	


func _process(delta):
	if !running_enemy_movement_timer:
		$EnemyController.move_enemy()
		$EnemyMovementTimer.start()
		#print_debug("Called move enemy from main")
		running_enemy_movement_timer = true



func _on_EnemyMovementTimer_timeout():
	running_enemy_movement_timer = false
