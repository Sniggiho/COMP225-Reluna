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
@export var minOct : int = 3

## The maximum octave of notes to generate
@export var maxOct : int = 5

## Direction of detune, that is sharp or flat or both.
## Sharp indicates increasing cents (detuneDirection =  1). 
## Flat indicates decreasing cents  (detuneDirection = -1). 
## Both means it could be either    (detuneDirection =  0).
@export var detuneDirection : int = 0

## TODO
@onready var feedbackWindow : PackedScene

## Path is passed to the tune creator
@export var path : Path2D

##
@export var musicStaff : MusicStaff

## 
var staffGapHeight : float


@onready var _tuneCreatorScene : PackedScene = preload("res://Scenes/TuneCreator/tune_creator.tscn")
var _tuneCreator : TuneCreator

## Will look like [false, true, false, false, ture], where the "true" positions have detuned notes
var listOfDetunedNotes : Array

## Randomly selects notes to be out of tune, storing this value in the listOfDetunedNotes class variable
func createListOfDetunedNotes() -> void:
	var detuneList = []
	for n in range(numNotes):
		detuneList.append(false)
		
	detuneList[0] = false # we require that the first note be out of tune
	
	var possibleIndices = range(1,numNotes)
	possibleIndices.shuffle()
	
	for i in range(numOutOfTune):
		detuneList[possibleIndices[i]] = true
	
	listOfDetunedNotes = detuneList
	print("list of detuned notes:", listOfDetunedNotes)
	pass

## Create a tune creator with the given parameters
func createTuneCreator() -> void:
	_tuneCreator = _tuneCreatorScene.instantiate()
	add_child(_tuneCreator)
	staffGapHeight = musicStaff.getLineHeight()
	_tuneCreator.lineHeight = staffGapHeight
	_tuneCreator.givePath(path)
	_tuneCreator.setupRand(numAccidentals, bySharp, minOct, maxOct, listOfDetunedNotes, detuneDirection, maxDetuneCents, minDetuneCents)
	
	
	pass

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
	
	## TODO
	if correct:
		print("Yay you were correct!")
	else:
		print("Aw, you were incorrect :(")

## Call to keep a level manager around and generate new list of detuned notes, tune creator, etc.
func _reset() -> void:
	path.get_child(0).progress_ratio = 0
	deleteTuneCreator()
	createListOfDetunedNotes()
	createTuneCreator()
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	if numOutOfTune>numNotes-1: # if we want more out of tune notes than we have notes, we set the number of detuned notes to the max possible
		numOutOfTune = numNotes-1
	createListOfDetunedNotes()
	createTuneCreator()
	
	print(_tuneCreator.lineHeight)
	print(listOfDetunedNotes)
	pass
