extends VSlider

var text : RichTextLabel = RichTextLabel.new()

func _ready() -> void:
	text.size = Vector2(100, 100)
	text.mouse_filter = Control.MOUSE_FILTER_IGNORE
	text.position = Vector2(0, -30)
	if GLevelData.valid:
		value = GLevelData.maxDetuneCents
	
	text.text = str(value)
	add_child(text)
	
	GLevelData.maxDetuneCents = value


func _on_value_changed(passedValue):
	text.text = str(passedValue)
	GLevelData.maxDetuneCents = passedValue
