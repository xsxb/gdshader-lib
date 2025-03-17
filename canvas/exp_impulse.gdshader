shader_type canvas_item;

uniform bool preview = false;

uniform float amp = 20.0;
uniform float bpm = 60.0;

uniform float music_time;

uniform bool red_pulse = false;
uniform bool fadeout = false;

// Exponential impulse parameter
// Adjusts sharpness of curve
// Maximum happens at exactly 1/k
// Delay of 1/k not accounted for
uniform float k = 15.0;

// Called for every vertex the material is visible on.
void vertex() {

	// Move curve max to 0
	float max_offset = 1.0 / k;
	float freq = bpm / 60.0;

	float time_mod;

	// Switch to using TIME for render preview
	if (!preview) time_mod = mod((music_time + max_offset) * freq, 1.0);
	else time_mod = mod((TIME + max_offset) * freq, 1.0);

	// Exponential impulse
	float h = k * time_mod;
	float expo = h * exp(1.0 - h);

	// Stretch
	// Top left
	if (VERTEX[0] < 0.0 && VERTEX[1] < 0.0)
	{
		VERTEX = vec2(VERTEX[0] - (expo * amp) - amp,
			VERTEX[1] - (expo * amp) - amp);
	}
	// Bottom left
	else if (VERTEX[0] < 0.0 && VERTEX[1] > 0.0)
	{
		VERTEX = vec2(VERTEX[0] - (expo * amp) - amp,
			VERTEX[1] + (expo * amp) + amp);
	}
	// Bottom right
	else if (VERTEX[0] > 0.0 && VERTEX[1] > 0.0)
	{
		VERTEX = vec2(VERTEX[0] + (expo * amp) + amp,
			VERTEX[1] + (expo * amp) + amp);
	}
	// Top right
	else if (VERTEX[0] > 0.0 && VERTEX[1] < 0.0)
	{
		VERTEX = vec2(VERTEX[0] + (expo * amp) + amp,
			VERTEX[1] + (expo * -amp) - amp);
	}

}

// Called for every pixel the material is visible on.
void fragment() {

	// Move curve max to 0
	float max_offset = 1.0 / k;

	float freq = bpm / 60.0;
	float time_mod;

	// Switch to using TIME for render preview
	if (!preview) time_mod = mod((music_time + max_offset) * freq, 1.0);
	else time_mod = mod((TIME + max_offset) * freq, 1.0);

	// Exponential impulse
	float h = k * time_mod;
	float expo = h * exp(1.0 - h);

	COLOR = texture(TEXTURE, UV);

	float uv_y_inv = 0.5 - (UV[1] - 0.5);
	float uv_x_inv = 0.5 - (UV[0] - 0.5);

	if (red_pulse) COLOR.r += expo;
	if (fadeout && COLOR.a > 0.0) COLOR.a = UV[1] + expo;

	//COLOR = vec4(COLOR.r, COLOR.g, COLOR.b, COLOR.a);

}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light procescosg function with this one.
//}
