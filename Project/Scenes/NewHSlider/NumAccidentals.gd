@tool
extends NewHSlider


# Called when the node enters the scene tree for the first time.
func _ready():
	_ready2()
	if GLevelData.valid:
		value = GLevelData.numAccidentals
		
	_set_text()
	updateLabel(str(value))
	GLevelData.numAccidentals = value

	


func _on_value_changed_derived(passedValue):
	GLevelData.numAccidentals = value 
	updateLabel(str(value))
	grab_focus()

func _set_text():
	if GLevelData.bySharps:
		$CenterContainer/Text.defaultText = "Number of Sharps"
		updateLabel(str(value))
	else:
		$CenterContainer/Text.defaultText = "Number of Flats"
		updateLabel(str(value))


func _on_by_sharps_buttons_changed():
	_set_text()
