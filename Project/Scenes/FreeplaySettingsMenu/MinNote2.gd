@tool
extends NewHSlider

signal minNoteChanged(passedValue : int)

var highestNoteAllowed = "c6" # this is exclusive! meaning the highest is really c6
var lowestNoteAllowed = "a3"

var _tuneCreatorScene : PackedScene = preload("res://Scenes/TuneCreator/tune_creator.tscn")
var _tuneCreator : TuneCreator

var key : Array

func _init():
	_tuneCreator = _tuneCreatorScene.instantiate()
	add_child(_tuneCreator)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	_ready2()
	if GLevelData.valid:
		var lowestNote = GLevelData.lowestNote
		_key_updated()
		maxActualValue = len(key)-1
		max_value = len(key)-1
		value = key.find(lowestNote)
		updateLabel(_tuneCreator.getPrintableNoteName(GLevelData.lowestNote, GLevelData.bySharps))
	else:
		value = 0
		_key_updated()
		maxActualValue = len(key)-1
		max_value = len(key)-1
	

func _on_value_changed_derived(passedValue):
	GLevelData.lowestNote = key[value]
	updateLabel(_tuneCreator.getPrintableNoteName(GLevelData.lowestNote, GLevelData.bySharps))
	minNoteChanged.emit(value)

#func _on_max_note_value_changed(passedValue):
#	print("max note value changed called with passed value = ", passedValue)
#	maxActualValue = passedValue
	

	
func _key_updated():
	key  = _tuneCreator._createNoteArrayInKey(GLevelData.numAccidentals, GLevelData.bySharps, lowestNoteAllowed, highestNoteAllowed)
	key.sort_custom(_tuneCreator.compareNotes)
	key.reverse()
	GLevelData.lowestNote = key[value]
	updateLabel(_tuneCreator.getPrintableNoteName(GLevelData.lowestNote, GLevelData.bySharps))
	maxActualValue = min(maxActualValue, len(key)-1)
	max_value = len(key)-1


func _on_by_sharps_buttons_changed():
	if self.is_inside_tree():
		_key_updated()



func _on_num_accidentals_value_changed(value):
	if self.is_inside_tree():
		_key_updated()

func _on_max_note_max_note_changed(passedValue):
	maxActualValue = passedValue
