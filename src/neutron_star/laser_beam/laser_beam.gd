extends Node2D
tool

const BeamBegin = preload("./beam_begin.png")
const BeamEnd = preload("./beam_end.png")

export(float) var duration: float = 0.3
export(Vector2) var target: Vector2 = Vector2() \
	setget set_target, get_target

var time_left: float = 0.0

func _ready() -> void:
	time_left = duration

func _process(p_delta: float) -> void:
	if Engine.is_editor_hint():
		return
	if time_left < 0.0:
		queue_free()
	time_left -= p_delta
	update()

func _draw() -> void:
	var width = sin(time_left / duration) * 4.0
	draw_line(Vector2(), target, Color(1.0, 1.0, 1.0), 6 + width)
	draw_texture(BeamBegin, BeamBegin.get_size() * -0.5)
	draw_texture(BeamEnd, target - BeamEnd.get_size() * 0.5)

func set_target(p_target: Vector2) -> void:
	target = p_target
	update()

func get_target() -> Vector2:
	return target
