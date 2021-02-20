extends ParallaxBackground

var direction: Vector2 = Vector2(0.45, 1.0).normalized()
var speed: float = 220.0

func _process(p_delta: float) -> void:
	direction = direction.rotated(TAU * p_delta * 0.001)
	direction = direction.normalized()
	scroll_base_offset += direction * speed * p_delta
