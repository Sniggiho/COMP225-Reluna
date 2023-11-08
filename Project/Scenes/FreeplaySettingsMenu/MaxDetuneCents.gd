extends VSlider

var text : RichTextLabel = RichTextLabel.new()

func _ready() -> void:
	text.text = str(value)
	text.size = Vector2(100, 100)
	text.mouse_filter = Control.MOUSE_FILTER_IGNORE
	text.position = Vector2(0, -30)
	add_child(text)
	
	GLevelData.maxDetuneCents = value


func _on_value_changed(passedValue):
	text.text = str(passedValue)
	GLevelData.maxDetuneCents = passedValue
