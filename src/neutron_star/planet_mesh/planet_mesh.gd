extends Node2D
tool

export(int) var segments: int = 20 \
	setget set_segments, get_segments

export(float) var height: float = 20.0 \
	setget set_height, get_height

var planet_mesh: ArrayMesh

func _init() -> void:
	planet_mesh = ArrayMesh.new()

func _ready() -> void:
	_update_planet_mesh()

func _draw() -> void:
	draw_mesh(planet_mesh, null)

func set_segments(p_segments: int) -> void:
	segments = p_segments
	_update_planet_mesh()

func get_segments() -> int:
	return segments

func set_height(p_height: float) -> void:
	height = p_height
	_update_planet_mesh()

func get_height() -> float:
	return height

func _update_planet_mesh() -> void:
	while planet_mesh.get_surface_count():
		planet_mesh.surface_remove(0)
	_generate_mesh_surface()

func _generate_mesh_surface() -> void:
	var meshdata = Array()
	meshdata.resize(Mesh.ARRAY_MAX)
	meshdata[Mesh.ARRAY_VERTEX] = _generate_vertices()
	meshdata[Mesh.ARRAY_COLOR] = _generate_colors()
	
	var type = Mesh.PRIMITIVE_TRIANGLE_FAN
	planet_mesh.add_surface_from_arrays(type, meshdata)

func _generate_vertices() -> PoolVector2Array:
	var points = PoolVector2Array([Vector2.ZERO])
	points.resize(segments + 2)
	
	for i in range(segments + 1):
		var angle = (TAU / segments) * i
		var normal = Vector2.RIGHT.rotated(angle)
		points[i + 1] = normal * height
	
	return points

func _generate_colors() -> PoolColorArray:
	var colors = PoolColorArray([Color(1.0, 1.0, 1.0)])
	colors.resize(segments + 2)
	
	for i in range(segments + 1):
		colors[i + 1] = Color(1.0, 1.0, 1.0)
	
	return colors
