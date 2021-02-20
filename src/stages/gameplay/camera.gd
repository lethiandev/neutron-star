extends Camera2D

func shake_low() -> void:
	$ShakeEffect.amplitude = 6.0
	$ShakeEffect.shake(0.4, 32.0)

func shake_high() -> void:
	$ShakeEffect.amplitude = 12.0
	$ShakeEffect.shake(1.5, 60.0)

func shake_boss() -> void:
	$ShakeEffect.amplitude = 12.0
	$ShakeEffect.shake(4.5, 60.0)
