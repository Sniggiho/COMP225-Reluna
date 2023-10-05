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
@onready var pathFollower = path.get_child(0)
@export var dummyNote : PackedScene # This is a dummy note of a dog sprite.
@export var note : PackedScene		# Real note. Button functionality and sound

@export var numNotes : int = 5
@export var debug : bool = true

var listOfNotes : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var dx : float = 1.0 / (numNotes-1)
	for i in range(numNotes):
		
		var note = dummyNote.instantiate()
		add_child(note)
		listOfNotes.append(note)
		note.global_position = pathFollower.position
		pathFollower.progress_ratio += dx
		




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generate() -> void:
	
	pass

func cleanup() -> void:
	for note in listOfNotes:
		note.queue_free()
