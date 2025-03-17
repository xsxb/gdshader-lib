shader_type particles;

uniform vec3 origin = vec3(50.0,100.0,0.0);

void start() {
	VELOCITY = vec3(0.0, 10.0, 0.0);
}

void process() {

	if (RESTART)
	{
		TRANSFORM[3] = vec4(origin, 1.0);
	}

	TRANSFORM[3][3] += sin(TIME);
	VELOCITY += vec3(2.0, 1.0, 0.0);
	COLOR.r += sin(TIME * TAU / LIFETIME);

	//COLOR.b += TRANSFORM.yy;
	// Called every frame on existing particles (according to the Fixed FPS property).
}
