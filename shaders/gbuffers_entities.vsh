#version 150

// #define STATIC_WAVES

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform float frameTimeCounter;
uniform vec3 cameraPosition;

out vec2 texcoord;
out vec2 lmcoord;
out vec4 glcolor;

void main() {
	vec4 position = gbufferModelViewInverse * gl_ModelViewMatrix * gl_Vertex;
	vec3 entityPos = position.xyz;

	#ifdef STATIC_WAVES // make the waves render relative to the camera's position
		entityPos += cameraPosition;
	#endif
	
	position.y = 2 * sin(entityPos.x * 0.5 + entityPos.z * 0.7) + position.y;

	gl_Position = gl_ProjectionMatrix * gbufferModelView * position;
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
}
