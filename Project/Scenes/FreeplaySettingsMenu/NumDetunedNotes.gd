@tool
extends NewHSlider

# Called when the node enters the scene tree for the first time.
func _ready():
	_ready2()
	if GLevelData.valid:
		value = GLevelData.numDetunedNotes
	updateLabel(str(value))
	GLevelData.numDetunedNotes = value
	

## CONNECTED FROM SELF
func _on_value_changed_derived(passedValue):
	updateLabel(str(value))
	GLevelData.numDetunedNotes = value
	grab_focus()


## CONNECTED FROM NUM NOTES
func _on_num_notes_value_changed(passedValue):
	max_value = passedValue - 1
	maxActualValue = max_value
