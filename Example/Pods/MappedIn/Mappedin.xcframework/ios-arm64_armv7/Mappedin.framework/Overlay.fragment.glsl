precision mediump float;

uniform sampler2D u_Texture;

varying vec2 v_TexCoord;

void main() {
    gl_FragColor = texture2D(u_Texture, v_TexCoord * vec2(1, -1) + vec2(0.5, 0.5));
}
