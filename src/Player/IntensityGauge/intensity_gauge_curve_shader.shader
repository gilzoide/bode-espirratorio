shader_type canvas_item;

const float PI = 3.1415926535897932384626433832795;
const float initial_angle = -PI / 2.0;
const float end_angle = PI / 2.0;

uniform float inner_radius : hint_range(0, 1) = 0.5;
uniform float outer_radius : hint_range(0, 1) = 1.0;
uniform float textured_angle : hint_range(0, 1) = 1.0;

void fragment() {
	// Transform UV from [0, 0]~[1, 1] to [-1, -1]~[1, 1], so sprite center is [0, 0]
	vec2 normalizedUV = UV * 2.0 - 1.0;
	
	// Transform cartesian [X, Y] to polar coordinates [Angle, Radius]
	float angle = atan(normalizedUV.y, normalizedUV.x);
	float radius = length(normalizedUV);
	
	// Remap angle from initial_angle~end_angle to 0~1
	float angle01 = (angle - initial_angle) / (end_angle - initial_angle);

	float angle_inner_radius = mix(outer_radius, inner_radius, angle01);
	float radius_delta = outer_radius - angle_inner_radius;
	float radius01 = (radius - angle_inner_radius) / radius_delta;
	
	float abs_textured_angle = mix(initial_angle, end_angle, textured_angle);
	float textured_radius = outer_radius - (radius_delta * 0.5);
	float dist_squared = pow(textured_radius, 2) + pow(radius, 2) - 2.0 * textured_radius * radius * cos(angle - abs_textured_angle);
	bool isInside = ((radius01 >= 0.0 && radius01 <= 1.0) && (angle01 >= 0.0 && angle01 <= textured_angle)) ||
		dist_squared <= pow(radius_delta * TEXTURE_PIXEL_SIZE.x, 2);
	
	// Texel color fetching from texture sampler
	vec4 texelColor = texture(TEXTURE, vec2(angle01, radius01));
	texelColor.a *= float(isInside);

	COLOR *= texelColor;
}
