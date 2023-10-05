extends Node2D
class_name TuneCreator

@export var path : Path2D
@onready var pathFollower = path.get_child(0)
@export var dummyNote : PackedScene

@export var numNotes : int = 5

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

func cleanup() -> void:
	for note in listOfNotes:
		note.queue_free()
