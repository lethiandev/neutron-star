extends Area2D

signal unit_hitted(unit)

func _ready() -> void:
	connect("area_entered", self, "_on_area_entered")

func _on_area_entered(p_area: Area2D) -> void:
	if p_area is UnitBase:
		_handle_unit_collision(p_area)

func _handle_unit_collision(p_unit: UnitBase) -> void:
	emit_signal("unit_hitted", p_unit)
	p_unit.destroy()
