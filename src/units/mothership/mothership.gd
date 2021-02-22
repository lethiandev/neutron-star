extends UnitBase

signal hitted()

func _ready() -> void:
	set_unit_group("")

# Workaround for method call keyframe bug
func randomize_group() -> void:
	.randomize_group()

func fire_missiles() -> void:
	$Cannons.shoot()

func hit() -> void:
	_spawn_explosions(2, 4)
	emit_signal("hitted")

func destroy(p_silent: bool = false) -> void:
	_spawn_destroy_explosions()
	set_unit_group("")

func _spawn_destroy_explosions() -> void:
	while true:
		_spawn_explosions(5, 10, 0.9)
		yield(get_tree().create_timer(0.65), "timeout")

func _spawn_explosions(p_min: int, p_max: int, p_color_delay: float = 0.4) -> void:
	_remove_explosions()
	for i in range(randi() % (p_max - p_min) + p_min):
		_spawn_explosion(not i == 0, p_color_delay)

func _remove_explosions() -> void:
	for child in get_children():
		if child is preload("res://units/explosion/explosion.gd"):
			child.queue_free()

func _spawn_explosion(p_is_next: bool, p_color_delay: float) -> void:
	var explosion_node = _get_explosion_node()
	explosion_node.silent = p_is_next
	explosion_node.color_delay = p_color_delay
	# Hide also texture if not first element
	if p_is_next:
		explosion_node.texture = null
	add_child(explosion_node)

func _get_explosion_node() -> Node:
	var random = Vector2(randf(), randf()) * 2.0 - Vector2.ONE
	var explosion_node = ._get_explosion_node() as Sprite
	explosion_node.texture = preload("./mothership_hit.png")
	explosion_node.particles_offset = Vector2(46.0, 22.0) * random
	explosion_node.transform = Transform()
	return explosion_node
