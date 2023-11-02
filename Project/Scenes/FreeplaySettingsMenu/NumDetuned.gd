extends HSlider

var numNotes = GLevelData.numNotes

var text : RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	text = RichTextLabel.new()
	text.size = Vector2(100, 100)
	text.position = Vector2(-30, -30)
	text.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(text)
	min_value = 1
	value = min_value


func _on_num_notes_value_changed(passedValue):
	max_value = passedValue-1
	if self.value > max_value:
		self.value = max_value


func _on_value_changed(passedValue):
	text.text = str(passedValue)
	GLevelData.numDetunedNotes = passedValue
