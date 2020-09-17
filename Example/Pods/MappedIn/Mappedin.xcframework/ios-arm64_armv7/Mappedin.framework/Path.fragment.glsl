uniform vec4 u_pulseColor;
uniform vec4 u_baseColor;

uniform float u_position;
uniform float u_length;

#pragma body
float width = 5.0;
float x = u_position / u_length;
float position = (-2.0 * x * x * x  + 3.0 * x * x) * u_length;
float segment = _surface.diffuseTexcoord.x;
float scale = (segment - position) / width;
if (scale < -1.0 || scale > 1.0) {
    scale = 0.0;
} else {
    scale = cos(scale * 1.57079632679489661923 /* PI/2 */);
}

_surface.diffuse = max(min(mix(u_baseColor, u_pulseColor, scale), 1.0), 0.0);

