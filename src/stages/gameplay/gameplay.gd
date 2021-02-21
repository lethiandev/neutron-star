extends Node

var action_group_map = {
	"action_a": UnitBase.UNIT_GROUP_A,
	"action_b": UnitBase.UNIT_GROUP_B,
	"action_x": UnitBase.UNIT_GROUP_X,
	"action_p": UnitBase.UNIT_GROUP_P,
}

var cooldown: float = 0.0
var health: float = 1.0

var last_group: String = ""
var hitted: float = 0.0

func _init() -> void:
	randomize()

func _ready() -> void:
	_populate_interface_state()

func _process(p_delta: float) -> void:
	if cooldown < 0.1:
		_process_game_input()
	_process_game_state(p_delta)

func _process_game_input() -> void:
	for action in action_group_map:
		if Input.is_action_just_pressed(action):
			_process_unit_group(action_group_map[action])

func _process_game_state(p_delta: float) -> void:
	_populate_interface_state()
	
	cooldown = max(0.0, cooldown - p_delta * 2.0)
	health = min(1.0, health + p_delta * 0.05)
	hitted = max(0.0, hitted - p_delta)

func _populate_interface_state() -> void:
	$Interface/CenterContainer/CooldownBar.progress = cooldown
	$Interface/CenterContainer/HealthBar.progress = health

func _process_unit_group(p_group: String) -> void:
	var nodes = get_tree().get_nodes_in_group(p_group)
	if not nodes.empty():
		var front_node = nodes.front()
		_handle_unit_hit(front_node)
	elif hitted > 0.0 and last_group == p_group:
		# Forgive "missing" for short time
		pass
	else:
		_handle_unit_miss()

func _handle_unit_hit(p_unit: Node) -> void:
	if p_unit is UnitBase:
		var pos = p_unit.global_position
		$World/NeutronStar.shoot(pos)
		$Camera2D.shake_low()
		p_unit.hit()

func _handle_unit_miss() -> void:
	cooldown = 1.0
	$MissEffectPlayer.play()

func _on_neutron_star_unit_hitted(p_unit: UnitBase) -> void:
	_handle_star_hit(p_unit)

func _handle_star_hit(p_unit: UnitBase) -> void:
	_set_damage_cooldown(p_unit, 0.2)
	_take_damage(p_unit)
	$HitEffectPlayer.play()
	$Camera2D.shake_high()

func _take_damage(p_from: UnitBase) -> void:
	health -= 0.30
	if health < -0.1:
		_game_failure()

func _set_damage_cooldown(p_from: UnitBase, p_time: float) -> void:
	last_group = p_from.unit_group
	hitted = p_time

func _game_failure() -> void:
	get_tree().set_pause(true)
	$Interface/Courtain/AnimationPlayer.play("fade_out")
	yield($Interface/Courtain/AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://stages/game_over/game_over.tscn")
