extends Node2D

const SpaceshipUnitScene = preload("res://units/spaceship/spaceship.tscn")
const MissileUnitScene = preload("res://units/missile/missile.tscn")

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

func _on_mothership_hitted():
	health -= 1.0

func _boss_cycle() -> void:
	if not completed:
		yield(_boss_cycle_spaceships(), "completed")
	if not completed:
		_boss_cycle_missiles()

func _boss_cycle_spaceships():# -> GDScriptFunctionState:
	yield(get_tree().create_timer(2.0), "timeout")
	yield(_spawn_spaceship_units(), "completed")

func _spawn_spaceship_units():# -> GDScriptFunctionState:
	for i in range(6):
		var side = 1.0 if randf() > 0.5 else -1.0
		var delay = 1.5 + randf() * 0.5
		if not completed:
			_spawn_spaceship_unit(side)
		yield(get_tree().create_timer(delay), "timeout")

func _spawn_spaceship_unit(p_side: float) -> void:
	var spaceship_node = SpaceshipUnitScene.instance()
	spaceship_node.position = Vector2(200 * p_side, 140 - randf() * 160)
	get_parent().add_child(spaceship_node)
	# Ensure unit's group diverse from the boss's group 
	while spaceship_node.unit_group == $Mothership.unit_group:
		spaceship_node.randomize_group()

func _boss_cycle_missiles() -> void:
	$Mothership.set_unit_group("")
	$AnimationPlayer.stop(false)
	for i in range(6):
		$Mothership/Cannons.shoot()
		yield(get_tree().create_timer(0.4), "timeout")
	$AnimationPlayer.play("ascend")
	yield(_spawn_missile_units(), "completed")
	yield(get_tree().create_timer(2.0), "timeout")
	$AnimationPlayer.play("descend")

func _spawn_missile_units():# -> GDScriptFunctionState:
	for i in range(6):
		_spaw_missile_unit(1.0, (i * 2) * 20.0)
		yield(get_tree().create_timer(0.5), "timeout")
		_spaw_missile_unit(-1.0, (i * 2 + 1) * 20.0)
		yield(get_tree().create_timer(0.5), "timeout")

func _spaw_missile_unit(p_side: float, p_offset: float) -> void:
	var missile_node = MissileUnitScene.instance()
	missile_node.position = Vector2(180 * p_side, 140 - p_offset)
	get_parent().add_child(missile_node)
