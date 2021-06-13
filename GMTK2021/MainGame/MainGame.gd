extends Node

onready var ShooterType = preload("res://Enemy/Shooter/ShooterEnemy.tscn")
onready var JammerType = preload("res://Enemy/Jammer/JammerEnemy.tscn")
onready var DummyType = preload("res://Enemy/Dummy/TestEnemy.tscn")

var running_enemy_movement_timer = false

#signal jam()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var enemyArray = [ShooterType, JammerType, ShooterType, ShooterType]
	$EnemyController.spawn_wave(enemyArray)
	
	#connect("jam", get_node("Minigame"), "activateJammer")
	#for i in range(0, enemyArray.size()):
		#if enemyArray[i] == JammerType:
			#emit_signal("jam")
	


func _process(delta):
	if !running_enemy_movement_timer:
		$EnemyController.move_enemy()
		$EnemyMovementTimer.start()
		#print_debug("Called move enemy from main")
		running_enemy_movement_timer = true



func _on_EnemyMovementTimer_timeout():
	running_enemy_movement_timer = false
