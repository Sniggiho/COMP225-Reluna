extends Node2D
class_name Note

@export var detuneCents := 0 # the number of cents out of tune 
@export var noteName := "c3" # default note is c3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func centsToRatio(cents) -> float:
	return pow(2, cents/1200.0)

func setNoteByName(note: String) -> void:
	note.strip_escapes()
	note.to_lower()
	noteName = note
	
func getNoteName() -> String:
	return noteName
	
func setDetuneCents(cents) -> void:
	detuneCents = cents
	
func getDetuneCents() -> int:
	return detuneCents

func orientation() -> void:
	if(noteName[-1] > "4"):
		var sprite = $Button/Sprite2D
		sprite.set_flip_h(true)
		sprite.set_flip_v(true)
		var height = sprite.texture.get_height()
		sprite.set_offset(Vector2(0,height*0.55))
	
