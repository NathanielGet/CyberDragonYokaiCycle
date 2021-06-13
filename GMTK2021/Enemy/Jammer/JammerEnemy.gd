extends "../GeneralEnemy.gd"

signal jam()

func _ready():
	health = 3
	connect("jam", get_node("../../../../Minigame"), "activateJammer")
	
func _process(delta):
	emit_signal("jam")
