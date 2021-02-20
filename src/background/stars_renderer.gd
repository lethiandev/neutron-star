extends Node2D
tool

var stars_mesh: ArrayMesh

export(int) var stars_count: int = 0 \
	setget set_stars_count, get_stars_count

func _init() -> void:
	stars_mesh = ArrayMesh.new()

func _ready() -> void:
	_update_stars_mesh()

func _draw() -> void:
	draw_mesh(stars_mesh, null)

func set_stars_count(p_count: int) -> void:
	stars_count = p_count
	if is_inside_tree():
		_update_stars_mesh()

func get_stars_count() -> int:
	return stars_count

func _update_stars_mesh() -> void:
	while stars_mesh.get_surface_count():
		stars_mesh.surface_remove(0)
	_generate_stars_surface()

func _generate_stars_surface() -> void:
	var meshdata = Array()
	meshdata.resize(Mesh.ARRAY_MAX)
	meshdata[Mesh.ARRAY_VERTEX] = _generate_stars_points()
	stars_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_POINTS, meshdata)

func _generate_stars_points() -> PoolVector2Array:
	var points = PoolVector2Array()
	points.resize(stars_count)
	
	for i in range(stars_count):
		var rnd = Vector2(randf(), randf())
		var pos = Vector2(320, 240) * rnd
		points[i] = pos
	
	return points
