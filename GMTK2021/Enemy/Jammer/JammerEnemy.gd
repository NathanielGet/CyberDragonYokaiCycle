extends "../GeneralEnemy.gd"

signal jam()
signal unjam()
var alive = true

func _ready():
	health = 3
	connect("jam", get_node("../../../../Minigame"), "activateJammer")
	connect("unjam", get_node("../../../../Minigame"), "disableJammer")
	
func _process(delta):
	if alive:
		emit_signal("jam")

func die():
	alive = false
	emit_signal("unjam")
	$CollisionShape2D.set_deferred("disabled", true)
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
