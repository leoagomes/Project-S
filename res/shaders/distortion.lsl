extern number time;
extern number size;
vec4 effect(vec4 color, Image tex, vec2 tc, vec2 pc)
{
    vec2 p = tc;
    p.x = p.x + sin(p.y * size + time) * 0.03;
    return Texel(tex, p);
}
