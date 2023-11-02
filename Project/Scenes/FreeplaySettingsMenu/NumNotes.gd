extends HSlider

var text : RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	text = RichTextLabel.new()
	add_child(text)
	text.size = Vector2(100, 100)
	text.position = Vector2(-30, -30)
	text.mouse_filter = Control.MOUSE_FILTER_IGNORE


func _on_value_changed(passedValue):
	text.text = str(passedValue)
	GLevelData.numNotes = passedValue
