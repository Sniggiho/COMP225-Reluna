@tool
extends NewHSlider

# Please don't overload ready or process :(

signal valueChanged(value)

func _ready():
	_ready2()
	print(GLevelData.numNotes)
	if GLevelData.valid:
		value = GLevelData.numNotes
	updateLabel(str(value))


func _on_value_changed_derived(passedValue):
	updateLabel(str(value))
	GLevelData.numNotes = value
	valueChanged.emit(value)
