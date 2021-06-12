extends "../GeneralEnemy.gd"

signal jam

func _ready():
	._ready()
	health = 3
	
func _process(delta):
	._process(delta)
	emit_signal("jam")
	
func _on_EnemyCharacter_body_entered(_body):
	._on_EnemyCharacter_body_entered(_body)
	print_debug("Test Jammer")
