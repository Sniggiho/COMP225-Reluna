@tool
extends NewHSlider

var highestNoteAllowed = "d6" # this is exclusive! meaning the highest is really c6
var lowestNoteAllowed = "a3"

var _tuneCreatorScene : PackedScene = preload("res://Scenes/TuneCreator/tune_creator.tscn")
var _tuneCreator : TuneCreator

var key : Array

func _init():
	_tuneCreator = _tuneCreatorScene.instantiate()
	add_child(_tuneCreator)
	key  = _tuneCreator._createNoteArrayInKey(GLevelData.numAccidentals, GLevelData.bySharps, lowestNoteAllowed, highestNoteAllowed)
	maxActualValue = len(key)-1
	max_value = len(key) -1 
	
# Called when the node enters the scene tree for the first time.
func _ready():
	_ready2()
	GLevelData.highestNote = key[-1]
	updateLabel(_tuneCreator.getPrintableNoteName(GLevelData.highestNote, GLevelData.bySharps))
	value = len(key) -1#accidentals, bySharps, lowestNote, highestNote


func _on_value_changed_derived(passedValue):
	key  = _tuneCreator._createNoteArrayInKey(GLevelData.numAccidentals, GLevelData.bySharps, lowestNoteAllowed, highestNoteAllowed)
	maxActualValue = len(key)-1
	max_value = len(key) -1 
	key.sort_custom(_tuneCreator.compareNotes)
	key.reverse()
	print(value)
	GLevelData.highestNote = key[value]
	updateLabel(_tuneCreator.getPrintableNoteName(GLevelData.highestNote, GLevelData.bySharps))
	
	#GLevelData.highestNote = notes[value+1]
	#updateLabel(notes[value])


func _on_min_note_value_changed(passedValue):
	minActualValue = passedValue


