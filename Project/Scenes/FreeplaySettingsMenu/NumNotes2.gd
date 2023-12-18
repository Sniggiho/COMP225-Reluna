@tool
extends NewHSlider

# Please don't overload ready without calling _ready2() :(

signal valueChanged(value)

func _ready():
	_ready2()
	if GLevelData.valid:
		value = GLevelData.numNotes
	updateLabel(str(value))
	GLevelData.numNotes = value


func _on_value_changed_derived(passedValue):
	updateLabel(str(value))
	GLevelData.numNotes = value
	valueChanged.emit(value)
	grab_focus()
