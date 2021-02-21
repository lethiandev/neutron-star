extends Position2D

const GROUP_KEY_IMAGES = {
	UnitBase.UNIT_GROUP_A: preload("./key_a.png"),
	UnitBase.UNIT_GROUP_B: preload("./key_b.png"),
	UnitBase.UNIT_GROUP_X: preload("./key_x.png"),
	UnitBase.UNIT_GROUP_P: preload("./key_p.png"),
}

export(float) var arm_length: float = 36.0

func _process(p_delta: float) -> void:
	var parent_node = get_parent()
	if "unit_group" in parent_node:
		var group = parent_node.unit_group
		_set_key_image(group)
	
	var world_center = Vector2(320.0, 240.0) * 0.5
	var unit_center = get_parent().global_position - world_center
	var angle = (unit_center * -1.0).angle()
	var offset = Vector2(arm_length, 0.0).rotated(angle)
	$Sprite.position = offset

func _set_key_image(group_name: String) -> void:
	if GROUP_KEY_IMAGES.has(group_name):
		var image = GROUP_KEY_IMAGES[group_name]
		$Sprite.texture = image
	else:
		$Sprite.texture = null
