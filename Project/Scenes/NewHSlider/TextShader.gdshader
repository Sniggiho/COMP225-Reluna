shader_type canvas_item;

uniform float rightEdge;

uniform vec4 positiveTextColor;
uniform vec4 negativeTextColor;

void fragment() {
	if (rightEdge > SCREEN_UV.x) {
		COLOR.rgb = positiveTextColor.rgb;
	} else {
		COLOR.rgb = negativeTextColor.rgb;
	}
}
