shader_type canvas_item;

uniform float flash_strength: hint_range(0.0,0.9) = 0.9;

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 color = texture(TEXTURE, UV);
	color.rgb = mix(color.rgb, vec3(1,1,1), flash_strength);
	
	COLOR = color;
}
