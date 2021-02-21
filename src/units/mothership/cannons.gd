extends Node2D

const MissileScene = preload("res://units/mothership/missile/missile.tscn")

func shoot() -> void:
	$ShootPlayer.play()
	_spawn_missiles()

func _spawn_missiles() -> void:
	for i in range(get_child_count()):
		_spawn_missile_node(i)

func _spawn_missile_node(p_index: int) -> Node2D:
	var missile_node = MissileScene.instance()
	var hotspot_node = get_child(p_index)
	var target = get_node("../..")
	
	if not hotspot_node is Node2D:
		return null
	
	missile_node.position = get_parent().position
	target.add_child(missile_node)
	
	var pos = hotspot_node.position
	missile_node.speed *= sign(pos.x)
	missile_node.position += pos
	
	return missile_node
