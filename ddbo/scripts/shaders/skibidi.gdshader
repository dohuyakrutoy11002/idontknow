shader_type canvas_item;

uniform vec3 dispersion_rgb = vec3(0.0, 0.8, 0.4); // Color dispersion params
uniform float random_dispersion_enable = 1.0;
uniform float dispersion_intensity = 0.025;
uniform float dispersion_interval = 10.0;
uniform float dispersion_freq = 2.5;
uniform float rand_distort_intensity = 0.5;
uniform float rand_distort_interval = 5.0;
uniform float rand_distort_freq = 0.25;
uniform float intensity = 0.0;
uniform float line_resolution = 5.0;
uniform float line_speed = 5.0;
uniform float line_shift = 0.01;
uniform float active_scan_intensity = 0.03;
uniform float active_scan_interval = 7.0;
uniform float active_scan_freq = 0.25;
uniform float passive_scan_intensity = 0.02;
uniform float noise_intensity = 0.1;
uniform sampler2D source_texture : hint_albedo;

#define PI 3.14159265359
#define TWO_PI 6.28318530718

// Simple random function replacement
float rand(vec2 co) {
	return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

// Noise function remains the same
float noise(in vec2 st) {
	vec2 i = floor(st);
	vec2 f = fract(st);

	float a = rand(i);
	float b = rand(i + vec2(1.0, 0.0));
	float c = rand(i + vec2(0.0, 1.0));
	float d = rand(i + vec2(1.0, 1.0));

	vec2 u = f * f * (3.0 - 2.0 * f);
	return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

// Function for interval calculation
float interval(float time_in_interval, float percent_of_interval) {
	float n = (percent_of_interval - 0.45) / 0.05;
	return ((sign(sin(TWO_PI * TIME / time_in_interval) + percent_of_interval * (2.0 * (n - 1.0) / (n + 9.0))) + 1.0) / 2.0);
}

void fragment() {
	vec2 uv = FRAG_COORD.xy / SCREEN_PIXEL_SIZE.xy;
	
	// Downsample (adapted to work similarly to GLSL)
	float y_mod = floor(uv.y * 50.0 * line_resolution) / (50.0 * line_resolution);
	float x_mod = floor(uv.x * 50.0 * line_resolution) / (50.0 * line_resolution);

	float intensity_modifier = rand_distort_intensity * interval(rand_distort_interval, rand_distort_freq / rand_distort_interval);

	// Apply random scan jitter
	uv.x += sin(uv.y * 6000.0 * rand(uv)) * passive_scan_intensity;

	vec4 render_color = texture(source_texture, uv);

	// RGB dispersion effect
	vec4 red = texture(source_texture, vec2(uv.x + rand(uv) * dispersion_rgb.x * dispersion_intensity, uv.y)) * vec4(1.0, 0.0, 0.0, 1.0);
	vec4 green = texture(source_texture, vec2(uv.x + rand(uv) * dispersion_rgb.y * dispersion_intensity, uv.y)) * vec4(0.0, 1.0, 0.0, 1.0);
	vec4 blue = texture(source_texture, vec2(uv.x + rand(uv) * dispersion_rgb.z * dispersion_intensity, uv.y)) * vec4(0.0, 0.0, 1.0, 1.0);

	// Noise
	float noise_mod = (0.5 + 0.5 * noise(uv)) * noise_intensity;

	// Final output color
	COLOR = ((render_color + red + green + blue) / 2.0) - vec4(noise_mod);
}
