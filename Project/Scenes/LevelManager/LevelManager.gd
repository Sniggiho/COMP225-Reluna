extends Node2D
class_name LevelManager

"""
The Level Manager manages the level (wow!). 
Handles the generation of the tune and then commands the tune creator
Checks the players input against the expected solution. 
"""

@export var tuneCreator : TuneCreator
var listOfNotes : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	if not tuneCreator:
		printerr("No tune creator provided to level manager!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
"""
Check
"""
func check():
	pass
