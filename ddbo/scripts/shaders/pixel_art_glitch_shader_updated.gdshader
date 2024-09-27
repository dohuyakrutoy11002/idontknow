
shader_type canvas_item;

uniform float glitch_intensity : hint_range(0.0, 1.0) = 0.7; // Overall glitch strength
uniform float chromatic_aberration_intensity : hint_range(0.0, 1.0) = 0.5; // Chromatic shift
uniform float pixelation_factor : hint_range(1.0, 8.0) = 5.0; // Pixelation effect
uniform float tear_intensity : hint_range(0.0, 1.0) = 0.4; // Intensity of screen tearing
uniform float noise_intensity : hint_range(0.0, 1.0) = 0.2; // Adds subtle noise
uniform float scramble_intensity : hint_range(0.0, 1.0) = 0.5; // Pixel scrambling factor

void fragment() {
    // Pixel-perfect UVs based on screen size for a chunky look
    vec2 pixelated_uv = floor(FRAGCOORD.xy / pixelation_factor) * pixelation_factor / SCREEN_PIXEL_SIZE.xy;

    // Randomized time-based seed for noise and scrambling
    float random_seed = sin(TIME * 10.0) * 0.5 + 0.5;
    
    // Chromatic Aberration Effect (RGB offset)
    vec2 r_shift = vec2(sin(TIME * 5.0 + pixelated_uv.y * 10.0) * chromatic_aberration_intensity, 0.0);
    vec2 g_shift = vec2(0.0, cos(TIME * 6.0 + pixelated_uv.x * 10.0) * chromatic_aberration_intensity);
    vec2 b_shift = vec2(cos(TIME * 7.0 + pixelated_uv.y * 8.0) * chromatic_aberration_intensity, 0.0);
    
    // Glitch scrambling effect: Scrambles pixels based on noise and scramble_intensity
    vec2 scrambled_uv = pixelated_uv + vec2(
        sin(pixelated_uv.y * 50.0 + TIME * 20.0) * scramble_intensity * random_seed,
        cos(pixelated_uv.x * 40.0 + TIME * 30.0) * scramble_intensity * random_seed
    );
    
    // Base pixel color
    vec4 base_color = texture(SCREEN_TEXTURE, pixelated_uv);

    // Apply RGB shift based on chromatic aberration
    vec4 glitch_color;
    glitch_color.r = texture(SCREEN_TEXTURE, scrambled_uv + r_shift).r;
    glitch_color.g = texture(SCREEN_TEXTURE, scrambled_uv + g_shift).g;
    glitch_color.b = texture(SCREEN_TEXTURE, scrambled_uv + b_shift).b;
    
    // Screen tearing effect: Janky horizontal offset that randomly affects parts of the screen
    float tear_offset = tear_intensity * sin(TIME * 30.0 + pixelated_uv.y * 50.0) * glitch_intensity;
    pixelated_uv.x += tear_offset;
    
    // Add slight noise overlay to simulate old screens
    float noise = noise_intensity * rand(vec2(pixelated_uv.y * 100.0, pixelated_uv.x * 100.0));
    base_color.rgb += noise;
    
    // Blend the base color with the glitch effect
    vec4 final_color = mix(base_color, glitch_color, glitch_intensity);

    // Output the final color
    COLOR = final_color;
}

// Random function for pixel noise
float rand(vec2 co) {
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}
