shader_type canvas_item;

uniform float progress : hint_range(0.0, 1.0) = 1.0;

const float PI = 3.14159265358979323846;
const float TAU = PI * 2.0;

void fragment() {
	vec2 center = (UV - vec2(0.5, 0.5)) * 2.0;
	float angle = atan(center.x, center.y) + PI;
	float value = 1.0 - angle / TAU;
	
	COLOR = texture(TEXTURE, UV);
	COLOR *= step(value, progress);
}
