extends Node
signal move(target_enemy)

onready var enemy_type = preload("res://Enemy/Enemy.tscn")
var homes = []

# Called when the node enters the scene tree for the first time.
func _ready():
	#TODO delete me
	randomize()
	
	for point in get_tree().get_nodes_in_group("HomePoint"):
		homes.append(null)
	
	spawn_wave([0,1,2,0,0])
	
	# TODO delete me later
	var null_point = randi()%8
	while (homes[null_point] != null):
		null_point = (null_point + 1) % homes.size()
	
	var occupied = randi()%8
	while (homes[occupied] == null):
		occupied = (occupied + 1) % homes.size()
		
	move_enemy(occupied, null_point)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Note, enemies should not be larger than 7
func spawn_wave(enemies):
	var count = 0
	for i in enemies:
		# Add enemy to tree
		
		var path_nodes = get_tree().get_nodes_in_group("path")
		var enemy = enemy_type.instance()
		enemy.set_name("enemy_%d"%count)
		path_nodes[count].add_child(enemy)
			
		# TODO init enemy type here
		
		# Set the enemy's home point
		var pos = randi()%8
		while(homes[pos] != null):
			pos = (pos + 1)%8
		homes[pos] = path_nodes[count].get_node("enemy_%d"%count)
		homes[pos].position = get_node("Points/Point_%d"%pos).position
		
		count += 1

func move_enemy(src, dest):
	var src_point = get_node("Points/Point_%d"%src)
	var dest_point = get_node("Points/Point_%d"%dest)
	var path = homes[src].get_parent()
	var x_pos = randi()%1400 + 600
	print_debug(x_pos)
	var midpoint = Vector2(x_pos, 0)
	
	path.get_curve().clear_points()
	
	path.get_curve().add_point(src_point.position, -midpoint)
	path.get_curve().add_point(dest_point.position, -1 * midpoint)
	
	homes[src].move()
	homes[dest] = homes[src]
	homes[src] = null
