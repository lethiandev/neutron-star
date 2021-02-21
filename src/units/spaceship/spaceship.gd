extends "res://units/unit_base.gd"

func _get_explosion_node() -> Node:
	var explosion_node = ._get_explosion_node() as Sprite
	explosion_node.texture = preload("./spaceship_hit.png")
	return explosion_node
