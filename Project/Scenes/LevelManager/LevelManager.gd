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
var numAccidentals : int = 0

## bySharp controls whether the accidentals will be sharps or flats. This will 
## impact which notes can occur and which icon (sharp or flat) to draw on the staff
var bySharp : bool = true

## Number of notes to spawn on screen
var numNotes : int = 5

## Number of notes that will be out of tune.
## Should be less then numNotes.
var numOutOfTune : int = 1

## The maximum number of cents the note can be out of tune.
var maxDetuneCents : int = 50

## The minimum number of cents the note can be out of tune.
var minDetuneCents : int = 5

## For a normal distribution, what will the average amount of detune be?
var averageDetune : int = 40

## Detune standard deviation
var detuneSD : float = 5.0

## Direction of detune, that is sharp or flat or both.
## Sharp indicates increasing cents (detuneDirection =  1). 
## Flat indicates decreasing cents  (detuneDirection = -1). 
## Both means it could be either    (detuneDirection =  0).
var detuneDirection : int = 0

## TODO
@onready var feedbackWindow : PackedScene

@onready var _tuneCreatorScene : PackedScene = preload("res://Scenes/TuneCreator/tune_creator.tscn")
var _tuneCreator : TuneCreator

## Will look like [0, 1, 0, 0, 1], where the 1 positions have detuned notes
var listOfDetunedNotes : Array

## Create a tune creator with the given parameters
func createTuneCreator() -> void:
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
	var playersSelectedNotes : Array = _tuneCreator.getSelectedNotes()
	
	if playersSelectedNotes.size() != listOfDetunedNotes.size():
		printerr("Somehow the tune creator and the level manager disagree on the number of notes")
	
	var correct : bool = listOfDetunedNotes.hash() == playersSelectedNotes.hash()
	
	## TODO
	if correct:
		print("Yay you were correct!")
	else:
		print("Aw, you were incorrect :(")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
