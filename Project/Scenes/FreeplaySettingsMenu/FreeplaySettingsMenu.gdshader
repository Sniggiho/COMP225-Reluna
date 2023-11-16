shader_type canvas_item;

uniform vec2 mousePosition;

void fragment() {
	COLOR.x = mousePosition.x;
	COLOR.y = mousePosition.y;
}
