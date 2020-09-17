varying float v_isRotated;
uniform vec4 u_innerBounds;
uniform vec4 u_outerBounds;

#pragma body
vec2 scale = 1. / (u_innerBounds.zw - u_innerBounds.xy);
_surface.diffuseTexcoord = (_surface.diffuseTexcoord - u_innerBounds.xy) * scale;

// if the texture is out of bounds, discard it
if (_surface.diffuseTexcoord.x < 0. || _surface.diffuseTexcoord.x > 1. ||
    _surface.diffuseTexcoord.y < 0. || _surface.diffuseTexcoord.y > 1.) {
    discard;
}

if (v_isRotated > 0.0) {
    _surface.diffuseTexcoord = u_outerBounds.zw - _surface.diffuseTexcoord;
}
_surface.diffuse = texture2D(u_diffuseTexture, _surface.diffuseTexcoord);
