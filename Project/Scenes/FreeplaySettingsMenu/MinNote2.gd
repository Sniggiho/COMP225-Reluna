@tool
extends NewHSlider


var notes : Array = ["c3", "c-3", "d3", "d-3", "e3", "f3", "f-3", "g3", "g-3", "a3", "a-3", "b3", 
					 "c4", "c-4", "d4", "d-4", "e4", "f4", "f-4", "g4", "g-4", "a4", "a-4", "b4", 
					 "c5", "c-5", "d5", "d-5", "e5", "f5", "f-5", "g5", "g-5", "a5", "a-5", "b5", 
					 "c6"]
					

var noteMinIndex : int = 9
var noteMaxIndex : int = 36

# Called when the node enters the scene tree for the first time.
func _ready():
	_ready2()
	GLevelData.lowestNote = notes[value]
	updateLabel(GLevelData.lowestNote)


func _on_value_changed_derived(passedValue):
	GLevelData.lowestNote = notes[value]
	updateLabel(GLevelData.lowestNote)


func _on_max_note_value_changed(passedValue):
	maxActualValue = passedValue
