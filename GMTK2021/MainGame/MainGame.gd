extends Node

onready var ShooterType = preload("res://Enemy/Shooter/ShooterEnemy.tscn")
onready var JammerType = preload("res://Enemy/Jammer/JammerEnemy.tscn")
onready var DummyType = preload("res://Enemy/Dummy/TestEnemy.tscn")

var running_enemy_movement_timer = false
var wave_count = 0

onready var over_screen = preload("res://HUD/GameOver.tscn")
#signal jam()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	create_wave(2)
	
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


func _on_EnemyController_wave_complete():
	yield(get_tree().create_timer(3), "timeout")
	wave_count += 1
	create_wave(2)

func create_wave(wait_time):
	var enemyArrays = []
	enemyArrays.append([DummyType, DummyType])
	enemyArrays.append([DummyType, DummyType, ShooterType])
	enemyArrays.append([JammerType, DummyType, ShooterType])
	enemyArrays.append([ShooterType, DummyType, ShooterType])
	enemyArrays.append([ShooterType, JammerType, ShooterType, DummyType, DummyType])
	
	$EnemyMovementTimer.set_wait_time(wait_time)
	$EnemyController.spawn_wave(enemyArrays[wave_count])

func game_over():
	self.add_child(over_screen.instance())
