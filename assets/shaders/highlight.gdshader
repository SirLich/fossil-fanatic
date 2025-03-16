shader_type canvas_item;

uniform vec4 color : source_color = vec4(1.0);
uniform float width : hint_range(0, 10) = 1.0;
uniform int pattern : hint_range(0, 2) = 0; // diamond, circle, square
uniform bool inside = false;
uniform bool add_margins = true; // only useful when inside is false
uniform bool enabled = false;

uniform vec4 modulate : source_color = vec4(1.0);


void vertex() {
	if (add_margins) {
		VERTEX += (UV * 2.0 - 1.0) * width;
	}
}

void fragment() {
	if (enabled) {		
		COLOR.rgb = COLOR.rgb * vec3(1.3, 1.3, 1.3);
	}
}