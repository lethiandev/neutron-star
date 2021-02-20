extends Node

const SpaceshipScene = preload("res://units/spaceship/spaceship.tscn")

func _ready() -> void:
	yield(get_tree().create_timer(5.0), "timeout")
	_spawn_enemies()

func _spawn_enemies() -> void:
	_spawn_unit(SpaceshipScene, Vector2(200.0, 0.0))
	_spawn_unit(SpaceshipScene, Vector2(-200.0, 0.0))
	yield(get_tree().create_timer(4.0), "timeout")
	_spawn_unit(SpaceshipScene, Vector2(200.0, -20.0))
	_spawn_unit(SpaceshipScene, Vector2(-200.0, -20.0))
	yield(get_tree().create_timer(4.0), "timeout")
	_spawn_unit(SpaceshipScene, Vector2(200.0, 20.0))
	_spawn_unit(SpaceshipScene, Vector2(-200.0, 20.0))
	yield(get_tree().create_timer(4.0), "timeout")
	_spawn_enemies()

func _spawn_unit(p_type: PackedScene, p_from: Vector2) -> void:
	var unit_node = p_type.instance()
	unit_node.transform.origin = p_from
	get_parent().add_child(unit_node)
