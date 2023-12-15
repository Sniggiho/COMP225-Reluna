@tool
extends NewHSlider

signal maxNoteChanged(passedValue : int)

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
	
	print("gleveldata highest note ", GLevelData.highestNote)

	if GLevelData.valid:
		var highestNote = GLevelData.highestNote
		_key_updated()
		value = key.find(highestNote)
		updateLabel(_tuneCreator.getPrintableNoteName(GLevelData.highestNote, GLevelData.bySharps))
	else:
		_key_updated()
		value = len(key) -1#accidentals, bySharps, lowestNote, highestNote
		GLevelData.highestNote = key[value]


func _on_value_changed_derived(passedValue):
	GLevelData.highestNote = key[value]
	updateLabel(_tuneCreator.getPrintableNoteName(GLevelData.highestNote, GLevelData.bySharps))
	maxNoteChanged.emit(value)
	#GLevelData.highestNote = notes[value+1]
	#updateLabel(notes[value])


#func _on_min_note_value_changed(passedValue):
#	minActualValue = passedValue

func _key_updated():
	key  = _tuneCreator._createNoteArrayInKey(GLevelData.numAccidentals, GLevelData.bySharps, lowestNoteAllowed, highestNoteAllowed)
	key.sort_custom(_tuneCreator.compareNotes)
	key.reverse()
	maxActualValue = len(key)-1
	max_value = len(key) -1
	GLevelData.highestNote = key[value]
	updateLabel(_tuneCreator.getPrintableNoteName(GLevelData.highestNote, GLevelData.bySharps))
	

func _on_num_accidentals_value_changed(value):
	if self.is_inside_tree():
		_key_updated()


func _on_by_sharps_buttons_changed():
	if self.is_inside_tree():
		_key_updated()


func _on_min_note_min_note_changed(passedValue):
	minActualValue = passedValue
