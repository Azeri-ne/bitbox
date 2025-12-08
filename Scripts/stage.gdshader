shader_type canvas_item;

uniform float vertical_stretch : hint_range(0.1, 5.0) = 2.0;

void fragment() {
    // Scale UV vertically
    vec2 uv = UV;
    uv.y = (uv.y - 0.5) / vertical_stretch + 0.5;

    COLOR = texture(TEXTURE, uv) * COLOR;
}

