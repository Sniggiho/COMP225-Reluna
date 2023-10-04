extends Node2D
class_name TuneCreator

@export var pathFollower : PathFollow2D
@export var tempNote : TextureRect

var list : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func cleanup() -> void:
	for note in list:
		note.queue_free()
