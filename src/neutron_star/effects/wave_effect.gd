extends Node

export(float) var wave_height: float = 15.0
export(Color) var color_low: Color = Color(1.0, 1.0, 1.0)
export(Color) var color_high: Color = Color(0.0, 1.0, 0.0)

var vertex_stride = (4 * 2) + 4 # Vector2 + Color
var buffer = StreamPeerBuffer.new()

func _ready():
	var segments = get_parent().segments
	buffer.resize((segments + 2) * vertex_stride)

func _process(p_delta: float) -> void:
	var segments = get_parent().segments
	var base_height = get_parent().height
	
	buffer.seek(0)
	buffer.put_float(0.0)
	buffer.put_float(0.0)
	buffer.put_32(color_low.to_abgr32())
	
	for i in range(segments + 1):
		var angle = (TAU / segments) * i
		var normal = Vector2.RIGHT.rotated(angle)
		var level = _get_point_spectrum_at(i)
		var extrude = normal * level * wave_height
		var height = normal * base_height + extrude
		var color = color_low.linear_interpolate(color_high, level)
		
		buffer.put_float(height.x)
		buffer.put_float(height.y)
		buffer.put_32(color.to_abgr32())
	
	var mesh = get_parent().planet_mesh
	mesh.surface_update_region(0, 0, buffer.data_array)

func _get_point_spectrum_at(p_index: int) -> float:
	var ioffset = get_parent().get_index() * 10
	return _get_spectrum_at(p_index + ioffset)

func _get_spectrum_at(p_index: int) -> float:
	var limit = Spectrogram.definition
	return Spectrogram.histogram[p_index % limit]
