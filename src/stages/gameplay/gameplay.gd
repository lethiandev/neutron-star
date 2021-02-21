extends Node

var action_group_map = {
	"action_a": UnitBase.UNIT_GROUP_A,
	"action_b": UnitBase.UNIT_GROUP_B,
	"action_x": UnitBase.UNIT_GROUP_X,
	"action_p": UnitBase.UNIT_GROUP_P,
}

var cooldown: float = 0.0
var health: float = 1.0

func _init() -> void:
	randomize()

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
	
	cooldown = max(0.0, cooldown - p_delta)
	health = min(1.0, health + p_delta * 0.25)

func _populate_interface_state() -> void:
	$Interface/CenterContainer/CooldownBar.progress = cooldown
	$Interface/CenterContainer/HealthBar.progress = health

func _process_unit_group(p_group: String) -> void:
	var nodes = get_tree().get_nodes_in_group(p_group)
	if not nodes.empty():
		var front_node = nodes.front()
		_handle_unit_hit(front_node)
	else:
		_handle_unit_miss()

func _handle_unit_hit(p_unit: Node) -> void:
	if p_unit is UnitBase:
		p_unit.hit()
		$Camera2D.shake_low()

func _handle_unit_miss() -> void:
	cooldown = 1.0
	$MissEffectPlayer.play()

func _on_neutron_star_unit_hitted(p_unit: UnitBase) -> void:
	_handle_star_hit(p_unit)

func _handle_star_hit(p_unit: UnitBase) -> void:
	health -= 0.35;
	$Camera2D.shake_high()
