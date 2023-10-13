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

var _numNotes : int
var _detunedList : Array
var _detuneDir : int # -1 for flat only, 0 for both, 1 for sharp only
var _maxDetuneCents : int
var _minDetuneCents : int

# Indicates the list of notes that are put on the screen
var _listOfNotes : Array
# Pregenerated list of all possible notes 
var _possibleNotes : Array

var _selectedNotes : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	generate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

## For use in free play mode, the user's selection of difficulty is passed to
## the Tune Creator for the generation of notes. 
func setupRand(numAccidentals, bySharps, minOct, maxOct, detunedList, detuneDir, maxDetuneCents, minDetuneCents) -> void:
	_possibleNotes = _createNoteArrayInKey(numAccidentals,bySharps,minOct,maxOct)
	
	_numNotes = len(detunedList)
	_detunedList = detunedList
	_detuneDir = detuneDir # -1 for flat only, 0 for both, 1 for sharp only
	_maxDetuneCents = maxDetuneCents
	_minDetuneCents = minDetuneCents

## Given the parameters for generating notes, running generate will populate the screen with notes. 
func generate() -> void:
	var dx : float = 1.0 / (_numNotes-1)
	dx = 1.0 / _numNotes
	
	for i in range(_numNotes):
		_pathFollower.progress_ratio += dx
		var note = _noteScene.instantiate()
		
		if _detunedList[i]: # if this note should be detuned
			var tempDetuneDir : int
			
			if _detuneDir == 0: # if we can detune either way, randomly select which
				tempDetuneDir = randi_range(0,1)*-1
			else: # otherwise just go with the detune direction previously specified
				tempDetuneDir = _detuneDir
				
			if tempDetuneDir == 1:
				note.setDetuneCents(randi_range(_minDetuneCents, _maxDetuneCents))
			elif tempDetuneDir == -1:
				note.setDetuneCents(randi_range(-1*_maxDetuneCents, -1*_minDetuneCents))
			else:
				print("Error in detune direction. Should not get here")
				
		note.setNoteByName(_possibleNotes[randi() % _possibleNotes.size()])
		
		note.orientation()
		add_child(note)
		_listOfNotes.append(note)
		note.global_position = _pathFollower.position
		
## Getter method for retrieving the list of notes
func getListOfNotes() -> Array:
	return _listOfNotes

## Getter method for the set of notes the user has selected (i.e., that bad ones)
func retrieveSelectedNotes() -> Array:
	_selectedNotes = []
	for n in _listOfNotes:
		_selectedNotes.append(n.selected)
	return _selectedNotes

## Remove all notes.
func cleanup() -> void:
	for note in _listOfNotes:
		note.queue_free()

# Internal function for creation of all possible note names between two given octaves. 
func _createNoteArrayChromatic(lowOct, highOct)-> Array:
	"""Generates all the possible note names between the two given octaves (inclusive)
	"""
	var allNotes = []
	for note in ["a","b","c","d","e","f","g"]:
		for oct in range(lowOct,highOct+1):
			allNotes.append(note+str(oct))
			if note not in ["b","e"]:
				allNotes.append(note+"-"+str(oct))
	return allNotes

	
##Creates an array containing the note names for a mode with the specified number of accidentals
##
##	Parameters:
##		accidentals : int 
##			number of accidentals for the desired key
##		bySharps : boolean 
##			if true adds accidentals as sharps; otherwise adds them as flats
##		lowOct : int 
##			lowest octave from which to include note (inclusive)
##		highOct : int 
##			lowest octave from which to include note (inclusive)
##
##	Return:
##		allNotes : array
##			array containing the names of all notes found in the given key
func _createNoteArrayInKey(accidentals, bySharps, lowOct, highOct) -> Array:

	# sharps order is: F – C – G – D – A – E – B
	# flats order is: B - E - A - D - G - C - F
	
	var sharps = ["f-", "c-", "g-", "d-", "a-", "e-", "b-"]
	
	var flats = ["a-", "d-", "g-", "c-", "f-", "b-", "e-"]
	var naturalsForFlats = ["b","e","a","d","g","c","f"] # to simplify adding natural notes to a key with flats
	
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
			notesInKey.append(naturalsForFlats[i])
	
	for oct in range(lowOct,highOct+1):
		for note in notesInKey:
			allNotes.append(note+str(oct))
	
	return allNotes
