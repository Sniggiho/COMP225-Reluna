extends Node2D
class_name LevelManager
## The Level Manager manages the level (wow!). 
## 
## Handles the the level's parameters and communicates them to the Tune Creator
##
## The Level Manager will also be responsible for spawning the feedback window

## TODO
@export var feedbackWindow : PackedScene

@export var tuneCreator : TuneCreator
var listOfNotes : Array

## Will look like [0, 1, 0, 0, 1], where the 1 positions have detuned notes
var listOfDetunedNotes : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	if not tuneCreator:
		printerr("No tune creator provided to level manager!")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
## Compare the player's selected notes to the correct solution
func check():
	listOfNotes = tuneCreator.getListOfNotes()
	var playersSelectedNotes : Array = tuneCreator.getSelectedNotes()
	
	var correct : bool = true
	
	
	
	if correct:
		print("Yay you were correct!")
	else:
		print("Aw, you were incorrect :(")
	
	pass
