shader_type canvas_item;

uniform bool preview = false;

uniform float bpm;
uniform float music_time;

uniform float c = 0.8;
uniform float dimm = 8.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {

	float freq = bpm / 60.0 / 2.0;
	float time;

	if (preview == false) time = music_time;
	else time = TIME;

	COLOR = texture(TEXTURE, UV);
	//UV invert
	float uv_y_inv = 0.5 - (UV[1] - 0.5);

	//Darken
	COLOR -= (sin(time * TAU * freq) + c) / dimm * UV[1];

}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
