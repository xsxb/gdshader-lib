shader_type spatial;

render_mode unshaded;

uniform vec3 line_color : source_color = vec3(1.0, 1.0, 1.0);
uniform vec2 resolution = vec2(32.0, 32.0);
uniform float thickness = 0.5;
uniform float brightness : hint_range (0.0, 5.0)= 1.0;
uniform float zoom = 32.0;

uniform float speed_y : hint_range (0.0, 1.5) = 0.0;
uniform float speed_x : hint_range (0.0, 1.5) = 0.0;

float draw_grid(vec2 uv)
{
	vec2 grid_uv = cos(uv * TAU);
	return max(grid_uv.x, grid_uv.y);
}

void vertex() {
	//VERTEX.y += cos(VERTEX.x * 1.5) * sin(VERTEX.z / 5.0) * sin(TIME);
}

void fragment() {

	vec2 uv = vec2(UV[0] - 0.5 * TIME * speed_x, UV[1] - 0.5 * TIME * speed_y);

	// Adjust for aspect ratio
	uv.x *= resolution.x / resolution.y;

	//float zoom = abs(sin(TIME * 0.5)) * 40.0;

	float line_thickness = zoom * thickness / resolution.y;

	//uv += vec2(sin(TIME) * 0.4, cos(TIME) * 0.6);
	float intensity = smoothstep(0.9, 1.0, draw_grid(uv * zoom));


	ALBEDO = line_color * intensity * brightness;
	ALPHA *= intensity;


	//if (mod(UV[0], 0.1) <= 0.1)
	//{
		//ALBEDO = vec3(1.0, 1.0, 1.0);
	//}


	//if (POINT_COORD.x == VERTEX.x)
	//{
		//ALBEDO = vec3(1.0, 1.0, 1.0);
	//}

}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
