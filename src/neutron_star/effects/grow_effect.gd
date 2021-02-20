extends Node

var level: float = 0.0

func _process(p_delta: float) -> void:
	var next_level = max(0.1, _get_next_level(p_delta))
	var new_scale = 1.0 + next_level * 2.0
	get_parent().scale = Vector2.ONE * new_scale

func _get_next_level(p_delta: float) -> float:
	var new_level = _get_max_spectrum_value()
	if level < new_level:
		level = new_level
	else:
		var by = p_delta * 0.5
		level = max(0.0, level - by)
	return level

func _get_max_spectrum_value() -> float:
	var spectrum = 0.0
	
	for value in Spectrogram.histogram:
		spectrum = max(spectrum, value)
	
	return spectrum
