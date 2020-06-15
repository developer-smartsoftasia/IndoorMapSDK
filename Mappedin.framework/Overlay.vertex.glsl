precision mediump float;

attribute vec2 a_TexCoord;
varying vec2 v_TexCoord;

uniform vec2 u_Offset;
uniform vec2 u_Size;

void main() {
	v_TexCoord = a_TexCoord;
    gl_Position.xy = u_Offset + u_Size * (a_TexCoord + vec2(0.5, 0.5));
    gl_Position.zw = vec2(0.001, 1);
}
