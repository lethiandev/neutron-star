extends Position2D

const GROUP_KEY_IMAGES = {
	UnitBase.UNIT_GROUP_A: preload("./key_a.png"),
	UnitBase.UNIT_GROUP_B: preload("./key_b.png"),
	UnitBase.UNIT_GROUP_X: preload("./key_x.png"),
	UnitBase.UNIT_GROUP_P: preload("./key_p.png"),
}

func _ready() -> void:
	var parent_node = get_parent()
	if parent_node is UnitBase:
		var group = parent_node.unit_group
		_set_key_image(group)

func _set_key_image(group_name: String) -> void:
	var image = GROUP_KEY_IMAGES[group_name]
	$Sprite.texture = image
