@tool
extends NewHSlider

var maxDetunedCents = 30


# Called when the node enters the scene tree for the first time.
func _ready():
	_ready2()
	if GLevelData.valid:
		value = GLevelData.minDetuneCents
	updateLabel(str(value))
	GLevelData.minDetuneCents = value


## SIGNAL FROM SELF
func _on_value_changed_derived(passedValue):
	if passedValue > maxDetunedCents:
		passedValue = maxDetunedCents
	maxActualValue = passedValue
	updateLabel(str(value))
	GLevelData.minDetuneCents = value


func _on_max_detune_cents_value_changed(passedValue):
	maxDetunedCents = passedValue
	if self.value > passedValue:
		self.value = passedValue
