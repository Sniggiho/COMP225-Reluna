extends Node2D
class_name Note

var detuneCents := 0 # the number of cents out of tune 
var noteName := "c3" # default note is c3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setNoteByName(note: String) -> void:
	note.strip_escapes()
	note.to_lower()
	noteName = note
	
func getNoteName() -> String:
	return noteName
