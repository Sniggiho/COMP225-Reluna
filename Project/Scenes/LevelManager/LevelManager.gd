extends Node2D
class_name LevelManager
## The Level Manager manages the level (wow!). 
## 
## Handles the the level's parameters and communicates them to a TuneCreator that the 
## level manager creates. 
##
## The level manager handles the parameters for the spawning of notes by TuneCreator. 
## 
## For the tutorial levels, we have a series of level managers with the specific 
## parameters we wish for. 
##
## For the freeplay levels, the level manager will persist but it will create a new tuneCreator
##
## The Level Manager will also be responsible for spawning the feedback window

## Number of accidentals, refer to the circle of fifths. Number of flat or sharp notes
@export var numAccidentals : int = 3

## bySharp controls whether the accidentals will be sharps or flats. This will 
## impact which notes can occur and which icon (sharp or flat) to draw on the staff
@export var bySharp : bool = true

## Number of notes to spawn on screen
@export var numNotes : int = 5

## Number of notes that will be out of tune.
## Should be less then numNotes.
@export var numOutOfTune : int = 2

## The maximum number of cents the note can be out of tune.
@export var maxDetuneCents : int = 50

## The minimum number of cents the note can be out of tune.
@export var minDetuneCents : int = 5

## The minimum octave of notes to generate
@export var lowestNote : String = "c4"

## The maximum octave of notes to generate
@export var highestNote : String = "c6"

## Direction of detune, that is sharp or flat or both.
## Sharp indicates increasing cents (detuneDirection =  1). 
## Flat indicates decreasing cents  (detuneDirection = -1). 
## Both means it could be either    (detuneDirection =  0).
@export var detuneDirection : int = 0

## TODO
@onready var feedbackWindow : PackedScene


##
@export var musicStaff : MusicStaff

## Path is passed to the tune creator
@onready var path : Path2D

## 
var staffGapHeight : float

@export var bpm : int = 120

@onready var _tuneCreatorScene : PackedScene = preload("res://Scenes/TuneCreator/tune_creator.tscn")
var _tuneCreator : TuneCreator

## Will look like [false, true, false, false, ture], where the "true" positions have detuned notes
var listOfDetunedNotes : Array

## Used in tutorial mode, a list of the notes comprising the melody
var notes : Array 

## keeps track of the attempts
var attempts : int

## Randomly selects notes to be out of tune, storing this value in the listOfDetunedNotes class variable
func createListOfDetunedNotes(numNotes:int) -> void:
	var detuneList = []
	for n in range(numNotes):
		detuneList.append(false)
		
	detuneList[0] = false # we require that the first note not be out of tune
	
	var possibleIndices = range(1,numNotes)
	possibleIndices.shuffle()
	
	for i in range(numOutOfTune):
		detuneList[possibleIndices[i]] = true
	
	listOfDetunedNotes = detuneList

## Create a tune creator with the given parameters
func createTuneCreator(tutorial : bool) -> void:
	_tuneCreator = _tuneCreatorScene.instantiate()
	add_child(_tuneCreator)
	staffGapHeight = musicStaff.getLineHeight()
	_tuneCreator.lineHeight = staffGapHeight
	_tuneCreator.givePath(path)
	if tutorial:
		_tuneCreator.setupFullManual(GLevelData.notes, GLevelData.bySharps, GLevelData.detunedAmountsList)
	else:
		# TODO: Implement num accidents, bySharp to freeplay settings
		_tuneCreator.setupRand(GLevelData.numAccidentals, GLevelData.bySharps, 
							   GLevelData.lowestNote, GLevelData.highestNote, 
							   listOfDetunedNotes, GLevelData.detuneDir, 
							   GLevelData.maxDetuneCents, GLevelData.minDetuneCents)
	

## Delete the tune creator (ideally you're going to create a new one with 
## similar parameters after this)
func deleteTuneCreator() -> void:
	if _tuneCreator:
		_tuneCreator.queue_free()
	else:
		printerr("You just tried to delete a tune creator that didn't exist--Why'd that happen?")

