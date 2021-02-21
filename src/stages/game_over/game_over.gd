extends Node

func _ready() -> void:
	get_tree().set_pause(false)

func _process(p_delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		get_tree().change_scene("res://stages/gameplay/gameplay.tscn")
