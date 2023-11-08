extends HSlider

var text : RichTextLabel = RichTextLabel.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	text.text = str(value)
	text.size = Vector2(100, 100)
	text.position = Vector2(-30, -30)
	text.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(text)
	
	GLevelData.numNotes = value


# SIGNAL FROM SELF
# Whenever this slider's value changes, update the text and GLevelData
func _on_value_changed(passedValue):
	text.text = str(passedValue)
	GLevelData.numNotes = passedValue
