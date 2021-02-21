extends Sprite

var speed: float = 1.0 \
	setget set_speed, get_speed

var accel: float = 10.0

func _process(p_delta: float) -> void:
	translate(Vector2.RIGHT * speed)
	speed += accel * p_delta * sign(speed)
	_update_boundaries()

func _update_boundaries() -> void:
	if abs(position.x) > 400:
		queue_free()

func set_speed(p_speed: float) -> void:
	flip_h = (p_speed < 0.0)
	speed = p_speed

func get_speed() -> float:
	return speed
