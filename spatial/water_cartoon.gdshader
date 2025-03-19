shader_type spatial;

render_mode specular_toon;
render_mode diffuse_toon;

uniform sampler2D noise;
uniform sampler2D normalmap;
uniform float mesh_size = 2.0;
uniform float wave_speed = 3.0;
uniform float height_adjust : hint_range(-4.0, 4.0) = -1.0;

uniform float height_scale : hint_range (0.0, 1.5)= 0.5;

float height(vec2 position, float time) {
	vec2 offset = 0.01 * cos(position + time);
	return texture(noise, position / mesh_size - offset).x;
}

void vertex() {
	
	vec2 pos = VERTEX.xz;
	float k = height(pos, TIME * wave_speed) * height_scale + height_adjust;
	
	NORMAL = normalize(vec3(k - height(pos + vec2(0.1, 0.0), TIME), 0.1, k - height(pos + vec2(0.0, 0.1), TIME)));
	
	VERTEX.y += k;
}

void fragment() {

	RIM = 0.2;
	METALLIC = 0.0;
	ROUGHNESS = 0.01;
	ALBEDO = vec3(0.1, 0.3, 0.5);

	//NORMAL_MAP = texture(normalmap, tex_position).xyz;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
