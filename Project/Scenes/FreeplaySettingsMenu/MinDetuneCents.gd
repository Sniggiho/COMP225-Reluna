extends VSlider

var text : RichTextLabel = RichTextLabel.new()

var maxDetunedCents = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	text.text = str(value)
	add_child(text)
	text.position = Vector2(0, -30)
	text.size = Vector2(100, 100)
	text.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	GLevelData.minDetuneCents = value
	

## CONNECTED FROM SELF
func _on_value_changed(passedValue):
	if passedValue > maxDetunedCents:
		passedValue = maxDetunedCents
	value = passedValue
	text.text = str(passedValue)
	GLevelData.minDetuneCents = passedValue


## CONNECTED FROM MAX DETUNED CENTS (sets bound so min isn't more than max)
func _on_max_detune_cents_value_changed(passedValue):
	maxDetunedCents = passedValue
	if self.value > passedValue:
		self.value = passedValue
	pass
