extends RichTextLabel

@export var shader : Shader

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse = get_global_mouse_position()
	var screen = get_viewport_rect().size
	mouse.x /= screen.x
	mouse.y /= screen.y
	get_material().set_shader_parameter("mousePosition", mouse)
