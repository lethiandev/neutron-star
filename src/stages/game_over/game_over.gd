extends Node

func _ready() -> void:
	get_tree().set_pause(false)
	_populate_score()

func _process(p_delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		get_tree().change_scene("res://stages/gameplay/gameplay.tscn")

func _populate_score() -> void:
	if get_tree().has_meta("final_score"):
		var final_score = get_tree().get_meta("final_score")
		$FinalScore.text = "%d" % final_score
