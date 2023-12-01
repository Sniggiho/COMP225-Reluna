@tool
extends NewHSlider


# Called when the node enters the scene tree for the first time.
func _ready():
	_ready2()
	if GLevelData.valid:
		value = GLevelData.bpm
	updateLabel(str(value))
	GLevelData.bpm = value




func _on_value_changed_derived(passedValue):
	GLevelData.bpm = value
	updateLabel(str(value))
