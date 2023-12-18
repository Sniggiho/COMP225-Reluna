@tool
extends NewHSlider


# Called when the node enters the scene tree for the first time.
func _ready():
	_ready2()
	if GLevelData.valid:
		value = GLevelData.numAccidentals
	updateLabel(str(value))
	GLevelData.numAccidentals = value


func _on_value_changed_derived(passedValue):
	GLevelData.numAccidentals = value 
	updateLabel(str(value))
	grab_focus()
