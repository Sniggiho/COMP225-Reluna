extends Node2D
class_name TuneCreator
## The tune creator is an object that handles, in our main scene, the generation of notes.
## 	
## Must be given a Path2D in the inspector (this Path2D must have its PathFollow2D).
## Then, the TuneCreator be given the note scene. 
##
## For n notes, the tune creator divides the path into equal chunks.
## A note is created, then added as a child of the TuneCreator.
## 	NOTE: the note's position is edited with *global* position


@export var _path : Path2D
@onready var _pathFollower : PathFollow2D = _path.get_child(0)
@export var _dummyNote : PackedScene # This is a dummy note of a dog sprite.
@export var _noteScene : PackedScene # Real note. Button functionality and sound

var _numNotes : int = 5

# Indicates the list of notes that are put on the screen
var _listOfNotes : Array

# Pregenerated list of all possible notes 
var _possibleNotes : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	_possibleNotes = _createNoteArrayInKey(4,3,5, false)
	generate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

## For use in free play mode, the user's selection of difficulty is passed to
## the Tune Creator for the generation of notes. 
func setSpawnParameters() -> void:
	pass

## Supply a specific melody or set of notes to create.
## i.e. tutorial levels or debugging. 
func setSpecifcSpawn() -> void:
	pass

## Given the parameters for generating notes, running generate will populate the screen with notes. 
func generate() -> void:
	var dx : float = 1.0 / (_numNotes-1)
	dx = 1.0 / _numNotes
	
	for i in range(_numNotes):
		_pathFollower.progress_ratio += dx
		var note = _noteScene.instantiate()
		note.setDetuneCents(randi_range(-50,50))
		note.setNoteByName(_possibleNotes[randi() % _possibleNotes.size()])
		
		add_child(note)
		_listOfNotes.append(note)
		note.global_position = _pathFollower.position

## Getter method for retrieving the list of notes
func getListOfNotes() -> Array:
	return _listOfNotes

## Getter method for the set of notes the user has selected (i.e., that bad ones)
func getSelectedNotes() -> Array:
	return []
	pass

## Remove all notes.
func cleanup() -> void:
	for note in _listOfNotes:
		note.queue_free()

# Internal function for creation of all possible note names between two given octaves. 
func _createNoteArrayChromatic(lowOct, highOct)-> Array:
	""" This currently just generates all the possible note names between the two given octaves.
	Later, this should be able to generate specific keys as note sets, and give more control in the exact range created,
	the idea being that the user will someday adjust these parameters"""
	var allNotes = []
	for note in ["a","b","c","d","e","f","g"]:
		for oct in range(lowOct,highOct+1):
			allNotes.append(note+str(oct))
			if note not in ["b","e"]:
				allNotes.append(note+"-"+str(oct))
	return allNotes
	
func _createNoteArrayInKey(accidentals, lowOct, highOct, bySharps=true) -> Array:
	""" Creates an array containing the note names for a mode with the specified number of sharps"""
	# sharps order is: F – C – G – D – A – E – B
	# flats order is: B - E - A - D - G - C - F
	
	var sharps = ["f-", "c-", "g-", "d-", "a-", "e-", "b-"]
	var flats = ["a-", "d-", "g-", "c-", "f-", "b-", "e-"]
	
	var notesInKey = []
	var allNotes = []
	
	if bySharps:
		for i in range(accidentals):
			notesInKey.append(sharps[i])
		for i in range(accidentals, 7):
			notesInKey.append(sharps[i].replace("-",""))
	else:
		for i in range(accidentals):
			notesInKey.append(flats[i])
		for i in range(accidentals, 7):
			notesInKey.append(flats[i].replace("-",""))
	
	for oct in range(lowOct,highOct+1):
		for note in notesInKey:
			allNotes.append(note+str(oct))
	
	return allNotes
