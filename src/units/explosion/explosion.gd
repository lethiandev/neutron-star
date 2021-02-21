extends Node2D

func _ready() -> void:
	$CPUParticles2D.emitting = true
	$CPUParticles2D2.emitting = true
	$CPUParticles2D3.emitting = true
	_delay_destroy()

func _delay_destroy() -> void:
	yield(get_tree().create_timer(0.4), "timeout")
	self_modulate = Color.transparent
	yield(get_tree().create_timer(0.6), "timeout")
	queue_free()
