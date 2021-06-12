extends "../GeneralEnemy.gd"

signal jam

func _ready():
	health = 3
	
func _process(delta):
	emit_signal("jam")
