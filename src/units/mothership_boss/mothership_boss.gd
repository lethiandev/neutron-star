extends Node2D

signal completed()

var health: float = 500.0
var visual_health: float = 0.0

var completed: bool = false

func _process(p_delta: float) -> void:
	_process_interface_state(p_delta)
	_process_boss_state()

func _process_interface_state(p_delta: float) -> void:
	var new_size = max(0.0, (visual_health / 500.0) * 280.0)
	$Interface/BottomAnchor/HealthBar.rect_size.x = new_size
	visual_health = min(health, visual_health + p_delta * 200.0)

func _process_boss_state() -> void:
	if health < 1.0 and not completed:
		$Mothership.destroy()
		$AnimationPlayer.play("destroy")
		emit_signal("completed")
		completed = true

func _boss_cycle() -> void:
	yield(get_tree().create_timer(10.0), "timeout")
	if not completed:
		_boss_cycle_missiles()

func _boss_cycle_missiles() -> void:
	$Mothership.set_unit_group("")
	$AnimationPlayer.stop(false)
	for i in range(12):
		$Mothership/Cannons.shoot()
		yield(get_tree().create_timer(0.2), "timeout")
	$AnimationPlayer.play("ascend")
	yield(get_tree().create_timer(5.0), "timeout")
	$AnimationPlayer.play("descend")

func _on_mothership_hitted():
	health -= 1.0
