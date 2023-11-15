extends VSlider

var text : RichTextLabel = RichTextLabel.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	text.size = Vector2(100, 100)
	text.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(text)
	
	if GLevelData.valid:
		value = GLevelData.bpm
	
	text.text = str(value)
	GLevelData.bpm = int(value)
	

## PASSED FROM SELF
func _on_value_changed(passedValue):
	text.text = str(passedValue)
	GLevelData.bpm = int(passedValue)
	print(GLevelData.bpm)
