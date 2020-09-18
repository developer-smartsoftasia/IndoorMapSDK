
uniform vec2 u_textureVector;
uniform int u_skipRotation;
varying float v_isRotated;

#pragma body
vec4 worldSpaceTextureVector = u_modelViewProjectionTransform * vec4(u_textureVector, 0, 0);
// check if the polygons's texture is upside down based on the direction
// of the texture coordinates, flip the texture if it is upside down
v_isRotated = ((worldSpaceTextureVector.y > 0.0) &&
               u_skipRotation == 0
               ) ? 1.0 : -1.0;
