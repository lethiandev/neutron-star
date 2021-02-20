# Shamelessly ripped off from Gonkee's repository:
# https://github.com/Gonkee/Gonkees-Shaders/blob/master/non-shaders/audio_visualiser.gd
extends Node

var spectrum: AudioEffectSpectrumAnalyzerInstance

var definition: int = 20

var min_freq: float = 40.0
var max_freq: float = 20000.0

var min_db: float = -62.0
var max_db: float = -10.0

var acceleration: float = 15.0
var histogram: PoolRealArray = PoolRealArray()

func _ready() -> void:
	var bus_index = AudioServer.get_bus_index("Midbus")
	spectrum = AudioServer.get_bus_effect_instance(bus_index, 0)
	
	histogram.resize(definition)
	for i in range(definition):
		histogram[i] = 0.0

func _process(p_delta: float) -> void:
	var freq: float = min_freq
	var interval: float = (max_freq - min_freq) / definition
	
	for i in range(definition):
		var power = max(1.0, 1.5 * int(i / 10))
		
		var hzrange_low = (freq - min_freq) / (max_freq - min_freq)
		hzrange_low = hzrange_low * hzrange_low * hzrange_low * hzrange_low / power
		hzrange_low = lerp(min_freq, max_freq, hzrange_low)
		
		var hzrange_high = (freq - min_freq) / (max_freq - min_freq)
		hzrange_high = hzrange_high * hzrange_high * hzrange_high * hzrange_high / power
		hzrange_high = lerp(min_freq, max_freq, hzrange_high)
		
		freq += interval
		
		var magv = spectrum.get_magnitude_for_frequency_range(hzrange_low, hzrange_high)
		var magl = linear2db(magv.length())
		magl = (magl - min_db) / (max_db - min_db)
		
		magl += 0.3 * (freq - min_freq) / (max_freq - min_freq)
		magl = clamp(magl, 0.0, 1.0)
		
		var weight = acceleration * p_delta
		histogram[i] = lerp(histogram[i], magl, weight)
		histogram[i] = clamp(histogram[i], 0.0, 1.0)
