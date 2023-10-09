extends Node2D
class_name TuneCreator

# The tune creator is an object that handles, in our main scene, the generation of notes
# 	- Must be given a Path2D in the inspector (this Path2D must have its PathFollow2D).
#	- Then, the TuneCreator be given the scene for the note.
#
# For n notes, the tune creator divides the path into equal chunks
# A note is created, then added as a child of the TuneCreator.
# 	NOTE: the note's position is edited with *global* position

@export var path : Path2D
@onready var pathFollower : PathFollow2D = path.get_child(0)
@export var dummyNote : PackedScene # This is a dummy note of a dog sprite.
@export var noteScene : PackedScene # Real note. Button functionality and sound

@export var numNotes : int = 5
@export var debug : bool = true

# Indicates the list of notes that are put on the screen
var listOfNotes : Array

# Pregenerated list of all possible notes 
var allPossibleNotes : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	allPossibleNotes = _createPossibleNoteArray(3,5)
	print(allPossibleNotes)
	
	var dx : float = 1.0 / (numNotes-1)
	dx = 1.0 / numNotes
	
	for i in range(numNotes):
		pathFollower.progress_ratio += dx
		var note = noteScene.instantiate()
		note.setDetuneCents(randi_range(-50,50))
		note.setNoteByName(allPossibleNotes[randi() % allPossibleNotes.size()])
		
		add_child(note)
		listOfNotes.append(note)
		note.global_position = pathFollower.position
		




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generate() -> void:
	
	pass


func cleanup() -> void:
	for note in listOfNotes:
		note.queue_free()

func _createPossibleNoteArray(lowOct, highOct)-> Array:
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
	
