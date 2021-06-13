extends Node
signal move(target_enemy)
signal wave_complete

onready var enemy_type = preload("res://Enemy/GeneralEnemy.tscn")

var homes = []
var enemy_count

# Called when the node enters the scene tree for the first time.
func _ready():
	for point in get_tree().get_nodes_in_group("HomePoint"):
		homes.append(null)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Note, enemies should not be larger than 7
func spawn_wave(enemies):
	var count = 0
	for i in enemies:
		# Add enemy to tree
		var path_nodes = get_tree().get_nodes_in_group("path")
		var enemy = i.instance()
		enemy.set_name("enemy_%d"%count)
		path_nodes[count].add_child(enemy)
			
		# Connecting to the score signal
		enemy.connect("update_score", self, "kill_enemy")
		
		# Set the enemy's home point
		var pos = randi()%homes.size()
		while(homes[pos] != null):
			pos = (pos + 1)%homes.size()
		homes[pos] = path_nodes[count].get_node("enemy_%d"%count)
		homes[pos].position = get_node("Points/Point_%d"%pos).position
		
		count += 1
	
	enemy_count = count
		
func get_random_filled():
	# TODO make better maybe use find on homes array, and then random on that array
	var count = 0
	var i = randi()%homes.size()
	while homes[i] == null or homes[i].b_is_moving:
		if count == homes.size():
			return -1

		i = (i + 1)%homes.size()
		count += 1  
	return i
	
func get_random_empty():
	# TODO make better
	var i = randi()%homes.size()
	while homes[i] != null:
		i = (i + 1)%homes.size()
	return i

func move_enemy():
	var src = get_random_filled()
	var dest = get_random_empty()
	
	if get_random_filled() == -1:
		return
	
	var src_point = get_node("Points/Point_%d"%src)
	var dest_point = get_node("Points/Point_%d"%dest)
	var path = homes[src].get_parent()
	var x_pos = randi()%1400 + 600
	var midpoint = Vector2(x_pos, 0)
	
	path.get_curve().clear_points()
	
	path.get_curve().add_point(src_point.position, -midpoint)
	path.get_curve().add_point(dest_point.position, -1 * midpoint)
#	print_debug("Path origin: (%f, %f), Enemy origin: (%f, %f)\nPath target: (%f, %f)"%[path.curve.get_point_position(0).x, path.curve.get_point_position(0).y, 
#									homes[src].position.x, homes[src].position.y, path.curve.get_point_position(1).x, path.curve.get_point_position(1).y])
#	for i in get_tree().get_nodes_in_group("path"):
#		if(path.curve.get_point_count()):
#			print_debug("Path id: %s, Path origin: (%f, %f), Path target: (%f, %f)"%[i.name, i.curve.get_point_position(0).x, i.curve.get_point_position(0).y,
#			i.curve.get_point_position(1).x, i.curve.get_point_position(1).y])
	
	homes[src].move()
	homes[dest] = homes[src]
	homes[src] = null

func kill_enemy(score, enemy):
	var index = homes.find(enemy)
	if index == -1:
		print_debug("Missed Enemy in array")
		return
		
	homes[index] = null
	enemy_count -= 1
	enemy.queue_free()
	
	if !enemy_count:
		emit_signal("wave_complete")
