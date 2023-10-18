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


var _path : Path2D
var _pathFollower : PathFollow2D
@onready var _noteScene : PackedScene = preload("res://Scenes/Note/note.tscn") # Real note. Button functionality and sound

var _numNotes : int
var _detunedList : Array
var _detuneDir : int # -1 for flat only, 0 for both, 1 for sharp only
var _maxDetuneCents : int
var _minDetuneCents : int

# Indicates the list of notes that are put on the screen
var _listOfNotes : Array
# Pregenerated list of all possible notes 
var _possibleNotes : Array

var _givenNotes : Array # in the case where we're given a melody, this holds that melody

var _detunedAmountsList : Array # in case of full manual generation we're given a list of how much to detune each note, that's stored here

var _selectedNotes : Array

var _bySharps : bool = true

var lineHeight : float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func givePath(path : Path2D):
	self._path = path
	_pathFollower = path.get_child(0)

## For use in free play mode, the user's selection of difficulty is passed to
## the Tune Creator for the generation of notes. 
## _tuneCreator.setUpRand(numAccidentals, bySharp, minOct, maxOct, listOfDetunedNotes, detuneDirection, maxDetuneCents, minDetuneCents)
func setupRand(numAccidentals, bySharps, minOct, maxOct, detunedList, detuneDir, maxDetuneCents, minDetuneCents) -> void:
	self._possibleNotes = _createNoteArrayInKey(numAccidentals,bySharps,minOct,maxOct)
	self._bySharps = bySharps
	self._numNotes = len(detunedList)
	self._detunedList = detunedList
	self._detuneDir = detuneDir # -1 for flat only, 0 for both, 1 for sharp only
	self._maxDetuneCents = maxDetuneCents
	self._minDetuneCents = minDetuneCents
	
	generate()

## For use in tutorial mode. Given a list of notes comprising some melody, and information on which
## notes to detune, randomly detunes the given notes within given detune parameters.
func setupHalfManual(notes, bySharps, detunedList, detuneDir, maxDetuneCents, minDetuneCents):
	self.givenNotes = notes
	self._bySharps = bySharps
	self._numNotes = len(notes)
	self._detunedList = detunedList
	self._detuneDir = detuneDir # -1 for flat only, 0 for both, 1 for sharp only
	self._maxDetuneCents = maxDetuneCents
	self._minDetuneCents = minDetuneCents
	generate(false, true)
	
func setupFullManual(notes, bySharps, detunedAmountsList):
	self.givenNotes = notes
	self._bySharps = bySharps
	self._numNotes = len(notes)
	for i in range(len(notes)):
		if detunedAmountsList[i] == 0:
			self._detunedList.append(false)
		else:
			self._detunedList.append(true)
			
	generate(false, false)

## Given the parameters for generating notes, running generate will populate the screen with notes. 
func generate(randomNotes = true, randomDetune = true) -> void:
	var dx : float = 1.0 / (_numNotes-1)
	dx = 1.0 / _numNotes
	
	for i in range(_numNotes):
		_pathFollower.progress_ratio += dx
		var note = _noteScene.instantiate()
		
		if randomNotes:		# if we should randomly generate the note values
			note.setNoteByName(_possibleNotes[randi() % _possibleNotes.size()])
		else: # if we've been given a pre-built melody
			note.setNoteByName(_givenNotes[i])
		
		if _detunedList[i]: # if this note should be detuned
			if randomDetune: # if we will randomly select how to detune thia note
				var tempDetuneDir : int
				
				if _detuneDir == 0: # if we can detune either way, randomly select which
					tempDetuneDir = randi_range(0,1)*2-1
				else: # otherwise just go with the detune direction previously specified
					tempDetuneDir = _detuneDir
					
				if tempDetuneDir == 1:
					note.setDetuneCents(randi_range(_minDetuneCents, _maxDetuneCents))
				elif tempDetuneDir == -1:
					note.setDetuneCents(randi_range(-1*_maxDetuneCents, -1*_minDetuneCents))
				else:
					print("Error in detune direction. Should not get here")
			else: # if we're in full manual tune creation, and just need to look up the proper detune amount
				note.setDetuneCents(self._detunedAmountsList[i])

		note.orientation()
		add_child(note)
		
		_listOfNotes.append(note)
		note.global_position = _pathFollower.global_position
		note.global_position.y += -1 * (note.hOffset() * lineHeight / 2)
		##print(note.hOffset() * lineHeight / 2)
#	_pathFollower.progress_ratio = 0

	
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

	assert(accidentals<=6) # cannot have more than 6 accidentals
	# sharps order is: F – C – G – D – A – E – B
	# flats order is: B - E - A - D - G - C - F
	
	var sharps = ["f-", "c-", "g-", "d-", "a-", "f", "c"]
	
	var flats = ["a-", "d-", "g-", "c-", "f-", "c", "f"]
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
	
	print("Current key contains:", allNotes)
	return allNotes

## return if scale is sharp or flat
func getBySharps() -> bool:
	return self._bySharps
