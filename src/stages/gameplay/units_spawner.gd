extends Node

const UnitBaseScene = preload("res://units/unit_base/unit_base.tscn")

func _ready() -> void:
	yield(get_tree().create_timer(5.0), "timeout")
	_spawn_enemies()

func _spawn_enemies() -> void:
	_spawn_unit(UnitBaseScene, Vector2(-80.0, 0.0))
	_spawn_unit(UnitBaseScene, Vector2(80.0, 0.0))
	yield(get_tree().create_timer(4.0), "timeout")
	_spawn_unit(UnitBaseScene, Vector2(-60.0, -20.0))
	_spawn_unit(UnitBaseScene, Vector2(60.0, -20.0))
	yield(get_tree().create_timer(4.0), "timeout")
	_spawn_unit(UnitBaseScene, Vector2(-60.0, 20.0))
	_spawn_unit(UnitBaseScene, Vector2(60.0, 20.0))

func _spawn_unit(p_type: PackedScene, p_from: Vector2) -> void:
	var unit_node = _instance_unit(p_type)
	unit_node.transform.origin = p_from

func _instance_unit(p_type: PackedScene) -> Node2D:
	var unit_node = p_type.instance()
	get_parent().add_child(unit_node)
	return unit_node
