extends Node2D

var diagram_width = 20 * 2
var diagram_height = 40

func _process(p_delta: float) -> void:
	update()

func _draw() -> void:
	var histogram = Spectrogram.histogram
	var limit = histogram.size()
	
	var from = Vector2(0.0, diagram_height)
	var interval = diagram_width / limit
	
	draw_line(from, from + Vector2(diagram_width, 0.0), Color.whitesmoke)
	from.x += interval * 0.5
	
	for value in histogram:
		var offset = Vector2(0.0, value) * diagram_height
		draw_line(from, from - offset, Color.white, interval)
		from.x += interval
