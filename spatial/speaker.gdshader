shader_type spatial;

uniform float bpm = 120.0;
uniform float k : hint_range(0.1, 50) = 15.0;
uniform float amp : hint_range(0.01, 10) = 0.5;

void vertex() {

	float freq = bpm / 60.0;

	// Curve maximum
	float max_offset = 1.0 / k;

	float time_mod = mod((TIME + max_offset) * freq, 1.0);

	// Exponential impulse
	float h = k * time_mod;
	float expo = h * exp(1.0 - h);

	VERTEX += VERTEX * vec3(expo, 0.0, expo) * amp;

}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
