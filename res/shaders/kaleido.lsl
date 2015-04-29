extern number time;
extern number distort;
extern number chroma;
extern Image buffer;

vec4 effect(vec4 color, Image tex, vec2 tc, vec2 pc)
{
    tc = vec2(1.0,1.0) - abs(2.0 * tc - vec2(1.0,1.0));
    number dist = dot(tc,tc);
    tc.x += sin(tc.y * 100 + time * 10.0) * .03 * distort;
    vec2 rb = vec2(1.0,1.0) * .002 * chroma;
    color = vec4(Texel(tex, tc+rb).r, Texel(tex, tc).g, Texel(tex, tc-rb).b, 1.0) * color * pow(dist, 0);
    return color + Texel(buffer, tc * .9) * .2;
}
