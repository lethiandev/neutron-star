extends Node

var amplitude = 10.0
var shake_x = ShakeSampler.new()
var shake_y = ShakeSampler.new()

var ticks: float = 0.0

func _process(p_delta: float) -> void:
	_shake_it_baby(ticks)
	ticks += p_delta

func _shake_it_baby(p_ticks: float) -> void:
	var offset = Vector2()
	offset.x = shake_x.amplitude_at(ticks) * amplitude
	offset.y = shake_y.amplitude_at(ticks) * amplitude
	get_parent().offset = offset

func shake(p_duration: float, p_frequency: float) -> void:
	shake_x.next(p_duration, p_frequency)
	shake_y.next(p_duration, p_frequency)
	ticks = 0.0
