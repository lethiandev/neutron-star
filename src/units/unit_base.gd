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

var unit_group: String \
	setget set_unit_group, get_unit_group

func _ready() -> void:
	randomize_group()

func randomize_group() -> void:
	var random_group = _get_random_unit_group()
	set_unit_group(random_group)

func _get_random_unit_group(p_exclude: Array = []) -> String:
	var limit = UNIT_GROUP_ARRAY.size()
	var random_group = UNIT_GROUP_ARRAY[randi() % limit]
	return random_group

func hit() -> void:
	destroy()

func destroy(p_silent: bool = false) -> void:
	var explosion_node = _get_explosion_node()
	get_parent().add_child(explosion_node)
	explosion_node.silent = p_silent
	
	set_unit_group("")
	queue_free()

func _get_explosion_node() -> Node:
	var packed_scene = preload("res://units/explosion/explosion.tscn")
	var explosion_node = packed_scene.instance()
	explosion_node.transform = transform
	return explosion_node

func set_unit_group(p_group: String) -> void:
	if unit_group:
		remove_from_group(unit_group)
	
	unit_group = p_group
	if unit_group:
		add_to_group(unit_group)

func get_unit_group() -> String:
	return unit_group
