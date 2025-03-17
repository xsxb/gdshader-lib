shader_type canvas_item;

uniform float blue_dimm = 2.0;
uniform float amp = 20.0;
uniform float bpm = 60.0;	//BPM

// Called for every vertex the material is visible on.
void vertex() {

	float freq = bpm * 2.0 * PI / 60.0;

	// Stretch
	// Top left
	if (UV[0] < 0.5 && UV[1] < 0.5)
	{
		VERTEX = vec2(VERTEX[0] - (cos(TIME * freq) * amp) - amp,
			VERTEX[0] - (cos(TIME * freq) * amp) - amp);
	}
	// Bottom left
	else if (UV[0] < 0.5 && UV[1] >= 0.5)
	{
		VERTEX = vec2(VERTEX[0] - (cos(TIME * freq) * amp) - amp,
			VERTEX[1] + (cos(TIME * freq) * amp) + amp);
	}
	// Top right
	else if (UV[0] >= 0.5 && UV[1] >= 0.5)
	{
		VERTEX = vec2(VERTEX[0] + (cos(TIME * freq) * amp) + amp,
			VERTEX[0] + (cos(TIME * freq) * amp) + amp);
	}
	// Bottom right
	else if (UV[0] >= 0.5 && UV[1] < 0.5)
	{
		VERTEX = vec2(VERTEX[0] + (cos(TIME * freq) * amp) + amp,
			VERTEX[1] + (cos(TIME * freq) * -amp) - amp);
	}

}

// Called for every pixel the material is visible on.
void fragment() {

	float freq = bpm * 2.0 * PI / 60.0;

	COLOR = texture(TEXTURE, UV);

	float uv_y_inv = 0.5 - (UV[1] - 0.5);
	float uv_x_inv = 0.5 - (UV[0] - 0.5);

	COLOR = vec4(COLOR.r + cos(TIME * freq), COLOR.g, COLOR.b + uv_y_inv / blue_dimm, UV[1] + cos(TIME * freq));
	//COLOR = vec4(UV[0], 0.5, 0.5, 1.0);

}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
