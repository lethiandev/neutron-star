extends Node2D

var silent: bool = false
var particles_offset: Vector2 = Vector2()
var color_delay: float = 0.4

func _ready() -> void:
	_delay_destroy()

func _delay_destroy() -> void:
	yield(get_tree().create_timer(color_delay), "timeout")
	self_modulate = Color.transparent
	yield(get_tree().create_timer(1.0 - color_delay), "timeout")
	queue_free()

func _process(p_delta: float) -> void:
	$AudioStreamPlayer.stream_paused = silent
	$Particles.transform.origin = particles_offset
