extends Node

export(Curve) var route_curve: Curve
export(float) var duration: float = 2.0

var start: Vector2 = Vector2()
var ticks: float = 0.0

func _ready() -> void:
	start = get_parent().transform.origin
	ticks = 0.0
	print("start: ", start)

func _process(p_delta: float) -> void:
	var y = route_curve.interpolate_baked(ticks)
	var p = start.linear_interpolate(Vector2(), y)
	get_parent().transform.origin = p
	ticks += p_delta / duration