## Compare the player's selected notes to the correct solution
func checkPlayerInput():
	var listOfNotes : Array = _tuneCreator.getListOfNotes()
	# will look like [0, 1, 0, 0, 1]. Hopefully it's the same as the correct answer
	var playersSelectedNotes : Array = _tuneCreator.retrieveSelectedNotes()
	
	if playersSelectedNotes.size() != listOfDetunedNotes.size():
		printerr("Somehow the tune creator and the level manager disagree on the number of notes")
	
	var correct : bool = listOfDetunedNotes.hash() == playersSelectedNotes.hash()
	
	var correctText = get_parent().find_child("Feedback").find_child("Correct")
	var incorrectText = get_parent().find_child("Feedback").find_child("Incorrect")
	var attemptText = get_parent().find_child('Feedback').find_child('Attempts')
	var returnButton = get_parent().find_child("Feedback").find_child("ReturnButton")
	var nextButton = get_parent().find_child("Feedback").find_child("NextButton")
	
	## if it is correct
	if correct:
		print("Yay you were correct!")
		attempts = attempts + 1
		attemptText.text = "[center]Attempts: " + str(attempts)
		attempts = 0
		correctText.visible = true
		incorrectText.visible = false
		returnButton.visible = false
		nextButton.visible = true
	## not correct
	else:
		attempts = attempts + 1
		attemptText.text = "[center]Attempts: " + str(attempts)
		print("Aw, you were incorrect :(")
		incorrectText.visible = true
		correctText.visible = false
		returnButton.visible = true
		nextButton.visible = false
		

func getNoteCountBPM() -> Array:
	return [numNotes, bpm]

## Call to keep a level manager around and generate new list of detuned notes, tune creator, etc.
func _reset():
	if GLevelData.tutorial: # if it's a tutorial, go to the next one
		# TODO: this really shouldn't be in the reset button
		var nextTutNum = GLevelData.currentTut + 1
		var nextTut = GTutorialMenu.tutMenu[nextTutNum]
		
		GLevelData.tutorial = true
		GLevelData.bySharps = nextTut.bySharps
		GLevelData.notes = nextTut.notes
		GLevelData.detunedAmountsList = nextTut.detunedAmountsList
		GLevelData.bpm = nextTut.bpm
		GLevelData.numAccidentals = nextTut.numAccidentals
		GLevelData.numNotes = len(nextTut.notes)
		GLevelData.displayText = nextTut.displayText
		
		GLevelData.currentTut = GLevelData.currentTut + 1

		SceneTransition.change_scene("res://Scenes/firstScene.tscn")
	else:
		GLevelData.displayText = self._generateInstructionText()
		self.get_parent().find_child("DisplayText").refresh()
		
		path.get_child(0).progress_ratio = 0
		deleteTuneCreator()
		createListOfDetunedNotes(GLevelData.numNotes)
		createTuneCreator(false)

func _generateInstructionText() -> String:
	var instructionText = "Select "
	
	if GLevelData.detuneDir == -1: # flat only
		instructionText += str(GLevelData.numDetunedNotes) + " flat note"
	elif GLevelData.detuneDir == 1: # sharp only
		instructionText += str(GLevelData.numDetunedNotes) + " sharp note"
	else: # both flat and sharp
		instructionText += str(GLevelData.numDetunedNotes) + " out of tune note"
		
	if GLevelData.numDetunedNotes >1:
		instructionText += "s"
	return instructionText

# Called when the node enters the scene tree for the first time.
func _ready():
	path = musicStaff.get_child(1)
		
	if GLevelData.tutorial: # if we're currently in a tutorial level
		# first we figure out the list of detuned notes
		var detuneList = []
		for n in GLevelData.detunedAmountsList:
			if n: 
				detuneList.append(true)
			else:
				detuneList.append(false)
		listOfDetunedNotes = detuneList
		# then we make the tune creator
		createTuneCreator(true)
		musicStaff.setNotesBPM(GLevelData.numNotes, GLevelData.bpm) # TODO we don't need this?
	else: 
		GLevelData.displayText = self._generateInstructionText()
		#TODO: do we need all these?
		numNotes = GLevelData.numNotes
		numOutOfTune = GLevelData.numDetunedNotes
		minDetuneCents = GLevelData.minDetuneCents
		maxDetuneCents = GLevelData.maxDetuneCents
		lowestNote = GLevelData.lowestNote
		highestNote = GLevelData.highestNote
		detuneDirection = GLevelData.detuneDir
		numAccidentals = GLevelData.numAccidentals
		bySharp = GLevelData.bySharps
		createListOfDetunedNotes(GLevelData.numNotes)
		createTuneCreator(false)
		print(GLevelData.bpm)
		musicStaff.setNotesBPM(GLevelData.numNotes, GLevelData.bpm)
	


func _on_return_button_pressed():
	SceneTransition.change_scene(GLevelData.prevScene)
	
func getTuneCreator() -> TuneCreator:
	return _tuneCreator



