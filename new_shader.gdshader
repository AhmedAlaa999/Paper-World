shader_type canvas_item;

uniform float corner_radius : hint_range(0.0, 0.5) = 0.12;

void fragment() {
    vec2 uv = UV;
    vec2 size = 1.0 / TEXTURE_PIXEL_SIZE;

    vec2 pos = (uv - 0.5) * size;
    vec2 half_size = size * 0.5;
    float radius = min(corner_radius * min(size.x, size.y),
                       min(half_size.x, half_size.y));

    vec2 q = abs(pos) - half_size + radius;
    float distance = length(max(q, vec2(0.0)))
                   + min(max(q.x, q.y), 0.0) - radius;

    COLOR.a *= 1.0 - smoothstep(-1.0, 1.0, distance);
}