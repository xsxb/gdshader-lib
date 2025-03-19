shader_type canvas_item;

// TODO: Rotation
//uniform float base_rot = 0.0;
uniform float poly_length = 600.0;
//uniform sampler2D curve_texture;

void vertex() {


	float x_norm = VERTEX.x / poly_length;
	VERTEX.y -= sin(x_norm + TIME) * x_norm * 100.0 ;
	
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
