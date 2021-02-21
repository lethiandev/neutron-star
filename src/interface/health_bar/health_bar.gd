extends "res://interface/radial_bar/radial_bar.gd"

func _process(p_delta: float) -> void:
	visible = (get_progress() < 1.0)
