extends Node

func _process(p_delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		_play_game()

func _play_game() -> void:
	$Courtain/AnimationPlayer.play("fade_out")
	$CenterContainer/AnimationPlayer.stop()
	yield($Courtain/AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://stages/gameplay/gameplay.tscn")
