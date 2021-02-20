extends Node

var action_group_map = {
	"action_a": UnitBase.UNIT_GROUP_A,
	"action_b": UnitBase.UNIT_GROUP_B,
	"action_x": UnitBase.UNIT_GROUP_X,
	"action_p": UnitBase.UNIT_GROUP_P,
}

func _init() -> void:
	randomize()

func _process(p_delta: float) -> void:
	for action in action_group_map:
		if Input.is_action_just_pressed(action):
			_process_unit_group(action_group_map[action])

func _process_unit_group(p_group: String) -> void:
	var nodes = get_tree().get_nodes_in_group(p_group)
	if not nodes.empty():
		var front_node = nodes.front()
		_process_unit_hit(front_node)
	else:
		_process_miss()

func _process_unit_hit(p_unit: Node) -> void:
	if p_unit is UnitBase:
		p_unit.hit()
		$Camera2D.shake_low()

func _process_miss() -> void:
	pass
