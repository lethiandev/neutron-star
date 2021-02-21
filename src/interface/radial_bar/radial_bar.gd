extends TextureRect

export(float, 0.0, 1.0) var progress: float = 1.0 \
	setget set_progress, get_progress

func _init() -> void:
	# Clone shader material for every radial bar
	# Allows updating shader params independently
	if material is ShaderMaterial:
		_clone_material()

func _clone_material() -> void:
	var cloned_material = material.duplicate()
	material = cloned_material

func set_progress(p_progress: float) -> void:
	progress = clamp(p_progress, 0.0, 1.0)
	_update_shader_progress()

func get_progress() -> float:
	return progress

func _update_shader_progress() -> void:
	if material is ShaderMaterial:
		material.set_shader_param("progress", progress)
