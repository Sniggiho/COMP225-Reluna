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
	key  = _tuneCreator._createNoteArrayInKey(GLevelData.numAccidentals, GLevelData.bySharps, lowestNoteAllowed, highestNoteAllowed) #accidentals, bySharps, lowestNote, highestNote

# Called when the node enters the scene tree for the first time.
func _ready():
	_ready2()
	value = 0
	maxActualValue = len(key)
	max_value = len(key)-1
	GLevelData.lowestNote = lowestNoteAllowed
	updateLabel(_tuneCreator.getPrintableNoteName(GLevelData.lowestNote, GLevelData.bySharps))
	


func _on_value_changed_derived(passedValue):
	key  = _tuneCreator._createNoteArrayInKey(GLevelData.numAccidentals, GLevelData.bySharps, lowestNoteAllowed, highestNoteAllowed)
	key.sort_custom(_tuneCreator.compareNotes)
	key.reverse()
	GLevelData.lowestNote = key[value]
	updateLabel(_tuneCreator.getPrintableNoteName(GLevelData.lowestNote, GLevelData.bySharps))


func _on_max_note_value_changed(passedValue):
	maxActualValue = passedValue
