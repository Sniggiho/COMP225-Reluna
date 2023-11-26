@tool
extends NewHSlider


# Called when the node enters the scene tree for the first time.
func _ready():
	_ready2()
	if GLevelData.valid:
		value = GLevelData.maxDetuneCents
	updateLabel(str(value))


func _on_value_changed_derived(passedValue):
	updateLabel(str(value))
	GLevelData.maxDetuneCents = value
