extends Node

const SpaceshipScene = preload("res://units/spaceship/spaceship.tscn")
const MothershipBossScene = preload("res://units/mothership_boss/mothership_boss.tscn")

func _ready() -> void:
	yield(_delay(2.0), "completed")
	yield(_spawn_wave_1(), "completed")
	yield(_spawn_wave_2(), "completed")
	yield(_spawn_wave_3(), "completed")
	yield(_spawn_wave_4(), "completed")
	yield(_spawn_mothership_boss(), "completed")

func _spawn_wave_1() -> void:
	var side = 1.0 if randf() > 0.5 else -1.0
	yield(_spawn_spaceship(2.0, 3.0, Vector2(200.0 * side, 80.0)), "completed")
	yield(_spawn_spaceship(2.0, 3.0, Vector2(200.0 * -side, 80.0)), "completed")
	yield(_spawn_spaceship(2.0, 2.5, Vector2(220.0 * side, -20.0)), "completed")
	yield(_spawn_spaceship(2.0, 2.5, Vector2(220.0 * -side, -20.0)), "completed")
	yield(_delay(2.0), "completed")

func _spawn_wave_2() -> void:
	var side = 1.0 if randf() > 0.5 else -1.0
	yield(_spawn_spaceship(1.5, 2.0, Vector2(200.0 * side, 40.0)), "completed")
	yield(_spawn_spaceship(1.5, 2.0, Vector2(200.0 * -side, 40.0)), "completed")
	yield(_spawn_spaceship(1.5, 2.0, Vector2(220.0 * side, -40.0)), "completed")
	yield(_spawn_spaceship(1.5, 2.0, Vector2(220.0 * -side, -40.0)), "completed")
	yield(_spawn_spaceship(2.0, 2.0, Vector2(200.0 * side, 60.0)), "completed")
	yield(_spawn_spaceship(1.5, 2.0, Vector2(200.0 * -side, -60.0)), "completed")
	yield(_spawn_spaceship(2.0, 2.0, Vector2(200.0 * side, 80.0)), "completed")
	yield(_spawn_spaceship(1.5, 2.0, Vector2(200.0 * -side, 80.0)), "completed")
	yield(_delay(2.0), "completed")

func _spawn_wave_3() -> void:
	var side = 1.0 if randf() > 0.5 else -1.0
	yield(_spawn_spaceship(1.0, 2.0, Vector2(180.0 * side, -80.0)), "completed")
	yield(_spawn_spaceship(0.5, 2.0, Vector2(180.0 * -side, -80.0)), "completed")
	yield(_spawn_spaceship(1.0, 2.0, Vector2(180.0 * side, 80.0)), "completed")
	yield(_spawn_spaceship(0.5, 2.0, Vector2(180.0 * -side, -80.0)), "completed")
	yield(_spawn_spaceship(0.5, 2.0, Vector2(180.0 * side, -60.0)), "completed")
	yield(_spawn_spaceship(0.2, 2.0, Vector2(180.0 * -side, -60.0)), "completed")
	yield(_spawn_spaceship(0.5, 2.0, Vector2(180.0 * side, 60.0)), "completed")
	yield(_spawn_spaceship(0.2, 2.0, Vector2(180.0 * -side, 60.0)), "completed")
	yield(_spawn_spaceship(0.5, 2.0, Vector2(200.0 * side, -40.0)), "completed")
	yield(_spawn_spaceship(0.2, 2.0, Vector2(200.0 * -side, -40.0)), "completed")
	yield(_spawn_spaceship(0.5, 2.0, Vector2(220.0 * side, 40.0)), "completed")
	yield(_spawn_spaceship(0.2, 2.0, Vector2(220.0 * -side, 40.0)), "completed")
	yield(_delay(2.0), "completed")

func _spawn_wave_4() -> void: 
	var side = 1.0 if randf() > 0.5 else -1.0
	yield(_spawn_spaceship(0.0, 1.8, Vector2(180.0 * side, -80.0)), "completed")
	yield(_spawn_spaceship(1.0, 1.8, Vector2(180.0 * -side, -80.0)), "completed")
	yield(_spawn_spaceship(0.0, 1.8, Vector2(180.0 * side, 20.0)), "completed")
	yield(_spawn_spaceship(1.0, 1.8, Vector2(180.0 * -side, 20.0)), "completed")
	yield(_spawn_spaceship(0.0, 1.6, Vector2(180.0 * side, 60.0)), "completed")
	yield(_spawn_spaceship(0.8, 1.6, Vector2(180.0 * -side, 60.0)), "completed")
	yield(_spawn_spaceship(0.0, 1.6, Vector2(180.0 * side, -60.0)), "completed")
	yield(_spawn_spaceship(0.8, 1.6, Vector2(180.0 * -side, -60.0)), "completed")
	yield(_delay(2.0), "completed")

func _spawn_mothership_boss() -> void:
	var boss_node = MothershipBossScene.instance()
	boss_node.position = Vector2(0.0, -86.0)
	get_parent().add_child(boss_node)
	yield(boss_node, "completed")

func _spawn_spaceship(p_delay: float, p_duration: float, p_from: Vector2) -> void:
	var spaceship_node = _spawn_unit(SpaceshipScene, p_from)
	spaceship_node.get_node("RouteFollower").duration = p_duration
	yield(_delay(p_delay), "completed")

func _delay(p_delay: float) -> void:
	yield(get_tree().create_timer(p_delay), "timeout")

func _spawn_unit(p_type: PackedScene, p_from: Vector2) -> Node:
	var unit_node = p_type.instance()
	unit_node.position = p_from
	get_parent().add_child(unit_node)
	return unit_node
