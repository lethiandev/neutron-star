extends Area2D

const LasterBeam = preload("res://neutron_star/laser_beam/laser_beam.gd")

signal unit_hitted(unit)

func _ready() -> void:
	connect("area_entered", self, "_on_area_entered")

func _on_area_entered(p_area: Area2D) -> void:
	if p_area is UnitBase:
		_handle_unit_collision(p_area)

func _handle_unit_collision(p_unit: UnitBase) -> void:
	emit_signal("unit_hitted", p_unit)
	p_unit.destroy(true)

func shoot(p_target: Vector2) -> void:
	var laser_beam = LasterBeam.new()
	var target = p_target - global_position
	var offset = target.normalized() * 18.0
	laser_beam.position = offset
	laser_beam.target = target - offset
	get_parent().add_child(laser_beam)
