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

@onready var _noteScene : PackedScene = preload("res://Scenes/Note/note.tscn")

# the number of notes to create and manage
var _numNotes : int

# A list detailing which notes are out of tune
var _detunedList : Array

# If out of tune notes may be sharp or flat. 
var _detuneDir : int # -1 for flat only, 0 for both, 1 for sharp only

# The maximum and minimum amount that notes should be detuned
var _maxDetuneCents : int
var _minDetuneCents : int

# Indicates the list of notes that are put on the screen
var _listOfNotes : Array

# Pregenerated list of all possible notes 
var _possibleNotes : Array

# In the case where we're given a melody, this holds that melody
var _givenNotes : Array 

# In case of full manual generation we're given a list of how much to detune each note, that's stored here
var _detunedAmountsList : Array 

# Currently selected notes. Compared to the list of detuned notes to check user input
var _selectedNotes : Array

# If the current key uses sharps (true) or flats (false)
var _bySharps : bool = true

var lineHeight : float


## Setter for the TuneCreator's path and path follower
func givePath(path : Path2D):
	self._path = path
	_pathFollower = path.get_child(0)

## For use in free play mode, the user's desired level generation settings are passed to
## the Tune Creator for the generation of notes. 
func setupRand(numAccidentals, bySharps, lowestNote, highestNote, detunedList, detuneDir, maxDetuneCents, minDetuneCents) -> void:
	self._possibleNotes = _createNoteArrayInKey(numAccidentals,bySharps,lowestNote,highestNote)
	self._bySharps = bySharps
	self._numNotes = len(detunedList)
	self._detunedList = detunedList
	self._detuneDir = detuneDir # -1 for flat only, 0 for both, 1 for sharp only
	self._maxDetuneCents = maxDetuneCents
	self._minDetuneCents = minDetuneCents
	
	generate()

## Given a list of notes comprising some melody, and information on which
## notes to detune, randomly detunes the given notes within given detune parameters.
func setupHalfManual(notes, bySharps, detunedList, detuneDir, maxDetuneCents, minDetuneCents):
	self._givenNotes = notes
	self._bySharps = bySharps
	self._numNotes = len(notes)
	self._detunedList = detunedList
	self._detuneDir = detuneDir # -1 for flat only, 0 for both, 1 for sharp only
	self._maxDetuneCents = maxDetuneCents
	self._minDetuneCents = minDetuneCents
	generate(false, true)

##  For use in tutorial mode. Given a list of notes, and how much (if any) to detune each, generates a tune
func setupFullManual(notes, bySharps, detunedAmountsList):
	self._givenNotes = notes
	self._bySharps = bySharps
	self._numNotes = len(notes)
	self._detunedAmountsList = detunedAmountsList
	for i in range(len(notes)):
		if detunedAmountsList[i] == 0:
			self._detunedList.append(false)
		else:
			self._detunedList.append(true)
			
	generate(false, false)

## Given the parameters for generating notes, running generate will populate the screen with notes. 
func generate(randomNotes = true, randomDetune = true) -> void:

	var pathMin = 0.0
	var pathMax = 1
	var dx = (pathMax - pathMin) / (float) (_numNotes + 1)
	
	_pathFollower.progress_ratio = pathMin
	
	var pathY : float = _pathFollower.global_position.y
	for i in range(_numNotes):
		var note : Note = _noteScene.instantiate()
		_pathFollower.progress_ratio += dx
		
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

		add_child(note) 
		note.orientation()
		note.lineHeight = lineHeight
		_listOfNotes.append(note)
		note.global_position.x = _pathFollower.global_position.x
		note.global_position.y = pathY + -1 * (note.hOffset() * lineHeight / 2)

	_listOfNotes[0].selectable = false

	
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
	var allNotes = []
	for note in ["a","b","c","d","e","f","g"]:
		for oct in range(lowOct,highOct+1):
			allNotes.append(note+str(oct))
			if note not in ["b","e"]:
				allNotes.append(note+"-"+str(oct))
	return allNotes

	
## Creates an array containing all notes in a key with the specified number and type
## of accidentals between the given lowest and highest note
func _createNoteArrayInKey(accidentals, bySharps, lowestNote, highestNote) -> Array:
	assert(accidentals<=6) # cannot have more than 6 accidentals
	# sharps order is: F – C – G – D – A – E – B
	# flats order is: B - E - A - D - G - C - F
	
	var sharps = ["f-", "c-", "g-", "d-", "a-", "f", "c"]
	var naturalsForSharps = ["f", "c", "g", "d", "a", "e", "b"]
	
	var flats = ["a-", "d-", "g-", "c-", "f-", "c", "f"]
	var naturalsForFlats = ["b","e","a","d","g","c","f"] # to simplify adding natural notes to a key with flats
	
	var notesInKey = []
	var allNotes = []
	
	if bySharps:
		for i in range(accidentals):
			notesInKey.append(sharps[i])
		for i in range(accidentals, 7):
			notesInKey.append(naturalsForSharps[i])
	else:
		for i in range(accidentals):
			notesInKey.append(flats[i])
		for i in range(accidentals, 7):
			notesInKey.append(naturalsForFlats[i])
			
	var lowOct = int(lowestNote[-1])
	var highOct = int(highestNote[-1])
	
	for oct in range(lowOct,highOct+1): # creates the scale in all of the possible octaves
		for note in notesInKey:
			allNotes.append(note+str(oct))
	
	var allNotesCorrectRange = []
	for n in allNotes: # narrows down to only the permitted notes
		if self.compareNotes(n, lowestNote) and self.compareNotes(highestNote, n):
			allNotesCorrectRange.append(n)
			
	return allNotesCorrectRange

## return if scale is sharp or flat
func getBySharps() -> bool:
	return self._bySharps
	
## given a note name consistent with the internal use of this program, returns the same
# note name but formatted appropriately for printing.
# e.g. "c-5" becomes "C#5"
func getPrintableNoteName(n, bySharps : bool):
	n = n.to_upper()
	if n.contains("-"):
		if bySharps:
			n = n.replace("-", "#")
		else:
			var noteNames = ["A", "B", "C", "D", "E", "F", "G", "A"]
			var enharmonicIdx = noteNames.find(n[0])
			n = noteNames[enharmonicIdx+1]+ n.right(-1) 
			n = n.replace("-",  "b")
	return n

## returns true if the first note is higher than or equal to the second note, and false if the second note is higher 
func compareNotes(n1,n2) -> bool:
	var oct1 = int(n1[-1])
	var oct2 = int(n2[-1])
	
	var noteOrder = ["c","c-","d","d-","e","f","f-","g","g-","a","a-","b"]
	
	if oct1 > oct2:
		return true
	elif oct1 < oct2:
		return false
	else: #if they're in the same octave
		var noteNum1 = noteOrder.rfind(n1.left(-1))
		var noteNum2 = noteOrder.rfind(n2.left(-1))
		if noteNum1 >= noteNum2:
			return true
	return false
