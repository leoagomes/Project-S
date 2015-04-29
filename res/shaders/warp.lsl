extern number time = 0.0;
extern number size = 70.0;
extern number strength = 2.0;
extern vec2 res = vec2(512.0, 512.0);
uniform sampler2D tex0;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
{
    float tmp = sin(sqrt(pow(texture_coords.x * size - size / 2.0, 2.0) + pow(texture_coords.y * size - size / 2.0, 2.0)) - time * 16.0);
    vec2 uv         = vec2(
        texture_coords.x - tmp * strength / 1024.0,
        texture_coords.y - tmp * strength / 1024.0
    );
    vec3 col        = vec3(
        texture2D(tex0,uv).x,
        texture2D(tex0,uv).y,
        texture2D(tex0,uv).z
    );
 return vec4(col, 1.0);
}
