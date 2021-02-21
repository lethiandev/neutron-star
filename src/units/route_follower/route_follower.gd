extends Node

const RouteCurves = preload("./route_curves.gd")

export(Resource) var route_curves: Resource
export(float) var duration: float = 2.0

var from: Vector2 = Vector2()
var ticks: float = 0.0

func _ready() -> void:
	from = get_parent().transform.origin

func _process(p_delta: float) -> void:
	if route_curves is RouteCurves:
		_update_position(route_curves)
	ticks += p_delta / duration

func _update_position(p_curves: RouteCurves) -> void:
	var y0 = p_curves.x_curve.interpolate_baked(ticks)
	var y1 = p_curves.y_curve.interpolate_baked(ticks)
	var pos = from.linear_interpolate(Vector2(), y0)
	var off = Vector2(0.0, y1)
	
	var target = get_parent() as Node2D
	target.transform.origin = pos + off
