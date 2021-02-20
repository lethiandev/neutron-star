extends Area2D
class_name UnitBase

const UNIT_GROUP_A = "unit_a"
const UNIT_GROUP_B = "unit_b"
const UNIT_GROUP_X = "unit_x"
const UNIT_GROUP_P = "unit_p"

const UNIT_GROUP_ARRAY = [
	UNIT_GROUP_A,
	UNIT_GROUP_B,
	UNIT_GROUP_X,
	UNIT_GROUP_P
]

var unit_group: String

func _init() -> void:
	_assign_random_group()

func _assign_random_group() -> void:
	var limit = UNIT_GROUP_ARRAY.size()
	unit_group = UNIT_GROUP_ARRAY[randi() % limit]
	add_to_group(unit_group)

func hit() -> void:
	destroy()

func destroy() -> void:
	remove_from_group(unit_group)
	var explosion_node = _get_explosion_node()
	get_parent().add_child(explosion_node)
	explosion_node.transform = transform
	queue_free()

func _get_explosion_node() -> Node:
	var scene = preload("res://units/effects/explosion.tscn")
	return scene.instance()
