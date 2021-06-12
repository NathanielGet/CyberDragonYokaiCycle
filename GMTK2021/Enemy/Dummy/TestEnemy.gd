extends "../GeneralEnemy.gd"

func _ready():
	._ready()
	health = 1
	
func _on_EnemyCharacter_body_entered(_body):
	._on_EnemyCharacter_body_entered(_body)
	print_debug("Test Buddy")
