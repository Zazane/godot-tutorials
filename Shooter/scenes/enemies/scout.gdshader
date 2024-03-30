shader_type canvas_item;

// uniform exposes it to access by gdscript
uniform vec3 color: source_color = vec3(1);
uniform float progress: hint_range(0.0, 1.0, 0.1) = 0;

void fragment() {
	float current_a = texture(TEXTURE, UV).a; // alpha value
	// with shading languages try to not use "if"
	// mix mixes two vec4 - original and all of second vector
	// creating vec3 - using only (1) is the same as (1,1,1)
	vec4 target_color = mix(texture(TEXTURE, UV), vec4(color, current_a), progress);
	COLOR = target_color;
	// COLOR = texture(TEXTURE, UV); // default value
}
